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
 * 频道信息表
 * </p>
 *
 * @author paiad
 */
@Data
@TableName("wm_channel")
@ApiModel(value = "WmChannel", description = "频道信息实体")
public class WmChannel implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    @ApiModelProperty(value = "频道ID")
    private Integer id;

    /**
     * 频道名称
     */
    @TableField("name")
    @ApiModelProperty(value = "频道名称")
    private String name;

    /**
     * 频道描述
     */
    @TableField("description")
    @ApiModelProperty(value = "频道描述")
    private String description;

    /**
     * 是否默认频道
     * 1：默认 true
     * 0：非默认 false
     */
    @TableField("is_default")
    @ApiModelProperty(value = "是否默认频道：true-默认 false-非默认")
    private Boolean isDefault;

    /**
     * 是否启用
     * 1：启用 true
     * 0：禁用 false
     */
    @TableField("status")
    @ApiModelProperty(value = "是否启用：true-启用 false-禁用")
    private Boolean status;

    /**
     * 默认排序
     */
    @TableField("ord")
    @ApiModelProperty(value = "排序权重")
    private Integer ord;

    /**
     * 创建时间
     */
    @TableField("created_time")
    @ApiModelProperty(value = "创建时间")
    private Date createdTime;

}
