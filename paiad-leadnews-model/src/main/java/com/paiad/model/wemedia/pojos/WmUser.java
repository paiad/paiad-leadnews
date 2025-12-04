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
 * 自媒体用户信息表
 * </p>
 *
 * @author paiad
 */
@Data
@TableName("wm_user")
@ApiModel(value = "WmUser", description = "自媒体用户实体")
public class WmUser implements Serializable {

       private static final long serialVersionUID = 1L;

       /**
        * 主键
        */
       @TableId(value = "id", type = IdType.AUTO)
       @ApiModelProperty(value = "用户ID")
       private Integer id;

       @TableField("ap_user_id")
       @ApiModelProperty(value = "APP用户ID")
       private Integer apUserId;

       @TableField("ap_author_id")
       @ApiModelProperty(value = "作者ID")
       private Integer apAuthorId;

       /**
        * 登录用户名
        */
       @TableField("name")
       @ApiModelProperty(value = "登录用户名")
       private String name;

       /**
        * 登录密码
        */
       @TableField("password")
       @ApiModelProperty(value = "登录密码（加密）")
       private String password;

       /**
        * 盐
        */
       @TableField("salt")
       @ApiModelProperty(value = "密码盐值")
       private String salt;

       /**
        * 昵称
        */
       @TableField("nickname")
       @ApiModelProperty(value = "用户昵称")
       private String nickname;

       /**
        * 头像
        */
       @TableField("image")
       @ApiModelProperty(value = "头像URL")
       private String image;

       /**
        * 归属地
        */
       @TableField("location")
       @ApiModelProperty(value = "归属地")
       private String location;

       /**
        * 手机号
        */
       @TableField("phone")
       @ApiModelProperty(value = "手机号")
       private String phone;

       /**
        * 状态
        * 0 暂时不可用
        * 1 永久不可用
        * 9 正常可用
        */
       @TableField("status")
       @ApiModelProperty(value = "状态：0-暂时不可用 1-永久不可用 9-正常可用")
       private Integer status;

       /**
        * 邮箱
        */
       @TableField("email")
       @ApiModelProperty(value = "邮箱")
       private String email;

       /**
        * 账号类型
        * 0 个人
        * 1 企业
        * 2 子账号
        */
       @TableField("type")
       @ApiModelProperty(value = "账号类型：0-个人 1-企业 2-子账号")
       private Integer type;

       /**
        * 运营评分
        */
       @TableField("score")
       @ApiModelProperty(value = "运营评分")
       private Integer score;

       /**
        * 最后一次登录时间
        */
       @TableField("login_time")
       @ApiModelProperty(value = "最后登录时间")
       private Date loginTime;

       /**
        * 创建时间
        */
       @TableField("created_time")
       @ApiModelProperty(value = "创建时间")
       private Date createdTime;

}
