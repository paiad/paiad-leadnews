package com.paiad.wemedia.controller.v1;

import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.dtos.WmChannelDto;
import com.paiad.model.wemedia.pojos.WmChannel;
import com.paiad.wemedia.service.WmChannelService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Api(tags = "频道管理", description = "文章频道管理接口")
@RestController
@RequestMapping("/api/v1/channel")
public class WmchannelController {

    @Autowired
    private WmChannelService wmChannelService;

    @ApiOperation(value = "查询所有频道", notes = "获取全部文章频道列表")
    @GetMapping("/channels")
    public ResponseResult findAll() {
        return wmChannelService.findAll();
    }

    @ApiOperation(value = "分页查询频道", notes = "分页获取频道列表，支持按名称搜索")
    @PostMapping("/list")
    public ResponseResult findByPage(@RequestBody WmChannelDto dto) {
        return wmChannelService.findByPage(dto);
    }

    @ApiOperation(value = "新增频道", notes = "新增一个频道")
    @PostMapping("/save")
    public ResponseResult saveChannel(@RequestBody WmChannel channel) {
        return wmChannelService.saveChannel(channel);
    }

    @ApiOperation(value = "修改频道", notes = "修改频道信息")
    @PostMapping("/update")
    public ResponseResult updateChannel(@RequestBody WmChannel channel) {
        return wmChannelService.updateChannel(channel);
    }

    @ApiOperation(value = "删除频道", notes = "根据ID删除频道")
    @DeleteMapping("/del/{id}")
    public ResponseResult deleteChannel(@PathVariable("id") Integer id) {
        return wmChannelService.deleteChannel(id);
    }
}
