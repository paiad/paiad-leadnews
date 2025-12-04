package com.paiad.model.wemedia.dtos;

import com.paiad.model.common.dtos.PageRequestDto;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.Date;

@Data
@ApiModel(value = "WmNewsPageReqDto", description = "文章分页查询请求DTO")
public class WmNewsPageReqDto extends PageRequestDto {

    /**
     * 状态
     */
    @ApiModelProperty(value = "文章状态")
    private Short status;

    /**
     * 开始时间
     */
    @ApiModelProperty(value = "发布开始时间")
    private Date beginPubDate;

    /**
     * 结束时间
     */
    @ApiModelProperty(value = "发布结束时间")
    private Date endPubDate;

    /**
     * 所属频道ID
     */
    @ApiModelProperty(value = "频道ID")
    private Integer channelId;

    /**
     * 关键字
     */
    @ApiModelProperty(value = "搜索关键字")
    private String keyword;
}
