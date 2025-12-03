package com.paiad.wemedia.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.pojos.WmChannel;
import com.paiad.wemedia.mapper.WmChannelMapper;
import com.paiad.wemedia.service.WmChannelService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
@Slf4j
public class WmChannelServiceImpl extends ServiceImpl<WmChannelMapper, WmChannel> implements WmChannelService {


    /**
     * 查询所有频�?
     * @return
     */
    @Override
    public ResponseResult findAll() {
        return ResponseResult.okResult(list());
    }
}