package com.paiad.model.wemedia.dtos;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "WmLoginDto", description = "自媒体用户登录请求DTO")
public class WmLoginDto {

    /**
     * 用户名
     */
    @ApiModelProperty(value = "用户名", required = true, example = "admin")
    private String name;

    /**
     * 密码
     */
    @ApiModelProperty(value = "密码", required = true, example = "admin")
    private String password;
}
