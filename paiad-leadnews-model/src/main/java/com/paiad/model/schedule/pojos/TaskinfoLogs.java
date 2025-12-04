package com.paiad.model.schedule.pojos;

import com.baomidou.mybatisplus.annotation.*;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 任务日志实体
 * </p>
 *
 * @author paiad
 */
@Data
@TableName("taskinfo_logs")
@ApiModel(value = "TaskinfoLogs", description = "任务日志实体")
public class TaskinfoLogs implements Serializable {

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

    /**
     * 版本号,用乐观锁
     */
    @Version
    @ApiModelProperty(value = "版本号（乐观锁）")
    private Integer version;

    /**
     * 状态 0=INIT 1=EXECUTED 2=CANCELLED
     */
    @TableField("status")
    @ApiModelProperty(value = "状态：0=初始化 1=已执行 2=已取消")
    private Integer status;

}
