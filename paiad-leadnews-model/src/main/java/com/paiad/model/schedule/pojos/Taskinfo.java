package com.paiad.model.schedule.pojos;

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
 * 任务信息实体
 * </p>
 *
 * @author paiad
 */
@Data
@TableName("taskinfo")
@ApiModel(value = "Taskinfo", description = "任务信息实体")
public class Taskinfo implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 任务id
     */
    @TableId(type = IdType.ASSIGN_ID)
    @ApiModelProperty(value = "任务ID")
    private Long taskId;

    /**
     * 执行时间
     */
    @TableField("execute_time")
    @ApiModelProperty(value = "执行时间")
    private Date executeTime;

    /**
     * 参数
     */
    @TableField("parameters")
    @ApiModelProperty(value = "任务参数")
    private byte[] parameters;

    /**
     * 优先级
     */
    @TableField("priority")
    @ApiModelProperty(value = "任务优先级")
    private Integer priority;

    /**
     * 任务类型
     */
    @TableField("task_type")
    @ApiModelProperty(value = "任务类型")
    private Integer taskType;

}
