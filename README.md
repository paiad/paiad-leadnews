# Paiad Leadnews

> 基于 Spring Cloud Alibaba 微服务架构的分布式内容分发平台

Paiad Leadnews 是一个全栈式的内容管理与分发系统，集成了用户端（App）、自媒体端（Wemedia）和管理端（Admin）。项目采用现代化的微服务架构设计，具备高性能、高可用和易扩展的特性。

## 🏗 核心架构

### 业务模块

| 模块                | 描述                                             | 端口  |
| ------------------- | ------------------------------------------------ | ----- |
| **User Service**    | 用户行为中心，处理登录、关注、收藏等用户交互     | 51801 |
| **Article Service** | 文章内容中心，负责冷热数据分离、静态化页面存储   | 51802 |
| **Wemedia Service** | 自媒体创作中心，提供素材管理、文章发布与审核流程 | 51803 |
| **Gateway**         | 统一 API 网关，负责路由转发、鉴权与流控          | 51601 |

### 技术架构

- **接入层**: Spring Cloud Gateway + JWT 鉴权
- **服务层**: Spring Boot 业务逻辑实现
- **治理层**: Nacos (服务发现/配置中心), Sentinel (流量防卫兵)
- **数据层**: MySQL (持久化), Redis (缓存), MongoDB (动态数据)
- **中间件**: Kafka (异步解耦/削峰), ElasticSearch (全文检索), MinIO (海量文件存储)
- **运维**: Docker 容器化部署, XXL-JOB 分布式任务调度

## 🛠 技术栈概览

| 领域          | 核心技术                | 版本          |
| ------------- | ----------------------- | ------------- |
| **开发框架**  | Spring Boot             | 2.3.9.RELEASE |
| **微服务**    | Spring Cloud Hoxton     | SR10          |
| **云原生**    | Spring Cloud Alibaba    | 2.2.5.RELEASE |
| **持久层**    | MyBatis Plus            | 3.4.1         |
| **数据库**    | MySQL 5.7 / MongoDB 4.0 | -             |
| **缓存/消息** | Redis 5.0 / Kafka 2.5.1 | -             |
| **搜索引擎**  | ElasticSearch           | 7.x           |
| **工具支持**  | Lombok, Knife4j, HanLP  | -             |

## 🚀 快速启动指南

### 前置要求

确保本地或服务器已安装并启动以下基础设施（推荐使用根目录下的 `docker-compose.yml`）：

- MySQL (3306)
- Redis (6379)
- Nacos (8848)
- Kafka (9092) & Zookeeper (2181)
- MinIO (9000/9001)
- ElasticSearch (9200)

### 启动步骤

1. **初始化数据库**: 导入 `/sql` 目录下的初始化脚本。
2. **配置 Nacos**: 导入 `/nacos_config` 中的配置文件，并修改数据库/Redis 连接信息。
3. **启动微服务**:
   建议按以下顺序启动：
   - `LeadnewsGatewayApplication` (网关)
   - `LeadnewsUserApplication` (用户)
   - `LeadnewsArticleApplication` (文章)
   - `LeadnewsWemediaApplication` (自媒体)
