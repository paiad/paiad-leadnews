# Paiad Leadnews 媒体端

基于 Vue 3 + TypeScript 的媒体管理前端应用。

## 技术栈

| 技术         | 版本 | 用途       |
| ------------ | ---- | ---------- |
| Vue          | 3.5  | 核心框架   |
| TypeScript   | 5.9  | 类型支持   |
| Vite         | 7.2  | 构建工具   |
| Element Plus | 2.11 | UI 组件库  |
| Pinia        | 3.0  | 状态管理   |
| Vue Router   | 4.6  | 路由管理   |
| Axios        | 1.13 | HTTP 请求  |
| UnoCSS       | 66.5 | 原子化 CSS |

## 快速开始

```bash
# 安装依赖
npm install

# 启动开发服务器
npm run dev

# 构建生产版本
npm run build
```

## 项目结构

```
src/
├── api/          # API 接口定义
├── assets/       # 静态资源
├── components/   # 公共组件
├── composables/  # 组合式函数
├── router/       # 路由配置
├── stores/       # Pinia 状态
├── types/        # TypeScript 类型
├── utils/        # 工具函数
└── views/        # 页面视图
    ├── Home.vue       # 首页
    ├── Login.vue      # 登录
    ├── Layout.vue     # 布局框架
    ├── news/          # 内容管理
    ├── material/      # 素材管理
    └── links/         # 链接速览
```

## 功能模块

- **首页** - 数据概览
- **发布文章** - 图文创作与发布
- **内容管理** - 文章列表与编辑
- **素材管理** - 图片素材库
- **链接速览** - 服务地址快捷入口

## 开发配置

开发服务器默认运行在 `http://localhost:5173`，API 请求自动代理至后端网关。
