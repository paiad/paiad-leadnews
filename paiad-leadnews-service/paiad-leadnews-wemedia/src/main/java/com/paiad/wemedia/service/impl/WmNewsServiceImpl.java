package com.paiad.wemedia.service.impl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.paiad.apis.article.IArticleClient;
import com.paiad.common.constants.WemediaConstants;
import com.paiad.common.constants.WmNewsMessageConstants;
import com.paiad.common.exception.CustomException;
import com.paiad.model.common.dtos.PageResponseResult;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.common.enums.AppHttpCodeEnum;
import com.paiad.model.wemedia.dtos.WmNewsDto;
import com.paiad.model.wemedia.dtos.WmNewsPageReqDto;
import com.paiad.model.wemedia.pojos.WmMaterial;
import com.paiad.model.wemedia.pojos.WmNews;
import com.paiad.model.wemedia.pojos.WmNewsMaterial;
import com.paiad.utils.thread.WmThreadLocalUtil;
import com.paiad.wemedia.mapper.WmMaterialMapper;
import com.paiad.wemedia.mapper.WmNewsMapper;
import com.paiad.wemedia.mapper.WmNewsMaterialMapper;
import com.paiad.wemedia.service.WmNewsAutoScanService;
import com.paiad.wemedia.service.WmNewsService;
import com.paiad.wemedia.service.WmNewsTaskService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.kafka.core.KafkaTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.TransactionSynchronization;
import org.springframework.transaction.support.TransactionSynchronizationManager;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

@Service
@Slf4j
@Transactional
public class WmNewsServiceImpl extends ServiceImpl<WmNewsMapper, WmNews> implements WmNewsService {

    /**
     * 条件查询文章列表
     *
     * @param dto
     * @return
     */
    @Override
    public ResponseResult findList(WmNewsPageReqDto dto) {
        // 1.检查参数
        // 分页检查
        dto.checkParam();

        // 2.分页条件查询
        IPage page = new Page(dto.getPage(), dto.getSize());
        LambdaQueryWrapper<WmNews> lambdaQueryWrapper = new LambdaQueryWrapper();
        // 状态精确查询
        if (dto.getStatus() != null) {
            lambdaQueryWrapper.eq(WmNews::getStatus, dto.getStatus());
        }

        // 频道精确查询
        if (dto.getChannelId() != null) {
            lambdaQueryWrapper.eq(WmNews::getChannelId, dto.getChannelId());
        }

        // 时间范围查询
        if (dto.getBeginPubDate() != null && dto.getEndPubDate() != null) {
            lambdaQueryWrapper.between(WmNews::getPublishTime, dto.getBeginPubDate(), dto.getEndPubDate());
        }

        // 关键字的模糊查询
        if (StringUtils.isNotBlank(dto.getKeyword())) {
            lambdaQueryWrapper.like(WmNews::getTitle, dto.getKeyword());
        }

        // 查询当前登录人的文章
        lambdaQueryWrapper.eq(WmNews::getUserId, WmThreadLocalUtil.getUser().getId());

        // 按照发布时间倒序查询
        lambdaQueryWrapper.orderByDesc(WmNews::getPublishTime);

        page = page(page, lambdaQueryWrapper);

        // 3.结果返回
        ResponseResult responseResult = new PageResponseResult(dto.getPage(), dto.getSize(), (int) page.getTotal());
        responseResult.setData(page.getRecords());

        return responseResult;
    }

    @Autowired
    private WmNewsAutoScanService wmNewsAutoScanService;

    @Autowired
    private WmNewsTaskService wmNewsTaskService;

    /**
     * 发布修改文章或保存为草稿
     *
     * @param dto
     * @return
     */
    @Override
    public ResponseResult submitNews(WmNewsDto dto) {

        // 0.条件判断
        if (dto == null || dto.getContent() == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        // 1.保存或修改文章

        WmNews wmNews = new WmNews();
        // 属性拷贝 属性名词和类型相同才能拷贝
        BeanUtils.copyProperties(dto, wmNews);
        // 封面图片 list---> string
        if (dto.getImages() != null && dto.getImages().size() > 0) {
            // [1dddfsd.jpg,sdlfjldk.jpg]--> 1dddfsd.jpg,sdlfjldk.jpg
            String imageStr = StringUtils.join(dto.getImages(), ",");
            wmNews.setImages(imageStr);
        }
        // 如果当前封面类型为自动 -1
        if (dto.getType().equals(WemediaConstants.WM_NEWS_TYPE_AUTO)) {
            wmNews.setType(null);
        }

        saveOrUpdateWmNews(wmNews);

        // 2.判断是否为草稿 如果为草稿结束当前方法
        if (dto.getStatus().equals(WmNews.Status.NORMAL.getCode())) {
            return ResponseResult.okResult(AppHttpCodeEnum.SUCCESS);
        }

        // 3.不是草稿，保存文章内容图片与素材的关系
        // 获取到文章内容中的图片信息
        List<String> materials = ectractUrlInfo(dto.getContent());
        saveRelativeInfoForContent(materials, wmNews.getId());

        // 4.不是草稿，保存文章封面图片与素材的关系，如果当前布局是自动，需要匹配封面图片
        saveRelativeInfoForCover(dto, wmNews, materials);

        // 审核文章 - 在事务提交后异步执行
        final Integer newsId = wmNews.getId();
        TransactionSynchronizationManager.registerSynchronization(new TransactionSynchronization() {
            @Override
            public void afterCommit() {
                // 事务提交后再触发异步审核，确保数据已经持久化
                log.info("事务已提交，开始异步审核文章，ID: {}", newsId);
//                wmNewsAutoScanService.autoScanWmNews(newsId);
                wmNewsTaskService.addNewsToTask(wmNews.getId(), wmNews.getPublishTime());
            }
        });

        return ResponseResult.okResult(AppHttpCodeEnum.SUCCESS);

    }

    /**
     * 第一个功能：如果当前封面类型为自动，则设置封面类型的数据
     * 匹配规则：
     * 1，如果内容图片大于等于1，小于3 单图 type 1
     * 2，如果内容图片大于等于3 多图 type 3
     * 3，如果内容没有图片，无图 type 0
     * <p>
     * 第二个功能：保存封面图片与素材的关系
     *
     * @param dto
     * @param wmNews
     * @param materials
     */
    private void saveRelativeInfoForCover(WmNewsDto dto, WmNews wmNews, List<String> materials) {

        List<String> images = dto.getImages();

        // 如果当前封面类型为自动，则设置封面类型的数据
        if (dto.getType().equals(WemediaConstants.WM_NEWS_TYPE_AUTO)) {
            // 多图
            if (materials.size() >= 3) {
                wmNews.setType(WemediaConstants.WM_NEWS_MANY_IMAGE);
                images = materials.stream().limit(3).collect(Collectors.toList());
            } else if (materials.size() >= 1 && materials.size() < 3) {
                // 单图
                wmNews.setType(WemediaConstants.WM_NEWS_SINGLE_IMAGE);
                images = materials.stream().limit(1).collect(Collectors.toList());
            } else {
                // 无图
                wmNews.setType(WemediaConstants.WM_NEWS_NONE_IMAGE);
            }

            // 修改文章
            if (images != null && images.size() > 0) {
                wmNews.setImages(StringUtils.join(images, ","));
            }
            updateById(wmNews);
        }
        if (images != null && images.size() > 0) {
            saveRelativeInfo(images, wmNews.getId(), WemediaConstants.WM_COVER_REFERENCE);
        }

    }

    /**
     * 处理文章内容图片与素材的关系
     *
     * @param materials
     * @param newsId
     */
    private void saveRelativeInfoForContent(List<String> materials, Integer newsId) {
        saveRelativeInfo(materials, newsId, WemediaConstants.WM_CONTENT_REFERENCE);
    }

    @Autowired
    private WmMaterialMapper wmMaterialMapper;

    /**
     * 保存文章图片与素材的关系到数据库中
     *
     * @param materials
     * @param newsId
     * @param type
     */
    private void saveRelativeInfo(List<String> materials, Integer newsId, Short type) {
        if (materials != null && !materials.isEmpty()) {
            // 通过图片的url查询素材的id
            List<WmMaterial> dbMaterials = wmMaterialMapper
                    .selectList(Wrappers.<WmMaterial>lambdaQuery().in(WmMaterial::getUrl, materials));

            // 判断素材是否有效
            if (dbMaterials == null || dbMaterials.size() == 0) {
                // 手动抛出异常 第一个功能：能够提示调用者素材失效了，第二个功能，进行数据的回滚
                throw new CustomException(AppHttpCodeEnum.MATERIASL_REFERENCE_FAIL);
            }

            if (materials.size() != dbMaterials.size()) {
                throw new CustomException(AppHttpCodeEnum.MATERIASL_REFERENCE_FAIL);
            }

            List<Integer> idList = dbMaterials.stream().map(WmMaterial::getId).collect(Collectors.toList());

            // 批量保存
            wmNewsMaterialMapper.saveRelations(idList, newsId, type);
        }

    }

    /**
     * 提取文章内容中的图片信息
     *
     * @param content
     * @return
     */
    private List<String> ectractUrlInfo(String content) {
        List<String> materials = new ArrayList<>();

        List<Map> maps = JSON.parseArray(content, Map.class);
        for (Map map : maps) {
            if (map.get("type").equals("image")) {
                String imgUrl = (String) map.get("value");
                materials.add(imgUrl);
            }
        }

        return materials;
    }

    @Autowired
    private WmNewsMaterialMapper wmNewsMaterialMapper;

    /**
     * 保存或修改文章
     *
     * @param wmNews
     */
    private void saveOrUpdateWmNews(WmNews wmNews) {
        // 补全属性
        wmNews.setUserId(WmThreadLocalUtil.getUser().getId());
        wmNews.setCreatedTime(new Date());
        wmNews.setSubmitedTime(new Date());
        wmNews.setEnable((short) 1);// 默认上架

        if (wmNews.getPublishTime() == null) {
            // 如果前端没有传递发布时间，则默认为当前时间（即立即发布）
            // publishTime 表示文章的"预期发布时间"
            // 对于定时发布，前端会传递一个未来的时间
            // 对于立即发布，这里设置为当前时间，与提交时间一致是正常的
            wmNews.setPublishTime(new Date());
        }

        if (wmNews.getId() == null) {
            // 保存
            save(wmNews);
        } else {
            // 修改
            // 删除文章图片与素材的关系
            wmNewsMaterialMapper
                    .delete(Wrappers.<WmNewsMaterial>lambdaQuery().eq(WmNewsMaterial::getNewsId, wmNews.getId()));
            updateById(wmNews);
        }

    }

    /**
     * 根据ID获取文章详情
     *
     * @param id 文章ID
     * @return
     */
    @Override
    public ResponseResult getNewsById(Integer id) {
        // 1.检查参数
        if (id == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        // 2.查询文章
        WmNews wmNews = getById(id);
        if (wmNews == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_EXIST, "文章不存在");
        }

        // 3.判断是否是当前用户的文章
        if (!wmNews.getUserId().equals(WmThreadLocalUtil.getUser().getId())) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_ALLOW, "不能查看其他用户的文章");
        }

        // 4.返回结果
        return ResponseResult.okResult(wmNews);
    }

    @Resource
    private IArticleClient articleClient;

    /**
     * 删除文章
     *
     * @param id 文章ID
     * @return
     */
    @Override
    public ResponseResult deleteNews(Integer id) {
        // 1.检查参数
        if (id == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        // 2.查询文章
        WmNews wmNews = getById(id);
        if (wmNews == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_EXIST, "文章不存在");
        }

        // 3.判断是否是当前用户的文章
        if (!wmNews.getUserId().equals(WmThreadLocalUtil.getUser().getId())) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_ALLOW, "不能删除其他用户的文章");
        }

        // 4.判断文章状态，已发布的文章不能删除
        if (wmNews.getStatus().equals(WmNews.Status.PUBLISHED.getCode()) && wmNews.getArticleId() != null) {
            // 删除APP端文章
            articleClient.deleteArticle(wmNews.getArticleId());
        }

        // 5.删除文章与素材的关系
        wmNewsMaterialMapper.delete(Wrappers.<WmNewsMaterial>lambdaQuery().eq(WmNewsMaterial::getNewsId, id));

        // 6.删除文章
        removeById(id);

        // 7.返回结果
        return ResponseResult.okResult(AppHttpCodeEnum.SUCCESS);
    }

    /**
     * 批量删除文章
     *
     * @param ids 文章ID列表
     * @return
     */
    @Override
    public ResponseResult batchDeleteNews(List<Integer> ids) {
        // 1.检查参数
        if (ids == null || ids.isEmpty()) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        // 2.逐个删除文章
        int successCount = 0;
        int failCount = 0;
        for (Integer id : ids) {
            ResponseResult result = deleteNews(id);
            if (result.getCode() == AppHttpCodeEnum.SUCCESS.getCode()) {
                successCount++;
            } else {
                failCount++;
                log.warn("删除文章失败，ID: {}, 原因: {}", id, result.getErrorMessage());
            }
        }

        // 3.返回结果
        if (failCount == 0) {
            return ResponseResult.okResult(AppHttpCodeEnum.SUCCESS);
        } else if (successCount == 0) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_ALLOW, "所有文章删除失败");
        } else {
            return ResponseResult.okResult("成功删除 " + successCount + " 篇文章，" + failCount + " 篇删除失败");
        }
    }

    @Autowired
    private KafkaTemplate<String, String> kafkaTemplate;

    /**
     * 文章的上下架
     *
     * @param dto
     * @return
     */
    @Override
    public ResponseResult downOrUp(WmNewsDto dto) {
        //1.检查参数
        if (dto.getId() == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        //2.查询文章
        WmNews wmNews = getById(dto.getId());
        if (wmNews == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_EXIST, "文章不存在");
        }

        //3.判断文章是否已发布
        if (!wmNews.getStatus().equals(WmNews.Status.PUBLISHED.getCode())) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID, "当前文章不是发布状态，不能上下架");
        }

        //4.修改文章enable
        if (dto.getEnable() != null && dto.getEnable() > -1 && dto.getEnable() < 2) {
            update(Wrappers.<WmNews>lambdaUpdate().set(WmNews::getEnable, dto.getEnable())
                    .eq(WmNews::getId, wmNews.getId()));

            if (wmNews.getArticleId() != null) {
                //发送消息，通知article修改文章的配置
                Map<String, Object> map = new HashMap<>();
                map.put("articleId", wmNews.getArticleId());
                map.put("enable", dto.getEnable());
                kafkaTemplate.send(WmNewsMessageConstants.WM_NEWS_UP_OR_DOWN_TOPIC, JSON.toJSONString(map));
            }

        }
        return ResponseResult.okResult(AppHttpCodeEnum.SUCCESS);
    }

}
