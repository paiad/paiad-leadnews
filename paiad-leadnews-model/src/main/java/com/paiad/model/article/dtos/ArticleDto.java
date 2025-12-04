package com.paiad.model.article.dtos;

import com.paiad.model.article.pojos.ApArticle;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "ArticleDto", description = "文章发布DTO")
public class ArticleDto extends ApArticle {

    /**
     * 文章内容
     */
    @ApiModelProperty(value = "文章内容（JSON格式）")
    private String content;
}
