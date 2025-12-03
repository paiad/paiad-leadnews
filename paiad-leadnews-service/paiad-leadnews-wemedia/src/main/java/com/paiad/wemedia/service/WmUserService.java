package com.paiad.wemedia.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.dtos.WmLoginDto;
import com.paiad.model.wemedia.pojos.WmUser;

public interface WmUserService extends IService<WmUser> {

    /**
     * 自媒体端登录
     * @param dto
     * @return
     */
    public ResponseResult login(WmLoginDto dto);

}