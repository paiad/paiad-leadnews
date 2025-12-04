package com.paiad.model.schedule.dtos;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.io.Serializable;

@Data
@ApiModel(value = "Task", description = "延迟任务DTO")
public class Task implements Serializable {

    /**
     * 任务id
     */
    @ApiModelProperty(value = "任务ID", example = "1")
    private Long taskId;

    /**
     * 类型
     */
    @ApiModelProperty(value = "任务类型", example = "100")
    private Integer taskType;

    /**
     * 优先级
     */
    @ApiModelProperty(value = "任务优先级", example = "50")
    private Integer priority;

    /**
     * 执行时间
     */
    @ApiModelProperty(value = "执行时间（毫秒时间戳）", example = "1701676800000")
    private long executeTime;

    /**
     * task参数
     */
    @ApiModelProperty(value = "任务参数（字节数组）")
    private byte[] parameters;

}
