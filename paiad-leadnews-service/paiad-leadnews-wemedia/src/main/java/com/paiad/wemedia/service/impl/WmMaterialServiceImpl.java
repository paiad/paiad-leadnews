package com.paiad.wemedia.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.paiad.file.service.FileStorageService;
import com.paiad.model.common.dtos.PageResponseResult;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.common.enums.AppHttpCodeEnum;
import com.paiad.model.wemedia.dtos.WmMaterialDto;
import com.paiad.model.wemedia.pojos.WmMaterial;
import com.paiad.model.wemedia.pojos.WmNewsMaterial;
import com.paiad.utils.thread.WmThreadLocalUtil;
import com.paiad.wemedia.mapper.WmMaterialMapper;
import com.paiad.wemedia.mapper.WmNewsMaterialMapper;
import com.paiad.wemedia.service.WmMaterialService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Date;
import java.util.UUID;


@Slf4j
@Service
@Transactional
public class WmMaterialServiceImpl extends ServiceImpl<WmMaterialMapper, WmMaterial> implements WmMaterialService {

    @Autowired
    private FileStorageService fileStorageService;

    @Autowired
    private WmNewsMaterialMapper wmNewsMaterialMapper;

    /**
     * 图片上传
     * @param multipartFile
     * @return
     */
    @Override
    public ResponseResult uploadPicture(MultipartFile multipartFile) {

        //1.检查参数
        if(multipartFile == null || multipartFile.getSize() == 0){
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        //2.上传图片到minIO中
        String fileName = UUID.randomUUID().toString().replace("-", "");
        //aa.jpg
        String originalFilename = multipartFile.getOriginalFilename();
        String postfix = originalFilename.substring(originalFilename.lastIndexOf("."));
        String fileId = null;
        try {
            fileId = fileStorageService.uploadImgFile("", fileName + postfix, multipartFile.getInputStream());
            log.info("上传图片到MinIO中，fileId:{}",fileId);
        } catch (IOException e) {
            e.printStackTrace();
            log.error("WmMaterialServiceImpl-上传文件失败");
        }

        //3.保存到数据库中
        WmMaterial wmMaterial = new WmMaterial();
        wmMaterial.setUserId(WmThreadLocalUtil.getUser().getId());
        wmMaterial.setUrl(fileId);
        wmMaterial.setIsCollection((short)0);
        wmMaterial.setType((short)0);
        wmMaterial.setCreatedTime(new Date());
        save(wmMaterial);

        //4.返回结果

        return ResponseResult.okResult(wmMaterial);
    }

    /**
     * 素材列表查询
     * @param dto
     * @return
     */
    @Override
    public ResponseResult findList(WmMaterialDto dto) {

        //1.检查参数
        dto.checkParam();

        //2.分页查询
        IPage page = new Page(dto.getPage(),dto.getSize());
        LambdaQueryWrapper<WmMaterial> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        //是否收藏
        if(dto.getIsCollection() != null && dto.getIsCollection() == 1){
            lambdaQueryWrapper.eq(WmMaterial::getIsCollection,dto.getIsCollection());
        }

        //按照用户查询
        lambdaQueryWrapper.eq(WmMaterial::getUserId,WmThreadLocalUtil.getUser().getId());

        //按照时间倒序
        lambdaQueryWrapper.orderByDesc(WmMaterial::getCreatedTime);


        page = page(page,lambdaQueryWrapper);

        //3.结果返回
        ResponseResult responseResult = new PageResponseResult(dto.getPage(),dto.getSize(),(int)page.getTotal());
        responseResult.setData(page.getRecords());
        return responseResult;
    }

    /**
     * 收藏/取消收藏素材
     *
     * @param id 素材ID
     * @return
     */
    @Override
    public ResponseResult collect(Integer id) {
        // 1.检查参数
        if (id == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        // 2.查询素材
        WmMaterial wmMaterial = getById(id);
        if (wmMaterial == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_EXIST, "素材不存在");
        }

        // 3.判断是否是当前用户的素材
        if (!wmMaterial.getUserId().equals(WmThreadLocalUtil.getUser().getId())) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_ALLOW, "不能操作其他用户的素材");
        }

        // 4.切换收藏状态
        if (wmMaterial.getIsCollection() != null && wmMaterial.getIsCollection() == 1) {
            wmMaterial.setIsCollection((short) 0);
        } else {
            wmMaterial.setIsCollection((short) 1);
        }

        // 5.更新数据库
        updateById(wmMaterial);

        // 6.返回结果
        return ResponseResult.okResult(wmMaterial);
    }

    /**
     * 删除素材
     *
     * @param id 素材ID
     * @return
     */
    @Override
    public ResponseResult delPicture(Integer id) {
        // 1.检查参数
        if (id == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.PARAM_INVALID);
        }

        // 2.查询素材
        WmMaterial wmMaterial = getById(id);
        if (wmMaterial == null) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_EXIST, "素材不存在");
        }

        // 3.判断是否是当前用户的素材
        if (!wmMaterial.getUserId().equals(WmThreadLocalUtil.getUser().getId())) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_ALLOW, "不能删除其他用户的素材");
        }

        // 4.判断素材是否被引用
        LambdaQueryWrapper<WmNewsMaterial> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.eq(WmNewsMaterial::getMaterialId, id);
        Long count = Long.valueOf(wmNewsMaterialMapper.selectCount(lambdaQueryWrapper));
        if (count > 0) {
            return ResponseResult.errorResult(AppHttpCodeEnum.DATA_NOT_ALLOW, "素材正在被引用，不能删除");
        }

        // 5.删除素材
        removeById(id);

        // 6.返回结果
        return ResponseResult.okResult(AppHttpCodeEnum.SUCCESS);
    }
}
