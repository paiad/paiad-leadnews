# Paiad Leadnews

基于 Spring Cloud 的头条内容管理系统。

## 技术栈

| 技术                 | 用途               |
| -------------------- | ------------------ |
| Spring Boot 2.7      | 基础框架           |
| Spring Cloud         | 微服务架构         |
| Nacos                | 服务注册与配置中心 |
| Spring Cloud Gateway | API 网关           |
| MyBatis-Plus         | 持久层框架         |
| MinIO                | 对象存储           |
| Kafka                | 消息队列           |
| Redis                | 缓存               |
| MySQL                | 数据库             |

## 模块结构

```
paiad-leadnews/
├── paiad-leadnews-gateway/     # 网关服务
├── paiad-leadnews-service/     # 业务服务
│   ├── paiad-leadnews-user/    # 用户服务 (51801)
│   ├── paiad-leadnews-article/ # 文章服务 (51802)
│   └── paiad-leadnews-wemedia/ # 媒体服务 (51803)
├── paiad-leadnews-model/       # 数据模型
├── paiad-leadnews-common/      # 公共模块
├── paiad-leadnews-utils/       # 工具类
├── paiad-leadnews-feign-api/   # Feign 接口
├── paiad-leadnews-basic/       # 基础服务
└── paiad-leadnews-test/        # 测试模块
```

## 前端项目

| 项目            | 说明        | 地址                  |
| --------------- | ----------- | --------------------- |
| app-web         | 用户端      | http://localhost:8801 |
| wemedia-web     | 媒体端 (旧) | http://localhost:8802 |
| front-media-web | 媒体端 (新) | http://localhost:5173 |

## 服务地址

| 服务         | 地址                            |
| ------------ | ------------------------------- |
| Nacos        | http://localhost:8848/nacos     |
| MinIO        | http://localhost:9000           |
| 用户接口文档 | http://localhost:51801/doc.html |
| 文章接口文档 | http://localhost:51802/doc.html |
| 媒体接口文档 | http://localhost:51803/doc.html |

## 快速启动

```bash
# 1. 启动基础设施
docker-compose up -d

# 2. 启动微服务 (按顺序)
# Gateway → User → Article → Wemedia
```
