package com.paiad.model.wemedia.pojos;

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
 * 自媒体图文素材信息表
 * </p>
 *
 * @author paiad
 */
@Data
@TableName("wm_material")
@ApiModel(value = "WmMaterial", description = "素材信息实体")
public class WmMaterial implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty(value = "素材ID")
    private Integer id;

    /**
     * 自媒体用户ID
     */
    @TableField("user_id")
    @ApiModelProperty(value = "用户ID")
    private Integer userId;

    /**
     * 图片地址
     */
    @TableField("url")
    @ApiModelProperty(value = "素材URL地址")
    private String url;

    /**
     * 素材类型
     * 0 图片
     * 1 视频
     */
    @TableField("type")
    @ApiModelProperty(value = "素材类型：0-图片 1-视频")
    private Short type;

    /**
     * 是否收藏
     */
    @TableField("is_collection")
    @ApiModelProperty(value = "是否收藏：0-未收藏 1-已收藏")
    private Short isCollection;

    /**
     * 创建时间
     */
    @TableField("created_time")
    @ApiModelProperty(value = "创建时间")
    private Date createdTime;

}
