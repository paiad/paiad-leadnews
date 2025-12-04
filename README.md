# Paiad Leadnews

基于 Spring Cloud 的内容管理系统

## 技术栈

Spring Boot · Spring Cloud · Nacos · Gateway · MyBatis-Plus · MinIO · Kafka · Redis · MySQL

## 架构

```
paiad-leadnews-gateway      # 网关 (51601)
paiad-leadnews-service
  ├── user                  # 用户服务 (51801)
  ├── article               # 文章服务 (51802)
  └── wemedia               # 媒体服务 (51803)
```

## 启动

```bash
# 基础设施
docker-compose up -d

# 微服务
Gateway → User → Article → Wemedia
```

## 服务

| 名称     | 地址                            |
| -------- | ------------------------------- |
| Nacos    | http://localhost:8848/nacos     |
| MinIO    | http://localhost:9000           |
| 用户 API | http://localhost:51801/doc.html |
| 文章 API | http://localhost:51802/doc.html |
| 媒体 API | http://localhost:51803/doc.html |

## 前端

| 项目   | 地址                  |
| ------ | --------------------- |
| 用户端 | http://localhost:8801 |
| 媒体端 | http://localhost:5173 |
