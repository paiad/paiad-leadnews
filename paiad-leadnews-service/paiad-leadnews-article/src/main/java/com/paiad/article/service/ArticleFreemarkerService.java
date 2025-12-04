package com.paiad.article.service;

import com.paiad.model.article.pojos.ApArticle;


public interface ArticleFreemarkerService {

    public void buildArticleToMinIO(ApArticle apArticle, String content);
}
