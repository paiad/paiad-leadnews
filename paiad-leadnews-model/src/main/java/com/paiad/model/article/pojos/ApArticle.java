package com.paiad.model.article.pojos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 文章信息表，存储已发布的文章
 * </p>
 *
 * @author paiad
 */

@Data
@TableName("ap_article")
@ApiModel(value = "ApArticle", description = "APP文章实体")
public class ApArticle implements Serializable {

    @TableId(value = "id", type = IdType.ASSIGN_ID)
    @ApiModelProperty(value = "文章ID")
    private Long id;

    /**
     * 标题
     */
    @ApiModelProperty(value = "文章标题")
    private String title;

    /**
     * 作者id
     */
    @TableField("author_id")
    @ApiModelProperty(value = "作者ID")
    private Long authorId;

    /**
     * 作者名称
     */
    @TableField("author_name")
    @ApiModelProperty(value = "作者名称")
    private String authorName;

    /**
     * 频道id
     */
    @TableField("channel_id")
    @ApiModelProperty(value = "频道ID")
    private Integer channelId;

    /**
     * 频道名称
     */
    @TableField("channel_name")
    @ApiModelProperty(value = "频道名称")
    private String channelName;

    /**
     * 文章布局 0 无图文章 1 单图文章 2 多图文章
     */
    @ApiModelProperty(value = "布局类型：0-无图 1-单图 2-多图")
    private Short layout;

    /**
     * 文章标记 0 普通文章 1 热点文章 2 置顶文章 3 精品文章 4 大V 文章
     */
    @ApiModelProperty(value = "文章标记：0-普通 1-热点 2-置顶 3-精品 4-大V")
    private Byte flag;

    /**
     * 文章封面图片 多张逗号分隔
     */
    @ApiModelProperty(value = "封面图片，多张用逗号分隔")
    private String images;

    /**
     * 标签
     */
    @ApiModelProperty(value = "文章标签")
    private String labels;

    /**
     * 点赞数量
     */
    @ApiModelProperty(value = "点赞数量")
    private Integer likes;

    /**
     * 收藏数量
     */
    @ApiModelProperty(value = "收藏数量")
    private Integer collection;

    /**
     * 评论数量
     */
    @ApiModelProperty(value = "评论数量")
    private Integer comment;

    /**
     * 阅读数量
     */
    @ApiModelProperty(value = "阅读数量")
    private Integer views;

    /**
     * 省市
     */
    @TableField("province_id")
    @ApiModelProperty(value = "省份ID")
    private Integer provinceId;

    /**
     * 市区
     */
    @TableField("city_id")
    @ApiModelProperty(value = "城市ID")
    private Integer cityId;

    /**
     * 区县
     */
    @TableField("county_id")
    @ApiModelProperty(value = "区县ID")
    private Integer countyId;

    /**
     * 创建时间
     */
    @TableField("created_time")
    @ApiModelProperty(value = "创建时间")
    private Date createdTime;

    /**
     * 发布时间
     */
    @TableField("publish_time")
    @ApiModelProperty(value = "发布时间")
    private Date publishTime;

    /**
     * 同步状态
     */
    @TableField("sync_status")
    @ApiModelProperty(value = "同步状态")
    private Boolean syncStatus;

    /**
     * 来源
     */
    @ApiModelProperty(value = "是否原创")
    private Boolean origin;

    /**
     * 静态页面地址
     */
    @TableField("static_url")
    @ApiModelProperty(value = "静态页面URL")
    private String staticUrl;
}
