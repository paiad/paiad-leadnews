<template>
  <el-container class="layout-container">
    <div class="aside" :class="{ collapsed: isCollapsed }">
      <!-- Logo 区域 -->
      <div class="logo">
        <el-avatar :size="28" src="https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/icon/sunflower.svg" class="logo-avatar"/>
        <span v-show="!isCollapsed" class="logo-text">𝑳𝒆𝒂𝒅𝒏𝒆𝒘𝒔</span>
      </div>
      
      <!-- 菜单区域 -->
      <nav class="menu">
        <router-link 
          v-for="item in menuItems" 
          :key="item.path"
          :to="item.path"
          class="menu-item"
          :class="{ active: isActive(item.path) }"
        >
          <el-icon :size="20"><component :is="item.icon" /></el-icon>
          <span v-show="!isCollapsed" class="menu-text">{{ item.title }}</span>
        </router-link>
      </nav>
    </div>
    
    <el-container>
      <el-header class="header">
        <div class="header-left">
          <div class="collapse-btn" @click="toggleCollapse">
            <el-icon :size="18">
              <Fold v-if="!isCollapsed" />
              <Expand v-else />
            </el-icon>
          </div>
        </div>
        <div class="header-right">
          <div class="user-info">
            <el-avatar :size="26" :src="userStore.user.image" class="user-avatar">
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
import { ref, markRaw } from 'vue'
import { useRouter, useRoute } from 'vue-router'
import { HomeFilled, Document, Picture, Edit, Link, Menu, Fold, Expand } from '@element-plus/icons-vue'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const route = useRoute()
const userStore = useUserStore()

// 侧边栏折叠状态
const isCollapsed = ref(false)

const toggleCollapse = () => {
  isCollapsed.value = !isCollapsed.value
}

// 菜单配置
const menuItems = [
  { path: '/layout/home', title: '首页', icon: markRaw(HomeFilled) },
  { path: '/layout/news/publish', title: '发布文章', icon: markRaw(Edit) },
  { path: '/layout/news/index', title: '内容管理', icon: markRaw(Document) },
  { path: '/layout/material', title: '素材管理', icon: markRaw(Picture) },
  { path: '/layout/channel', title: '频道管理', icon: markRaw(Menu) },
  { path: '/layout/links', title: '链接速览', icon: markRaw(Link) }
]

const isActive = (path: string) => {
  return route.path === path || route.path.startsWith(path + '/')
}

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
  width: 200px;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  border-right: 1px solid rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
  transition: width 0.25s ease;
  overflow: hidden;
  
  &.collapsed {
    width: 64px;
    
    .logo {
      justify-content: center;
      padding: 0;
    }
    
    .menu-item {
      justify-content: center;
      padding: 0;
      
      .el-icon {
        margin: 0;
      }
    }
  }
}

.logo {
  height: 64px;
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 0 32px;
  flex-shrink: 0;
  
  .logo-avatar {
    background-color: #ffffff;
    border: 1px solid #e5e5e7;
    flex-shrink: 0;
  }
  
  .logo-text {
    font-size: 17px;
    font-weight: 600;
    color: #1d1d1f;
    white-space: nowrap;
    flex: 1;
  }
  
  .collapse-btn {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    color: #86868b;
    border-radius: 8px;
    border: 1px solid #e5e5e7;
    background: #ffffff;
    transition: all 0.15s ease;
    flex-shrink: 0;
    
    &:hover {
      color: #1d1d1f;
      border-color: #1d1d1f;
    }
  }
}

.menu {
  flex: 1;
  padding: 8px 12px;
  display: flex;
  flex-direction: column;
  gap: 4px;
  overflow: hidden;
}

.menu-item {
  height: 44px;
  display: flex;
  align-items: center;
  gap: 12px;
  padding: 0 16px;
  border-radius: 12px;
  color: #1d1d1f;
  text-decoration: none;
  font-weight: 500;
  font-size: 14px;
  transition: all 0.15s ease;
  
  .el-icon {
    flex-shrink: 0;
  }
  
  .menu-text {
    white-space: nowrap;
  }
  
  &:hover {
    background-color: rgba(0, 0, 0, 0.04);
  }
  
  &.active {
    background-color: #000000;
    color: #ffffff;
  }
}

.collapse-btn {
  width: 36px;
  height: 36px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  color: #86868b;
  border-radius: 10px;
  border: 1px solid #e5e5e7;
  background: #ffffff;
  transition: all 0.15s ease;
  
  &:hover {
    color: #1d1d1f;
    border-color: #1d1d1f;
  }
}

.header {
  height: 64px;
  background-color: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  border-bottom: 1px solid rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 24px;
  
  .header-left {
    display: flex;
    align-items: center;
  }
  
  .header-right {
    display: flex;
    align-items: center;
  }
  
  .user-info {
    display: flex;
    align-items: center;
    gap: 12px;
    
    .user-avatar {
      background-color: #ffffff;
      font-weight: 500;
      font-size: 12px;
    }
    
    .username {
      font-weight: 500;
      font-size: 14px;
    }
    
    .logout-btn {
      font-size: 18px;
      color: #86868b;
      cursor: pointer;
      transition: color 0.15s;
      
      &:hover {
        color: #000000;
      }
    }
  }
}

.main-content {
  padding: 32px;
}
</style>
