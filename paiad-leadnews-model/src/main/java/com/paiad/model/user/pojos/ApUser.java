package com.paiad.model.user.pojos;

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
 * APP用户信息表
 * </p>
 *
 * @author paiad
 */
@Data
@TableName("ap_user")
@ApiModel(value = "ApUser", description = "APP用户实体")
public class ApUser implements Serializable {

       private static final long serialVersionUID = 1L;

       /**
        * 主键
        */
       @TableId(value = "id", type = IdType.AUTO)
       @ApiModelProperty(value = "用户ID")
       private Integer id;

       /**
        * 密码、通信等加密盐
        */
       @TableField("salt")
       @ApiModelProperty(value = "密码盐值")
       private String salt;

       /**
        * 用户名
        */
       @TableField("name")
       @ApiModelProperty(value = "用户名")
       private String name;

       /**
        * 密码,md5加密
        */
       @TableField("password")
       @ApiModelProperty(value = "密码（MD5加密）")
       private String password;

       /**
        * 手机号
        */
       @TableField("phone")
       @ApiModelProperty(value = "手机号")
       private String phone;

       /**
        * 头像
        */
       @TableField("image")
       @ApiModelProperty(value = "头像URL")
       private String image;

       /**
        * 0 男
        * 1 女
        * 2 未知
        */
       @TableField("sex")
       @ApiModelProperty(value = "性别：0-男 1-女 2-未知")
       private Boolean sex;

       /**
        * 0 未
        * 1 是
        */
       @TableField("is_certification")
       @ApiModelProperty(value = "是否认证：true-已认证 false-未认证")
       private Boolean certification;

       /**
        * 是否身份认证
        */
       @TableField("is_identity_authentication")
       @ApiModelProperty(value = "是否身份认证")
       private Boolean identityAuthentication;

       /**
        * 0正常
        * 1锁定
        */
       @TableField("status")
       @ApiModelProperty(value = "状态：false-正常 true-锁定")
       private Boolean status;

       /**
        * 0 普通用户
        * 1 自媒体人
        * 2 大V
        */
       @TableField("flag")
       @ApiModelProperty(value = "用户类型：0-普通用户 1-自媒体人 2-大V")
       private Short flag;

       /**
        * 注册时间
        */
       @TableField("created_time")
       @ApiModelProperty(value = "注册时间")
       private Date createdTime;

}