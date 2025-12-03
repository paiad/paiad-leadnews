# 平台管理API文档


**简介**:平台管理API文档


**HOST**:localhost:51803


**联系人**:


**Version**:1.0


**接口路径**:/v2/api-docs?group=1.0


[TOC]






# 自媒体图文素材管理


## 查询素材列表


**接口地址**:`/api/v1/material/list`


**请求方式**:`POST`


**请求数据类型**:`application/json`


**响应数据类型**:`*/*`


**接口描述**:


**请求示例**:


```javascript
{
	"isCollection": 0,
	"page": 0,
	"size": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | in    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|dto|自媒体素材查询参数|body|true|WmMaterialDto|WmMaterialDto|
|&emsp;&emsp;isCollection|是否收藏 1 收藏 0 未收藏||false|integer(int32)||
|&emsp;&emsp;page|||false|integer(int32)||
|&emsp;&emsp;size|||false|integer(int32)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|ResponseResult|
|201|Created||
|401|Unauthorized||
|403|Forbidden||
|404|Not Found||


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||object||
|errorMessage||string||
|host||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {},
	"errorMessage": "",
	"host": ""
}
```


## 上传图片


**接口地址**:`/api/v1/material/upload_picture`


**请求方式**:`POST`


**请求数据类型**:`multipart/form-data`


**响应数据类型**:`*/*`


**接口描述**:


**请求参数**:


| 参数名称 | 参数说明 | in    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|multipartFile|multipartFile|formData|false|file||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|ResponseResult|
|201|Created||
|401|Unauthorized||
|403|Forbidden||
|404|Not Found||


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||object||
|errorMessage||string||
|host||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {},
	"errorMessage": "",
	"host": ""
}
```


# 自媒体文章管理


## 查询文章列表


**接口地址**:`/api/v1/news/list`


**请求方式**:`POST`


**请求数据类型**:`application/json`


**响应数据类型**:`*/*`


**接口描述**:


**请求示例**:


```javascript
{
	"beginPubDate": "",
	"channelId": 0,
	"endPubDate": "",
	"keyword": "",
	"page": 0,
	"size": 0,
	"status": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | in    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|dto|自媒体文章分页查询参数|body|true|WmNewsPageReqDto|WmNewsPageReqDto|
|&emsp;&emsp;beginPubDate|开始时间||false|string(date-time)||
|&emsp;&emsp;channelId|频道ID||false|integer(int32)||
|&emsp;&emsp;endPubDate|结束时间||false|string(date-time)||
|&emsp;&emsp;keyword|关键字||false|string||
|&emsp;&emsp;page|||false|integer(int32)||
|&emsp;&emsp;size|||false|integer(int32)||
|&emsp;&emsp;status|状态||false|integer(int32)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|ResponseResult|
|201|Created||
|401|Unauthorized||
|403|Forbidden||
|404|Not Found||


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||object||
|errorMessage||string||
|host||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {},
	"errorMessage": "",
	"host": ""
}
```


## 发表文章


**接口地址**:`/api/v1/news/submit`


**请求方式**:`POST`


**请求数据类型**:`application/json`


**响应数据类型**:`*/*`


**接口描述**:


**请求示例**:


```javascript
{
	"channelId": 0,
	"content": "",
	"id": 0,
	"images": [],
	"labels": "",
	"publishTime": "",
	"status": 0,
	"submitedTime": "",
	"title": "",
	"type": 0
}
```


**请求参数**:


| 参数名称 | 参数说明 | in    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|dto|自媒体文章提交参数|body|true|WmNewsDto|WmNewsDto|
|&emsp;&emsp;channelId|频道ID||false|integer(int32)||
|&emsp;&emsp;content|文章内容||false|string||
|&emsp;&emsp;id|文章ID||false|integer(int32)||
|&emsp;&emsp;images|封面图片列表||false|array|string|
|&emsp;&emsp;labels|标签||false|string||
|&emsp;&emsp;publishTime|发布时间||false|string(date-time)||
|&emsp;&emsp;status|状态 1 提交 0 草稿||false|integer(int32)||
|&emsp;&emsp;submitedTime|提交时间||false|string(date-time)||
|&emsp;&emsp;title|标题||false|string||
|&emsp;&emsp;type|封面类型 0 无图 1 单图 3 多图 -1 自动||false|integer(int32)||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|ResponseResult|
|201|Created||
|401|Unauthorized||
|403|Forbidden||
|404|Not Found||


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||object||
|errorMessage||string||
|host||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {},
	"errorMessage": "",
	"host": ""
}
```


# 自媒体用户登录


## 自媒体用户登录


**接口地址**:`/login/in`


**请求方式**:`POST`


**请求数据类型**:`application/json`


**响应数据类型**:`*/*`


**接口描述**:


**请求示例**:


```javascript
{
	"name": "",
	"password": ""
}
```


**请求参数**:


| 参数名称 | 参数说明 | in    | 是否必须 | 数据类型 | schema |
| -------- | -------- | ----- | -------- | -------- | ------ |
|dto|自媒体登录参数|body|true|WmLoginDto|WmLoginDto|
|&emsp;&emsp;name|用户名||false|string||
|&emsp;&emsp;password|密码||false|string||


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|ResponseResult|
|201|Created||
|401|Unauthorized||
|403|Forbidden||
|404|Not Found||


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||object||
|errorMessage||string||
|host||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {},
	"errorMessage": "",
	"host": ""
}
```


# 自媒体频道管理


## 查询所有频道


**接口地址**:`/api/v1/channel/channels`


**请求方式**:`GET`


**请求数据类型**:`*`


**响应数据类型**:`*/*`


**接口描述**:


**请求参数**:


暂无


**响应状态**:


| 状态码 | 说明 | schema |
| -------- | -------- | ----- | 
|200|OK|ResponseResult|
|401|Unauthorized||
|403|Forbidden||
|404|Not Found||


**响应参数**:


| 参数名称 | 参数说明 | 类型 | schema |
| -------- | -------- | ----- |----- | 
|code||integer(int32)|integer(int32)|
|data||object||
|errorMessage||string||
|host||string||


**响应示例**:
```javascript
{
	"code": 0,
	"data": {},
	"errorMessage": "",
	"host": ""
}
```