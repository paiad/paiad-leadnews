package com.paiad.wemedia.controller.v1;

import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.dtos.WmMaterialDto;
import com.paiad.wemedia.service.WmMaterialService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Api(tags = "素材管理", description = "自媒体素材上传、删除、收藏等接口")
@RestController
@RequestMapping("/api/v1/material")
public class WmMaterialController {

    @Autowired
    private WmMaterialService wmMaterialService;

    @ApiOperation(value = "上传图片", notes = "上传单张图片素材")
    @PostMapping("/upload_picture")
    public ResponseResult uploadPicture(@ApiParam(value = "图片文件", required = true) MultipartFile multipartFile) {
        return wmMaterialService.uploadPicture(multipartFile);
    }

    @ApiOperation(value = "素材列表", notes = "分页查询素材列表")
    @PostMapping("/list")
    public ResponseResult findList(@RequestBody WmMaterialDto dto) {
        return wmMaterialService.findList(dto);
    }

    @ApiOperation(value = "收藏/取消收藏素材", notes = "切换素材的收藏状态")
    @PostMapping("/collect/{id}")
    public ResponseResult collect(@ApiParam(value = "素材ID", required = true) @PathVariable Integer id) {
        return wmMaterialService.collect(id);
    }

    @ApiOperation(value = "删除素材", notes = "根据ID删除单个素材")
    @DeleteMapping("/del/{id}")
    public ResponseResult delPicture(@ApiParam(value = "素材ID", required = true) @PathVariable Integer id) {
        return wmMaterialService.delPicture(id);
    }

    @ApiOperation(value = "批量删除素材", notes = "根据ID列表批量删除素材")
    @PostMapping("/del/batch")
    public ResponseResult batchDeleteMaterial(
            @ApiParam(value = "素材ID列表", required = true) @RequestBody java.util.List<Integer> ids) {
        return wmMaterialService.batchDeleteMaterial(ids);
    }

    @ApiOperation(value = "批量上传素材", notes = "同时上传多张图片素材")
    @PostMapping("/upload_pictures")
    public ResponseResult batchUploadPictures(
            @ApiParam(value = "图片文件数组", required = true) @RequestParam("multipartFiles") MultipartFile[] multipartFiles) {
        return wmMaterialService.batchUploadPictures(multipartFiles);
    }
}
