package com.paiad.wemedia.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.paiad.apis.article.IArticleClient;
import com.paiad.model.article.dtos.ArticleDto;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.pojos.WmChannel;
import com.paiad.model.wemedia.pojos.WmNews;
import com.paiad.model.wemedia.pojos.WmSensitive;
import com.paiad.model.wemedia.pojos.WmUser;
import com.paiad.utils.common.SensitiveWordUtil;
import com.paiad.wemedia.mapper.WmChannelMapper;
import com.paiad.wemedia.mapper.WmNewsMapper;
import com.paiad.wemedia.mapper.WmSensitiveMapper;
import com.paiad.wemedia.mapper.WmUserMapper;
import com.paiad.wemedia.service.WmNewsAutoScanService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 自媒体文章自动审核服务实现 - 最小化版本
 * 仅使用敏感词库进行基础审核,不依赖第三方服务
 */
@Service
@Slf4j
@Transactional
public class WmNewsAutoScanServiceImpl implements WmNewsAutoScanService {

    @Autowired
    private WmNewsMapper wmNewsMapper;

    @Autowired
    private WmSensitiveMapper wmSensitiveMapper;

    @Resource
    private IArticleClient articleClient;

    @Autowired
    private WmChannelMapper wmChannelMapper;

    @Autowired
    private WmUserMapper wmUserMapper;

    /**
     * 自媒体文章自动审核
     *
     * @param id 自媒体文章id
     */
    @Override
    @Async // 标明当前方法是一个异步方法
    public void autoScanWmNews(Integer id) {
        log.info("开始自动审核文章,文章ID: {}", id);

        // 1. 查询自媒体文章
        WmNews wmNews = wmNewsMapper.selectById(id);
        if (wmNews == null) {
            log.error("文章不存在,ID: {}", id);
            throw new RuntimeException("WmNewsAutoScanServiceImpl-文章不存在");
        }

        // 2. 只审核提交状态的文章
        if (wmNews.getStatus().equals(WmNews.Status.SUBMIT.getCode())) {
            // 从内容中提取纯文本内容和图片
            Map<String, Object> textAndImages = handleTextAndImages(wmNews);

            // 3. 敏感词审核(包含标题和内容)
            String fullContent = wmNews.getTitle() + " " + textAndImages.get("content");
            boolean isSensitive = handleSensitiveScan(fullContent, wmNews);
            if (!isSensitive) {
                log.warn("文章审核失败,包含敏感词,文章ID: {}", id);
                return;
            }

            // 4. 基础图片验证(检查图片URL是否有效)
            boolean isImageValid = handleImageValidation((List<String>) textAndImages.get("images"), wmNews);
            if (!isImageValid) {
                log.warn("文章审核失败,图片验证不通过,文章ID: {}", id);
                return;
            }

            // 5. 审核成功,保存app端的相关文章数据
            ResponseResult responseResult = saveAppArticle(wmNews);

            // 检查返回结果是否为空
            if (responseResult == null) {
                log.error("保存app端文章数据失败,返回结果为null,文章ID: {}", id);
                updateWmNews(wmNews, (short) 3, "审核失败:保存文章数据时服务调用失败");
                throw new RuntimeException("WmNewsAutoScanServiceImpl-文章审核,保存app端相关文章数据失败:返回结果为null");
            }

            if (!responseResult.getCode().equals(200)) {
                log.error("保存app端文章数据失败,文章ID: {}, 错误码: {}, 错误信息: {}",
                        id, responseResult.getCode(), responseResult.getErrorMessage());
                updateWmNews(wmNews, (short) 3, "审核失败:" + responseResult.getErrorMessage());
                throw new RuntimeException("WmNewsAutoScanServiceImpl-文章审核,保存app端相关文章数据失败");
            }

            // 6. 回填article_id
            wmNews.setArticleId((Long) responseResult.getData());
            updateWmNews(wmNews, (short) 9, "审核成功");
            log.info("文章审核成功,文章ID: {}, Article ID: {}", id, responseResult.getData());
        }
    }

    /**
     * 敏感词审核
     *
     * @param content 待审核内容
     * @param wmNews  文章对象
     * @return true-通过审核, false-未通过审核
     */
    private boolean handleSensitiveScan(String content, WmNews wmNews) {
        if (StringUtils.isBlank(content)) {
            return true;
        }

        try {
            // 获取所有的敏感词
            List<WmSensitive> wmSensitives = wmSensitiveMapper.selectList(
                    Wrappers.<WmSensitive>lambdaQuery().select(WmSensitive::getSensitives));
            List<String> sensitiveList = wmSensitives.stream()
                    .map(WmSensitive::getSensitives)
                    .collect(Collectors.toList());

            // 初始化敏感词库
            SensitiveWordUtil.initMap(sensitiveList);

            // 查看文章中是否包含敏感词
            Map<String, Integer> matchedWords = SensitiveWordUtil.matchWords(content);
            if (matchedWords.size() > 0) {
                log.warn("检测到敏感词: {}", matchedWords);
                updateWmNews(wmNews, (short) 2, "当前文章中存在违规内容: " + matchedWords.keySet());
                return false;
            }

            return true;
        } catch (Exception e) {
            log.error("敏感词审核异常", e);
            updateWmNews(wmNews, (short) 2, "审核异常: " + e.getMessage());
            return false;
        }
    }

    /**
     * 基础图片验证
     * 简化版本:只检查图片URL是否为空,不进行实际的图片内容审核
     *
     * @param images 图片URL列表
     * @param wmNews 文章对象
     * @return true-验证通过, false-验证失败
     */
    private boolean handleImageValidation(List<String> images, WmNews wmNews) {
        if (images == null || images.isEmpty()) {
            log.info("文章无图片,跳过图片验证");
            return true;
        }

        try {
            // 图片去重
            images = images.stream().distinct().collect(Collectors.toList());
            log.info("待验证图片数量: {}", images.size());

            // 基础验证:检查URL是否有效
            for (String imageUrl : images) {
                if (StringUtils.isBlank(imageUrl)) {
                    log.warn("检测到空图片URL");
                    updateWmNews(wmNews, (short) 2, "图片URL无效");
                    return false;
                }
            }

            log.info("图片验证通过");
            return true;

        } catch (Exception e) {
            log.error("图片验证异常", e);
            updateWmNews(wmNews, (short) 2, "图片验证异常: " + e.getMessage());
            return false;
        }
    }

    /**
     * 保存app端相关的文章数据
     *
     * @param wmNews 自媒体文章
     * @return 保存结果
     */
    private ResponseResult saveAppArticle(WmNews wmNews) {
        try {
            ArticleDto dto = new ArticleDto();

            // 属性拷贝
            BeanUtils.copyProperties(wmNews, dto);

            // 文章的布局
            dto.setLayout(wmNews.getType());

            // 频道信息
            WmChannel wmChannel = wmChannelMapper.selectById(wmNews.getChannelId());
            if (wmChannel != null) {
                dto.setChannelName(wmChannel.getName());
            }

            // 作者信息
            dto.setAuthorId(wmNews.getUserId().longValue());
            WmUser wmUser = wmUserMapper.selectById(wmNews.getUserId());
            if (wmUser != null) {
                dto.setAuthorName(wmUser.getName());
            }

            // 设置文章id(如果是更新)
            if (wmNews.getArticleId() != null) {
                dto.setId(wmNews.getArticleId());
            }
            dto.setCreatedTime(new Date());

            log.info("准备调用文章服务保存文章,文章ID: {}, 标题: {}", wmNews.getId(), wmNews.getTitle());

            // 调用文章服务保存
            ResponseResult responseResult = articleClient.saveArticle(dto);

            log.info("文章服务调用完成,返回结果: {}", responseResult);

            return responseResult;
        } catch (Exception e) {
            log.error("保存app端文章数据异常,文章ID: {}", wmNews.getId(), e);
            // 返回一个错误的 ResponseResult 而不是 null
            return ResponseResult.errorResult(500, "保存文章失败: " + e.getMessage());
        }
    }

    /**
     * 更新文章状态
     *
     * @param wmNews 文章对象
     * @param status 状态码
     * @param reason 原因
     */
    private void updateWmNews(WmNews wmNews, short status, String reason) {
        wmNews.setStatus(status);
        wmNews.setReason(reason);
        wmNewsMapper.updateById(wmNews);
    }

    /**
     * 从自媒体文章的内容中提取文本和图片
     *
     * @param wmNews 文章对象
     * @return Map包含content(文本)和images(图片列表)
     */
    private Map<String, Object> handleTextAndImages(WmNews wmNews) {
        // 存储纯文本内容
        StringBuilder stringBuilder = new StringBuilder();
        List<String> images = new ArrayList<>();

        // 1. 从文章内容中提取文本和图片
        if (StringUtils.isNotBlank(wmNews.getContent())) {
            List<Map> maps = JSONArray.parseArray(wmNews.getContent(), Map.class);
            for (Map map : maps) {
                if ("text".equals(map.get("type"))) {
                    stringBuilder.append(map.get("value")).append(" ");
                }

                if ("image".equals(map.get("type"))) {
                    images.add((String) map.get("value"));
                }
            }
        }

        // 2. 提取文章的封面图片
        if (StringUtils.isNotBlank(wmNews.getImages())) {
            String[] split = wmNews.getImages().split(",");
            images.addAll(Arrays.asList(split));
        }

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("content", stringBuilder.toString().trim());
        resultMap.put("images", images);

        log.info("提取文本长度: {}, 图片数量: {}", stringBuilder.length(), images.size());
        return resultMap;
    }
}
