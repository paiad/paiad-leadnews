package com.paiad.wemedia.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.dtos.WmNewsDto;
import com.paiad.model.wemedia.dtos.WmNewsPageReqDto;
import com.paiad.model.wemedia.pojos.WmNews;

import java.util.List;

public interface WmNewsService extends IService<WmNews> {

    /**
     * 条件查询文章列表
     * 
     * @param dto
     * @return
     */
    public ResponseResult findList(WmNewsPageReqDto dto);

    /**
     * 发布修改文章或保存为草稿
     * 
     * @param dto
     * @return
     */
    public ResponseResult submitNews(WmNewsDto dto);

    /**
     * 根据ID获取文章详情
     * 
     * @param id 文章ID
     * @return
     */
    public ResponseResult getNewsById(Integer id);

    /**
     * 删除文章
     * 
     * @param id 文章ID
     * @return
     */
    public ResponseResult deleteNews(Integer id);

    /**
     * 批量删除文章
     * 
     * @param ids 文章ID列表
     * @return
     */
    public ResponseResult batchDeleteNews(List<Integer> ids);

}
