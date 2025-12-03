package com.paiad.wemedia.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.wemedia.dtos.WmMaterialDto;
import com.paiad.model.wemedia.pojos.WmMaterial;
import org.springframework.web.multipart.MultipartFile;

public interface WmMaterialService extends IService<WmMaterial> {

    /**
     * 图片上传
     * 
     * @param multipartFile
     * @return
     */
    public ResponseResult uploadPicture(MultipartFile multipartFile);

    /**
     * 素材列表查询
     * 
     * @param dto
     * @return
     */
    public ResponseResult findList(WmMaterialDto dto);

    /**
     * 收藏/取消收藏素材
     * 
     * @param id 素材ID
     * @return
     */
    public ResponseResult collect(Integer id);

    /**
     * 删除素材
     * 
     * @param id 素材ID
     * @return
     */
    public ResponseResult delPicture(Integer id);

}