package com.paiad.apis.article.fallback;

import com.paiad.apis.article.IArticleClient;
import com.paiad.model.article.dtos.ArticleDto;
import com.paiad.model.common.dtos.ResponseResult;
import com.paiad.model.common.enums.AppHttpCodeEnum;
import org.springframework.stereotype.Component;

@Component
public class IArticleClientFallback implements IArticleClient {
    @Override
    public ResponseResult saveArticle(ArticleDto dto) {
        return ResponseResult.errorResult(AppHttpCodeEnum.SERVER_ERROR,"获取数据失败");
    }
}
