package com.paiad.article.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.paiad.model.article.dtos.ArticleDto;
import com.paiad.model.article.dtos.ArticleHomeDto;
import com.paiad.model.article.pojos.ApArticle;
import com.paiad.model.common.dtos.ResponseResult;

public interface ApArticleService extends IService<ApArticle> {

    /**
     * 加载文章列表
     * @param dto
     * @param type  1 加载更多   2 加载最新
     * @return
     */
    public ResponseResult load(ArticleHomeDto dto, Short type);

    /**
     * 保存app端相关文章
     * @param dto
     * @return
     */
    public ResponseResult saveArticle(ArticleDto dto);

}
