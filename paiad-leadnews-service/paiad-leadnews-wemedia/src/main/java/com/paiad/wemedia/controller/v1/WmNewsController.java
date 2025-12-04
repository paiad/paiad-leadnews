package com.paiad.wemedia.controller.v1;

import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.dtos.WmNewsDto;
import com.paiad.model.wemedia.dtos.WmNewsPageReqDto;
import com.paiad.wemedia.service.WmNewsService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/news")
@Api(value = "文章管理", tags = "文章管理")
public class WmNewsController {

    @Autowired
    private WmNewsService wmNewsService;

    @PostMapping("/list")
    @ApiOperation("查询文章列表")
    public ResponseResult findList(@RequestBody WmNewsPageReqDto dto) {
        return wmNewsService.findList(dto);
    }

    @PostMapping("/submit")
    @ApiOperation("发布或修改文章")
    public ResponseResult submitNews(@RequestBody WmNewsDto dto) {
        return wmNewsService.submitNews(dto);
    }

    @GetMapping("/one/{id}")
    @ApiOperation("获取文章详情")
    public ResponseResult getNewsById(@PathVariable Integer id) {
        return wmNewsService.getNewsById(id);
    }

    @DeleteMapping("/del/{id}")
    @ApiOperation("删除文章")
    public ResponseResult deleteNews(@PathVariable Integer id) {
        return wmNewsService.deleteNews(id);
    }

    @PostMapping("/del/batch")
    @ApiOperation("批量删除文章")
    public ResponseResult batchDeleteNews(@RequestBody List<Integer> ids) {
        return wmNewsService.batchDeleteNews(ids);
    }
}
