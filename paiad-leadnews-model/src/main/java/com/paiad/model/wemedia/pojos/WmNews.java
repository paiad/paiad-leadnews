package com.paiad.model.wemedia.pojos;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.apache.ibatis.type.Alias;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 自媒体图文内容信息表
 * </p>
 *
 * @author paiad
 */
@Data
@TableName("wm_news")
@ApiModel(value = "WmNews", description = "自媒体文章实体")
public class WmNews implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty(value = "文章ID")
    private Integer id;

    /**
     * 自媒体用户ID
     */
    @TableField("user_id")
    @ApiModelProperty(value = "用户ID")
    private Integer userId;

    /**
     * 标题
     */
    @TableField("title")
    @ApiModelProperty(value = "文章标题")
    private String title;

    /**
     * 图文内容
     */
    @TableField("content")
    @ApiModelProperty(value = "文章内容（JSON格式）")
    private String content;

    /**
     * 文章布局
     * 0 无图文章
     * 1 单图文章
     * 3 多图文章
     */
    @TableField("type")
    @ApiModelProperty(value = "封面类型：0-无图 1-单图 3-多图")
    private Short type;

    /**
     * 图文频道ID
     */
    @TableField("channel_id")
    @ApiModelProperty(value = "频道ID")
    private Integer channelId;

    @TableField("labels")
    @ApiModelProperty(value = "文章标签")
    private String labels;

    /**
     * 创建时间
     */
    @TableField("created_time")
    @ApiModelProperty(value = "创建时间")
    @com.fasterxml.jackson.annotation.JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createdTime;

    /**
     * 提交时间
     */
    @TableField("submited_time")
    @ApiModelProperty(value = "提交时间")
    @com.fasterxml.jackson.annotation.JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date submitedTime;

    /**
     * 当前状态
     * 0 草稿
     * 1 提交（待审核）
     * 2 审核失败
     * 3 人工审核
     * 4 人工审核通过
     * 8 审核通过（待发布）
     * 9 已发布
     */
    @TableField("status")
    @ApiModelProperty(value = "状态：0-草稿 1-待审核 2-审核失败 3-人工审核 4-人工审核通过 8-待发布 9-已发布")
    private Short status;

    /**
     * 定时发布时间，不定时则为空
     */
    @TableField("publish_time")
    @ApiModelProperty(value = "发布时间")
    @com.fasterxml.jackson.annotation.JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date publishTime;

    /**
     * 拒绝理由
     */
    @TableField("reason")
    @ApiModelProperty(value = "审核失败原因")
    private String reason;

    /**
     * 发布库文章ID
     */
    @TableField("article_id")
    @ApiModelProperty(value = "APP端文章ID")
    private Long articleId;

    /**
     * //图片用逗号分隔
     */
    @TableField("images")
    @ApiModelProperty(value = "封面图片，多张用逗号分隔")
    private String images;

    @TableField("enable")
    @ApiModelProperty(value = "是否启用")
    private Short enable;

    // 状态枚举类
    @Alias("WmNewsStatus")
    public enum Status {
        NORMAL((short) 0), SUBMIT((short) 1), FAIL((short) 2), ADMIN_AUTH((short) 3), ADMIN_SUCCESS((short) 4),
        SUCCESS((short) 8), PUBLISHED((short) 9);

        short code;

        Status(short code) {
            this.code = code;
        }

        public short getCode() {
            return this.code;
        }
    }

}
