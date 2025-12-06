<template>
  <view class="index-container">
    <view class="header">
      <text class="title">首页</text>
      <text class="subtitle">欢迎使用 Paiad Leadnews</text>
    </view>

    <view class="content">
      <view class="user-info" v-if="hasToken">
        <uni-icons type="checkbox" size="24" color="#34c759"></uni-icons>
        <text class="info-text">您已登录</text>
      </view>
      
      <button class="logout-button" @click="handleLogout">
        退出登录
      </button>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'

const hasToken = ref(false)

onMounted(() => {
  const token = uni.getStorageSync('token')
  hasToken.value = !!token
})

function handleLogout() {
  uni.removeStorageSync('token')
  uni.showToast({
    title: '已退出登录',
    icon: 'success',
    duration: 1500
  })
  
  setTimeout(() => {
    uni.reLaunch({
      url: '/pages/login/index'
    })
  }, 1500)
}
</script>

<style lang="scss" scoped>
.index-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  padding: 120rpx 48rpx 60rpx;
  background-color: #ffffff;
  box-sizing: border-box;
}

.header {
  margin-bottom: 60rpx;

  .title {
    display: block;
    font-size: 56rpx;
    font-weight: 600;
    color: #1d1d1f;
    letter-spacing: -1rpx;
    margin-bottom: 12rpx;
  }

  .subtitle {
    display: block;
    font-size: 28rpx;
    color: #86868b;
  }
}

.content {
  flex: 1;
}

.user-info {
  display: flex;
  align-items: center;
  padding: 32rpx;
  background-color: #f5f5f7;
  border-radius: 24rpx;
  margin-bottom: 40rpx;

  .info-text {
    margin-left: 16rpx;
    font-size: 30rpx;
    color: #1d1d1f;
  }
}

.logout-button {
  width: 100%;
  height: 100rpx;
  background-color: #f5f5f7;
  color: #1d1d1f;
  font-size: 32rpx;
  font-weight: 500;
  border-radius: 50rpx;
  border: none;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;

  &:active {
    transform: scale(0.98);
    background-color: #e8e8ed;
  }
}
</style>
