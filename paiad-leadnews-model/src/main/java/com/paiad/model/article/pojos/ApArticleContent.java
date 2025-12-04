package com.paiad.model.article.pojos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

/**
 * <p>
 * 文章内容表
 * </p>
 *
 * @author paiad
 */
@Data
@TableName("ap_article_content")
@ApiModel(value = "ApArticleContent", description = "文章内容实体")
public class ApArticleContent implements Serializable {

    @TableId(value = "id", type = IdType.ASSIGN_ID)
    @ApiModelProperty(value = "内容ID")
    private Long id;

    /**
     * 文章id
     */
    @TableField("article_id")
    @ApiModelProperty(value = "文章ID")
    private Long articleId;

    /**
     * 文章内容
     */
    @ApiModelProperty(value = "文章内容（JSON格式）")
    private String content;
}
