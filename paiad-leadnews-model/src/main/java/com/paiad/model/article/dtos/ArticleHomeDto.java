package com.paiad.model.article.dtos;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
@ApiModel(value = "ArticleHomeDto", description = "文章首页查询请求DTO")
public class ArticleHomeDto {

    /**
     * 最大时间
     */
    @ApiModelProperty(value = "最大时间（用于加载更多）")
    Date maxBehotTime;

    /**
     * 最小时间
     */
    @ApiModelProperty(value = "最小时间（用于加载最新）")
    Date minBehotTime;

    /**
     * 分页size
     */
    @ApiModelProperty(value = "每页数量", example = "10")
    Integer size;

    /**
     * 频道ID
     */
    @ApiModelProperty(value = "频道标签")
    String tag;
}
