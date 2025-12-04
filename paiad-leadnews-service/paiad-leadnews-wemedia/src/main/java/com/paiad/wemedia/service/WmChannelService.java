package com.paiad.wemedia.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.dtos.WmChannelDto;
import com.paiad.model.wemedia.pojos.WmChannel;

public interface WmChannelService extends IService<WmChannel> {

    /**
     * 查询所有频道
     * 
     * @return
     */
    public ResponseResult findAll();

    /**
     * 分页查询频道
     * 
     * @param dto 查询参数
     * @return
     */
    public ResponseResult findByPage(WmChannelDto dto);

    /**
     * 新增频道
     * 
     * @param channel 频道信息
     * @return
     */
    public ResponseResult saveChannel(WmChannel channel);

    /**
     * 修改频道
     * 
     * @param channel 频道信息
     * @return
     */
    public ResponseResult updateChannel(WmChannel channel);

    /**
     * 删除频道
     * 
     * @param id 频道ID
     * @return
     */
    public ResponseResult deleteChannel(Integer id);

}
