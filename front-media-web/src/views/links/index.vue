<template>
  <div class="links-container">
    <div class="page-header">
      <h1>链接速览</h1>
      <p class="subtitle">快速访问系统服务和文档</p>
    </div>
    
    <div class="links-grid">
      <!-- 前端访问地址 -->
      <div class="link-card">
        <div class="card-header">
          <div class="icon-wrapper blue">
            <el-icon><Monitor /></el-icon>
          </div>
          <h2>前端访问地址</h2>
        </div>
        <div class="card-content">
          <a href="http://localhost:8801/#/login" target="_blank" class="link-item">
            <span class="link-label">用户端</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </a>
          <a href="http://localhost:8802/#/login" target="_blank" class="link-item">
            <span class="link-label">媒体端</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </a>
          <a href="http://localhost:5173/login" target="_blank" class="link-item">
            <span class="link-label">Paiad Platform</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </a>
        </div>
      </div>

      <!-- Nacos -->
      <div class="link-card">
        <div class="card-header">
          <div class="icon-wrapper green">
            <el-icon><Setting /></el-icon>
          </div>
          <h2>Nacos</h2>
        </div>
        <div class="card-content">
          <a href="http://localhost:8848/nacos" target="_blank" class="link-item">
            <span class="link-label">服务注册与配置中心</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </a>
        </div>
      </div>

      <!-- MinIO -->
      <div class="link-card">
        <div class="card-header">
          <div class="icon-wrapper orange">
            <el-icon><FolderOpened /></el-icon>
          </div>
          <h2>MinIO</h2>
        </div>
        <div class="card-content">
          <a href="http://localhost:9000/" target="_blank" class="link-item">
            <span class="link-label">对象存储控制台</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </a>
        </div>
      </div>

      <!-- Knife4j Doc -->
      <div class="link-card">
        <div class="card-header">
          <div class="icon-wrapper purple">
            <el-icon><Document /></el-icon>
          </div>
          <h2>Knife4j 接口文档</h2>
        </div>
        <div class="card-content">
          <a href="http://localhost:51801/doc.html" target="_blank" class="link-item">
            <span class="link-label">用户接口文档</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </a>
          <a href="http://localhost:51802/doc.html" target="_blank" class="link-item">
            <span class="link-label">文章接口文档</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </a>
          <a href="http://localhost:51803/doc.html" target="_blank" class="link-item">
            <span class="link-label">媒体接口文档</span>
            <el-icon class="arrow-icon"><ArrowRight /></el-icon>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Monitor, Setting, FolderOpened, Document, ArrowRight } from '@element-plus/icons-vue'
</script>

<style scoped lang="scss">
.links-container {
  max-width: 1000px;
  margin: 0 auto;
}

.page-header {
  margin-bottom: 32px;
  
  h1 {
    font-size: 28px;
    font-weight: 600;
    color: #1d1d1f;
    margin: 0 0 6px 0;
    letter-spacing: -0.3px;
  }
  
  .subtitle {
    font-size: 15px;
    color: #86868b;
    margin: 0;
  }
}

.links-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr);
  gap: 20px;
  
  @media (max-width: 768px) {
    grid-template-columns: 1fr;
  }
}

.link-card {
  background: #fff;
  border-radius: 16px;
  padding: 24px;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.06);
  transition: box-shadow 0.2s ease;
  
  &:hover {
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
  }
  
  .card-header {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 16px;
    
    .icon-wrapper {
      width: 36px;
      height: 36px;
      border-radius: 10px;
      display: flex;
      align-items: center;
      justify-content: center;
      
      .el-icon {
        font-size: 18px;
        color: #fff;
      }
      
      &.blue { background: #007aff; }
      &.green { background: #34c759; }
      &.orange { background: #ff9500; }
      &.purple { background: #af52de; }
    }
    
    h2 {
      font-size: 17px;
      font-weight: 600;
      color: #1d1d1f;
      margin: 0;
    }
  }
  
  .card-content {
    display: flex;
    flex-direction: column;
  }
  
  .link-item {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 12px 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);
    text-decoration: none;
    transition: opacity 0.15s ease;
    
    &:last-child {
      border-bottom: none;
    }
    
    &:hover {
      .link-label {
        color: #007aff;
      }
      
      .arrow-icon {
        transform: translateX(2px);
        color: #007aff;
      }
    }
    
    .link-label {
      font-size: 15px;
      font-weight: 400;
      color: #1d1d1f;
      transition: color 0.15s ease;
    }
    
    .arrow-icon {
      font-size: 14px;
      color: #c7c7cc;
      transition: all 0.15s ease;
    }
  }
}
</style>
