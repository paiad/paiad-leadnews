package com.paiad.model.wemedia.dtos;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
@ApiModel(value = "WmNewsDto", description = "文章发布/修改请求DTO")
public class WmNewsDto {

    @ApiModelProperty(value = "文章ID（修改时必传）")
    private Integer id;

    /**
     * 标题
     */
    @ApiModelProperty(value = "文章标题", required = true, example = "这是一篇测试文章")
    private String title;

    /**
     * 频道id
     */
    @ApiModelProperty(value = "频道ID", required = true, example = "1")
    private Integer channelId;

    /**
     * 标签
     */
    @ApiModelProperty(value = "文章标签", example = "科技,互联网")
    private String labels;

    /**
     * 发布时间
     */
    @ApiModelProperty(value = "定时发布时间")
    @com.fasterxml.jackson.annotation.JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date publishTime;

    /**
     * 文章内容
     */
    @ApiModelProperty(value = "文章内容（JSON格式）", required = true)
    private String content;

    /**
     * 文章封面类型 0 无图 1 单图 3 多图 -1 自动
     */
    @ApiModelProperty(value = "封面类型：0-无图 1-单图 3-多图 -1-自动", example = "1")
    private Short type;

    /**
     * 提交时间
     */
    @ApiModelProperty(value = "提交时间")
    @com.fasterxml.jackson.annotation.JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date submitedTime;

    /**
     * 状态 提交为1 草稿为0
     */
    @ApiModelProperty(value = "状态：0-草稿 1-提交", example = "1")
    private Short status;

    /**
     * 封面图片列表 多张图以逗号隔开
     */
    @ApiModelProperty(value = "封面图片URL列表")
    private List<String> images;
}
