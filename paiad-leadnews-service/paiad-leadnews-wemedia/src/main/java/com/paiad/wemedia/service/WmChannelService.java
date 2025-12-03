package com.paiad.wemedia.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.pojos.WmChannel;

public interface WmChannelService extends IService<WmChannel> {

    public ResponseResult findAll();


}
