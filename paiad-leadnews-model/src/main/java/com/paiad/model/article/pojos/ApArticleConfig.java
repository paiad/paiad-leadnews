package com.paiad.model.article.pojos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * <p>
 * APP已发布文章配置表
 * </p>
 *
 * @author paiad
 */

@Data
@NoArgsConstructor
@TableName("ap_article_config")
@ApiModel(value = "ApArticleConfig", description = "文章配置实体")
public class ApArticleConfig implements Serializable {

    public ApArticleConfig(Long articleId) {
        this.articleId = articleId;
        this.isDelete = false;
        this.isDown = false;
        this.isForward = true;
        this.isComment = true;
    }

    @TableId(value = "id", type = IdType.ID_WORKER)
    @ApiModelProperty(value = "配置ID")
    private Long id;

    /**
     * 文章id
     */
    @TableField("article_id")
    @ApiModelProperty(value = "文章ID")
    private Long articleId;

    /**
     * 是否可评论
     * true: 可以评论 1
     * false: 不可评论 0
     */
    @TableField("is_comment")
    @ApiModelProperty(value = "是否可评论：true-可评论 false-不可评论")
    private Boolean isComment;

    /**
     * 是否转发
     * true: 可以转发 1
     * false: 不可转发 0
     */
    @TableField("is_forward")
    @ApiModelProperty(value = "是否可转发：true-可转发 false-不可转发")
    private Boolean isForward;

    /**
     * 是否下架
     * true: 下架 1
     * false: 没有下架 0
     */
    @TableField("is_down")
    @ApiModelProperty(value = "是否下架：true-已下架 false-正常")
    private Boolean isDown;

    /**
     * 是否已删除
     * true: 删除 1
     * false: 没有删除 0
     */
    @TableField("is_delete")
    @ApiModelProperty(value = "是否删除：true-已删除 false-正常")
    private Boolean isDelete;
}
