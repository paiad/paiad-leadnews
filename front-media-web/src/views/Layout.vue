<template>
  <el-container class="layout-container">
    <el-aside width="240px" class="aside">
      <div class="logo">𝑷𝒂𝒊𝒂𝒅 𝑳𝒆𝒂𝒅𝒏𝒆𝒘𝒔</div>
      <el-menu
        :default-active="activeMenu"
        class="el-menu-vertical"
        text-color="#1d1d1f"
        active-text-color="#ffffff"
        router
      >
        <el-menu-item index="/layout/home">
          <el-icon><HomeFilled /></el-icon>
          <span>首页</span>
        </el-menu-item>
        <el-menu-item index="/layout/news/publish">
          <el-icon><Edit /></el-icon>
          <span>发布文章</span>
        </el-menu-item>
        <el-menu-item index="/layout/news/index">
          <el-icon><Document /></el-icon>
          <span>内容管理</span>
        </el-menu-item>
        <el-menu-item index="/layout/material">
          <el-icon><Picture /></el-icon>
          <span>素材管理</span>
        </el-menu-item>
        <el-menu-item index="/layout/links">
          <el-icon><Link /></el-icon>
          <span>链接速览</span>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header class="header">
        <div class="header-content">
          <div class="user-info">
            <el-avatar :size="24" :src="userStore.user.image" class="user-avatar">
              <span>{{ (userStore.user.nickname || '用户').charAt(0) }}</span>
            </el-avatar>
            <span class="username">{{ userStore.user.nickname || '用户' }}</span>
            <span class="logout-btn i-majesticons-logout-half-circle-line" @click="logout" title="退出登录"></span>
          </div>
        </div>
      </el-header>
      <el-main class="main-content">
        <router-view />
      </el-main>
    </el-container>
  </el-container>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { HomeFilled, Document, Picture, Edit, Link } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

const activeMenu = computed(() => route.path)

const logout = () => {
  userStore.logout()
  router.push('/login')
}
</script>

<style scoped lang="scss">
.layout-container {
  height: 100vh;
  background-color: #f5f5f7;
}

.aside {
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  border-right: 1px solid rgba(0, 0, 0, 0.05);
  
  .logo {
    height: 64px;
    line-height: 64px;
    text-align: center;
    font-size: 18px;
    font-weight: 600;
    color: #1d1d1f;
  }
  
  .el-menu-vertical {
    background: transparent;
    border-right: none;
    padding: 12px;
    
    .el-menu-item {
      height: 44px;
      line-height: 44px;
      border-radius: 12px;
      margin-bottom: 4px;
      font-weight: 500;
      
      &:hover {
        background-color: rgba(0, 0, 0, 0.04);
      }
      
      &.is-active {
        background-color: #000000;
        color: white;
        
        .el-icon {
          color: white;
        }
      }
    }
  }
}

.header {
  height: 64px;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding: 0 32px;
  
  .header-content {
    .user-info {
      display: flex;
      align-items: center;
      gap: 12px;
      
      .user-avatar {
        background-color: #ffffff;
        color: white;
        font-weight: 500;
        font-size: px;
      }
      
      .username {
        font-weight: 500;
        font-size: 14px;
      }
      
      .logout-btn {
        font-size: 18px;
        color: #86868b;
        cursor: pointer;
        transition: color 0.2s;
        
        &:hover {
          color: #000000;
        }
      }
    }
  }
}

.main-content {
  padding: 32px;
}
</style>
