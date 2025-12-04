package com.paiad.apis.article;

import com.paiad.apis.article.fallback.IArticleClientFallback;
import com.paiad.model.article.dtos.ArticleDto;
import com.paiad.model.common.dtos.ResponseResult;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@FeignClient(value = "leadnews-article", fallback = IArticleClientFallback.class)
public interface IArticleClient {

    @PostMapping("/api/v1/article/save")
    public ResponseResult saveArticle(@RequestBody ArticleDto dto);

    @PostMapping("/api/v1/article/delete")
    public ResponseResult deleteArticle(@RequestBody Long id);
}
