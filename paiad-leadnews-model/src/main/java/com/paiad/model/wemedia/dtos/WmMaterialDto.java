package com.paiad.model.wemedia.dtos;

import com.paiad.model.common.dtos.PageRequestDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
@ApiModel(value = "WmMaterialDto", description = "素材分页查询请求DTO")
public class WmMaterialDto extends PageRequestDto {

    /**
     * 1 收藏
     * 0 未收藏
     */
    @ApiModelProperty(value = "是否收藏：1-收藏 0-未收藏", example = "0")
    private Short isCollection;
}
