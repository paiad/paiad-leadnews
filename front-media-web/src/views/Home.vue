<template>
  <div class="page-container">
    <div class="welcome-section">
      <h1 class="welcome-title">欢迎来到 `𝑳𝒆𝒂𝒅𝒏𝒆𝒘𝒔` 自媒体平台</h1>
      <p class="welcome-subtitle">一站式管理您的内容和素材</p>
    </div>
    
    <div class="dashboard-grid">
      <div class="dashboard-card" @click="$router.push('/layout/news/publish')">
        <div class="card-icon blue">
          <el-icon><Edit /></el-icon>
        </div>
        <div class="card-content">
          <h2 class="card-title">发布文章</h2>
          <p class="card-desc">创作并发布新的内容给您的读者。</p>
        </div>
        <div class="card-arrow">
          <el-icon><ArrowRight /></el-icon>
        </div>
      </div>
      
      <div class="dashboard-card" @click="$router.push('/layout/material')">
        <div class="card-icon purple">
          <el-icon><Picture /></el-icon>
        </div>
        <div class="card-content">
          <h2 class="card-title">素材管理</h2>
          <p class="card-desc">上传和管理您的图片素材。</p>
        </div>
        <div class="card-arrow">
          <el-icon><ArrowRight /></el-icon>
        </div>
      </div>
      
      <div class="dashboard-card" @click="$router.push('/layout/news/index')">
        <div class="card-icon green">
          <el-icon><List /></el-icon>
        </div>
        <div class="card-content">
          <h2 class="card-title">内容列表</h2>
          <p class="card-desc">查看、编辑和管理您已发布的内容。</p>
        </div>
        <div class="card-arrow">
          <el-icon><ArrowRight /></el-icon>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { Edit, Picture, List, ArrowRight } from '@element-plus/icons-vue'
</script>

<style scoped lang="scss">
.page-container {
  max-width: 1000px;
  margin: 0 auto;
  padding-top: 40px;
}

.welcome-section {
  text-align: center;
  margin-bottom: 60px;
  
  .welcome-title {
    font-size: 40px;
    font-weight: 700;
    color: #1d1d1f;
    margin: 0 0 16px;
    letter-spacing: -0.02em;
  }
  
  .welcome-subtitle {
    font-size: 20px;
    color: #86868b;
    margin: 0;
  }
}

.dashboard-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 24px;
}

.dashboard-card {
  background: white;
  border-radius: 20px;
  padding: 32px;
  cursor: pointer;
  transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
  box-shadow: 0 4px 24px rgba(0, 0, 0, 0.04);
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  position: relative;
  overflow: hidden;
  
  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 12px 32px rgba(0, 0, 0, 0.08);
    
    .card-arrow {
      opacity: 1;
      transform: translateX(0);
    }
  }
  
  .card-icon {
    width: 48px;
    height: 48px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 24px;
    margin-bottom: 24px;
    
    &.blue {
      background-color: #e8f2ff;
      color: #0066cc;
    }
    
    &.purple {
      background-color: #f5f0ff;
      color: #8844ff;
    }
    
    &.green {
      background-color: #e6fffa;
      color: #00cc99;
    }
  }
  
  .card-content {
    .card-title {
      font-size: 20px;
      font-weight: 600;
      color: #1d1d1f;
      margin: 0 0 8px;
    }
    
    .card-desc {
      font-size: 15px;
      color: #86868b;
      margin: 0;
      line-height: 1.5;
    }
  }
  
  .card-arrow {
    position: absolute;
    top: 32px;
    right: 32px;
    opacity: 0;
    transform: translateX(-10px);
    transition: all 0.3s ease;
    color: #d2d2d7;
  }
}
</style>
