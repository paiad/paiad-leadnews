package com.paiad.user.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.common.enums.AppHttpCodeEnum;
import com.paiad.model.user.dtos.LoginDto;
import com.paiad.model.user.pojos.ApUser;
import com.paiad.user.mapper.ApUserMapper;
import com.paiad.user.service.ApUserService;
import com.paiad.utils.common.AppJwtUtil;
import com.paiad.utils.common.MD5Utils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.util.HashMap;
import java.util.Map;


@Service
@Transactional
@Slf4j
public class ApUserServiceImpl extends ServiceImpl<ApUserMapper, ApUser> implements ApUserService {
    /**
     * app端登录功能
     * @param dto
     * @return
     */
    @Override
    public ResponseResult login(LoginDto dto) {
        // 用户登录
        if(StringUtils.isNotBlank(dto.getPhone()) && StringUtils.isNotBlank(dto.getPassword())){
            // 通过手机号得到用户
            ApUser user = getOne(Wrappers.<ApUser>lambdaQuery().eq(ApUser::getPhone, dto.getPhone()));
            if(user == null){
                return ResponseResult.errorResult(AppHttpCodeEnum.AP_USER_DATA_NOT_EXIST, "用户信息不存在");
            }

            String salt = user.getSalt();
            String password = dto.getPassword();
            String pwd_salt = DigestUtils.md5DigestAsHex((password + salt).getBytes());
            // 对比密码
            if(!pwd_salt.equals(user.getPassword())){
                return ResponseResult.errorResult(AppHttpCodeEnum.LOGIN_PASSWORD_ERROR);
            }

            // 返回 jwt
            String token = AppJwtUtil.getToken(user.getId().longValue());
            Map<String, Object> map = new HashMap<>();
            map.put("token", token);
            user.setSalt("");
            user.setSalt("");
            user.setPassword("");
            map.put("user",user);

            return ResponseResult.okResult(map);
        }else{
            Map<Object, Object> map = new HashMap<>();
            map.put("token", 0L);
            return ResponseResult.okResult(map);
        }
    }
}
