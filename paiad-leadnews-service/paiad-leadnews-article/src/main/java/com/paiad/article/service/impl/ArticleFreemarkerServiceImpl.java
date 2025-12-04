package com.paiad.article.service.impl;

import com.alibaba.fastjson.JSONArray;
import com.paiad.article.mapper.ApArticleMapper;
import com.paiad.article.service.ArticleFreemarkerService;
import com.paiad.file.service.FileStorageService;
import com.paiad.model.article.pojos.ApArticle;
import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

@Service
@Slf4j
@Transactional
public class ArticleFreemarkerServiceImpl implements ArticleFreemarkerService {
    @Autowired
    private Configuration configuration;

    @Autowired
    private FileStorageService fileStorageService;

    @Autowired
    private ApArticleMapper apArticleMapper;

    @Async
    @Override
    public void buildArticleToMinIO(ApArticle apArticle, String content) {
        if (StringUtils.isNotBlank(content)) {
            // 1.文章内容通过freemarker生成html文件
            StringWriter out = new StringWriter();
            Template template = null;
            try {
                template = configuration.getTemplate("article.ftl");
                Map<String, Object> contentDataModel = new HashMap<>();
                contentDataModel.put("content", JSONArray.parseArray(content));

                template.process(contentDataModel, out);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }

            // 2.把html文件上传到minio中
            InputStream in = new ByteArrayInputStream(out.toString().getBytes());
            String path = fileStorageService.uploadHtmlFile("", apArticle.getId() + ".html", in);

            // 3.修改ap_article表，保存static_url字段
            ApArticle article = new ApArticle();
            article.setId(apArticle.getId());
            article.setStaticUrl(path);
            apArticleMapper.updateById(article);
        }
    }
}
