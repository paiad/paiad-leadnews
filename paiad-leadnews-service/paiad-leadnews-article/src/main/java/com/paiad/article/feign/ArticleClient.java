package com.paiad.article.feign;

import com.paiad.apis.article.IArticleClient;
import com.paiad.article.service.ApArticleService;
import com.paiad.model.article.dtos.ArticleDto;
import com.paiad.model.common.dtos.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class ArticleClient implements IArticleClient {

    @Autowired
    private ApArticleService apArticleService;

    @PostMapping("/api/v1/article/save")
    @Override
    public ResponseResult saveArticle(@RequestBody ArticleDto dto) {
        return apArticleService.saveArticle(dto);
    }

    @PostMapping("/api/v1/article/delete")
    @Override
    public ResponseResult deleteArticle(@RequestBody Long id) {
        return apArticleService.deleteArticle(id);
    }
}
