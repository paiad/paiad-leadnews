package com.paiad.model.user.dtos;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "LoginDto", description = "APP用户登录请求DTO")
public class LoginDto {

    /**
     * 手机号
     */
    @ApiModelProperty(value = "手机号", required = true, example = "13812345678")
    private String phone;

    /**
     * 密码
     */
    @ApiModelProperty(value = "密码", required = true, example = "admin")
    private String password;
}
