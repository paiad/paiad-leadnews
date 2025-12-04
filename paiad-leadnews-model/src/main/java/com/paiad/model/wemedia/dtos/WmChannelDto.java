package com.paiad.model.wemedia.dtos;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * 频道分页查询DTO
 *
 * @author paiad
 */
@Data
@ApiModel(value = "WmChannelDto", description = "频道分页查询参数")
public class WmChannelDto {

    @ApiModelProperty(value = "页码")
    private Integer page;

    @ApiModelProperty(value = "每页条数")
    private Integer size;

    @ApiModelProperty(value = "频道名称（可选，模糊搜索）")
    private String name;
}
