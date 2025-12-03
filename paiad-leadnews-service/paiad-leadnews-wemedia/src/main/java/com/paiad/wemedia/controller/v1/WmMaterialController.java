package com.paiad.wemedia.controller.v1;

import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.dtos.WmMaterialDto;
import com.paiad.wemedia.service.WmMaterialService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@RestController
@RequestMapping("/api/v1/material")
public class WmMaterialController {

    @Autowired
    private WmMaterialService wmMaterialService;


    @PostMapping("/upload_picture")
    public ResponseResult uploadPicture(MultipartFile multipartFile){
        return wmMaterialService.uploadPicture(multipartFile);
    }

    @PostMapping("/list")
    public ResponseResult findList(@RequestBody WmMaterialDto dto){
        return wmMaterialService.findList(dto);
    }

    @ApiOperation("收藏/取消收藏素材")
    @PostMapping("/collect/{id}")
    public ResponseResult collect(@PathVariable Integer id) {
        return wmMaterialService.collect(id);
    }

    @ApiOperation("删除素材")
    @DeleteMapping("/del/{id}")
    public ResponseResult delPicture(@PathVariable Integer id) {
        return wmMaterialService.delPicture(id);
    }
}
