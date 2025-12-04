package com.paiad.wemedia.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.paiad.model.common.dtos.PageResponseResult;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.common.enums.AppHttpCodeEnum;
import com.paiad.model.wemedia.dtos.WmChannelDto;
import com.paiad.model.wemedia.pojos.WmChannel;
import com.paiad.wemedia.mapper.WmChannelMapper;
import com.paiad.wemedia.service.WmChannelService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

@Service
@Transactional
@Slf4j
public class WmChannelServiceImpl extends ServiceImpl<WmChannelMapper, WmChannel> implements WmChannelService {

    /**
     * 查询所有频道
     * 
     * @return
     */
    @Override
    public ResponseResult findAll() {
        return ResponseResult.okResult(list());
    }

    /**
     * 分页查询频道
     * 
     * @param dto 查询参数
     * @return
     */
    @Override
    public ResponseResult findByPage(WmChannelDto dto) {
        // 检查参数
        if (dto == null) {
            dto = new WmChannelDto();
        }
        dto.setPage(dto.getPage() == null || dto.getPage() < 1 ? 1 : dto.getPage());
        dto.setSize(dto.getSize() == null || dto.getSize() < 1 ? 10 : dto.getSize());

        // 分页查询
        IPage<WmChannel> page = new Page<>(dto.getPage(), dto.getSize());
        LambdaQueryWrapper<WmChannel> wrapper = new LambdaQueryWrapper<>();

        // 按名称模糊搜索
        if (StringUtils.isNotBlank(dto.getName())) {
            wrapper.like(WmChannel::getName, dto.getName());
        }

        // 按ID升序排序
        wrapper.orderByAsc(WmChannel::getId);

        page = page(page, wrapper);

        // 返回结果
        PageResponseResult result = new PageResponseResult(dto.getPage(), dto.getSize(), (int) page.getTotal());
        result.setData(page.getRecords());
        return result;
    }

    /**
     * 新增频道
     * 
     * @param channel 频道信息
     * @return
     */
    @Override
    public ResponseResult saveChannel(WmChannel channel) {
        // 参数校验
        if (channel == null || StringUtils.isBlank(channel.getName())) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID, "频道名称不能为空");
        }

        // 检查名称是否重复
        LambdaQueryWrapper<WmChannel> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WmChannel::getName, channel.getName());
        int count = count(wrapper);
        if (count > 0) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_EXIST, "频道名称已存在");
        }

        // 设置默认值
        channel.setCreatedTime(new Date());
        channel.setStatus(true); // 默认启用
        channel.setIsDefault(true); // 默认频道

        // 排序自增：获取当前最大排序值+1
        LambdaQueryWrapper<WmChannel> ordWrapper = new LambdaQueryWrapper<>();
        ordWrapper.orderByDesc(WmChannel::getOrd).last("LIMIT 1");
        WmChannel maxOrdChannel = getOne(ordWrapper);
        int nextOrd = (maxOrdChannel != null && maxOrdChannel.getOrd() != null) ? maxOrdChannel.getOrd() + 1 : 1;
        channel.setOrd(nextOrd);

        // 保存
        save(channel);
        return ResponseResult.okResult(channel);
    }

    /**
     * 修改频道
     * 
     * @param channel 频道信息
     * @return
     */
    @Override
    public ResponseResult updateChannel(WmChannel channel) {
        // 参数校验
        if (channel == null || channel.getId() == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID, "频道ID不能为空");
        }

        // 检查频道是否存在
        WmChannel exist = getById(channel.getId());
        if (exist == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_EXIST, "频道不存在");
        }

        // 如果修改了名称，检查是否重复
        if (StringUtils.isNotBlank(channel.getName()) && !channel.getName().equals(exist.getName())) {
            LambdaQueryWrapper<WmChannel> wrapper = new LambdaQueryWrapper<>();
            wrapper.eq(WmChannel::getName, channel.getName());
            int count = count(wrapper);
            if (count > 0) {
                return ResponseResult.errorResult(AppHttpCodeEnum.DATA_EXIST, "频道名称已存在");
            }
        }

        // 更新
        updateById(channel);
        return ResponseResult.okResult(getById(channel.getId()));
    }

    /**
     * 删除频道
     * 
     * @param id 频道ID
     * @return
     */
    @Override
    public ResponseResult deleteChannel(Integer id) {
        // 参数校验
        if (id == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID, "频道ID不能为空");
        }

        // 检查频道是否存在
        WmChannel channel = getById(id);
        if (channel == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_EXIST, "频道不存在");
        }

        // 删除
        removeById(id);
        return ResponseResult.okResult(null);
    }
}
