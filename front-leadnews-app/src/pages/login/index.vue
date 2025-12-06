<template>
  <view class="login-container">
    <!-- Header -->
    <view class="login-header">
      <view class="logo-icon">
        <image class="logo-image" src="/static/logo.svg" mode="aspectFit"></image>
      </view>
      <text class="app-title">𝑷𝒂𝒊𝒂𝒅 𝑳𝒆𝒂𝒅𝒏𝒆𝒘𝒔</text>
    </view>

    <!-- Form -->
    <view class="login-form">
      <!-- Phone Input -->
      <view class="input-group">
        <view class="input-wrapper" :class="{ focused: phoneInputFocused }">
          <view class="input-icon-wrapper">
            <uni-icons type="phone" size="20" color="#86868b"></uni-icons>
          </view>
          <input
            type="text"
            v-model="form.phone"
            placeholder="手机号"
            maxlength="11"
            @focus="phoneInputFocused = true"
            @blur="phoneInputFocused = false"
            class="uni-input"
          />
        </view>
        <text v-if="errors.phone" class="error-text">{{ errors.phone }}</text>
      </view>

      <!-- Password Input -->
      <view class="input-group">
        <view class="input-wrapper" :class="{ focused: passwordInputFocused }">
          <view class="input-icon-wrapper">
            <uni-icons type="locked" size="20" color="#86868b"></uni-icons>
          </view>
          <input
            :type="showPassword ? 'text' : 'password'"
            v-model="form.password"
            placeholder="密码"
            @focus="passwordInputFocused = true"
            @blur="passwordInputFocused = false"
            class="uni-input"
          />
          <view class="toggle-password" @click="showPassword = !showPassword">
            <uni-icons 
              :type="showPassword ? 'eye' : 'eye-slash'" 
              size="20" 
              color="#86868b"
            ></uni-icons>
          </view>
        </view>
        <text v-if="errors.password" class="error-text">{{ errors.password }}</text>
      </view>

      <!-- Login Button -->
      <button 
        class="login-button" 
        :class="{ loading: isLoading }"
        :disabled="isLoading"
        @click="handleLogin"
      >
        <text v-if="!isLoading">登录</text>
        <view v-else class="loading-spinner"></view>
      </button>
    </view>

    <!-- Footer -->
    <view class="login-footer">
      <text class="footer-text">© 2025 Paiad Leadnews.All rights reserved</text>
    </view>
  </view>
</template>

<script setup lang="ts">
import { ref, reactive } from 'vue'
import { login } from '@/api/user'
// @ts-ignore
import UniIcons from '@dcloudio/uni-ui/lib/uni-icons/uni-icons.vue'

// Form data
const form = reactive({
  phone: '13511223456',
  password: 'admin'
})

// Form errors
const errors = reactive({
  phone: '',
  password: ''
})

// UI states
const isLoading = ref(false)
const showPassword = ref(false)
const phoneInputFocused = ref(false)
const passwordInputFocused = ref(false)

/**
 * 验证表单
 */
function validateForm(): boolean {
  let isValid = true
  errors.phone = ''
  errors.password = ''

  // 验证手机号
  if (!form.phone) {
    errors.phone = '请输入手机号'
    isValid = false
  } else if (!/^1[3-9]\d{9}$/.test(form.phone)) {
    errors.phone = '请输入正确的手机号'
    isValid = false
  }

  // 验证密码
  if (!form.password) {
    errors.password = '请输入密码'
    isValid = false
  } else if (form.password.length < 4) {
    errors.password = '密码长度不能少于4位'
    isValid = false
  }

  return isValid
}

/**
 * 处理登录
 */
async function handleLogin() {
  // 验证表单
  if (!validateForm()) {
    return
  }

  isLoading.value = true

  try {
    const res = await login({
      phone: form.phone,
      password: form.password
    })

    // 保存 token
    if (res.data?.token) {
      uni.setStorageSync('token', res.data.token)
    }

    // 显示成功提示
    uni.showToast({
      title: '登录成功',
      icon: 'success',
      duration: 1500
    })

    // 跳转首页
    setTimeout(() => {
      uni.reLaunch({
        url: '/pages/index/index'
      })
    }, 1500)

  } catch (error: any) {
    // 错误提示已在 request.ts 中处理
    console.error('登录失败:', error)
  } finally {
    isLoading.value = false
  }
}
</script>

<script lang="ts">
// @ts-ignore
import UniIcons from '@dcloudio/uni-ui/lib/uni-icons/uni-icons.vue'

export default {
  components: {
    UniIcons
  }
}
</script>

<style lang="scss" scoped>
.login-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  padding: 60rpx 48rpx;
  background-color: #ffffff;
  box-sizing: border-box;
}

.login-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 48rpx;

  .logo-icon {
    width: 120rpx;
    height: 120rpx;
    background: #ffffff;
    border-radius: 24rpx;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-bottom: 32rpx;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.08);

    .logo-image {
      width: 80rpx;
      height: 80rpx;
    }
  }

  .app-title {
    font-size: 44rpx;
    font-weight: 600;
    color: #1d1d1f;
    letter-spacing: -1rpx;
    margin-bottom: 12rpx;
  }
}

.login-form {
  width: 100%;
  max-width: 600rpx;
}

.input-group {
  margin-bottom: 32rpx;
}

.input-wrapper {
  display: flex;
  align-items: center;
  background-color: #f5f5f7;
  border-radius: 24rpx;
  padding: 0 32rpx;
  height: 100rpx;
  border: 2rpx solid transparent;
  transition: all 0.2s ease;

  &.focused {
    background-color: #ffffff;
    border-color: #1d1d1f;
  }

  .input-icon-wrapper {
    margin-right: 20rpx;
    flex-shrink: 0;
    display: flex;
    align-items: center;
  }

  .uni-input {
    flex: 1;
    height: 100%;
    font-size: 30rpx;
    color: #1d1d1f;
    background: transparent;
  }

  .toggle-password {
    padding: 16rpx;
    margin-right: -16rpx;
    flex-shrink: 0;
    display: flex;
    align-items: center;
  }
}

.error-text {
  display: block;
  font-size: 24rpx;
  color: #ff3b30;
  margin-top: 12rpx;
  margin-left: 32rpx;
}

.login-button {
  width: 100%;
  height: 100rpx;
  background-color: #1d1d1f;
  color: #ffffff;
  font-size: 32rpx;
  font-weight: 500;
  border-radius: 50rpx;
  border: none;
  margin-top: 48rpx;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;

  &:active {
    transform: scale(0.98);
    opacity: 0.9;
  }

  &.loading {
    opacity: 0.7;
  }

  &[disabled] {
    opacity: 0.5;
  }
}

.loading-spinner {
  width: 40rpx;
  height: 40rpx;
  border: 4rpx solid rgba(255, 255, 255, 0.3);
  border-top-color: #ffffff;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.login-footer {
  position: absolute;
  bottom: 60rpx;
  left: 0;
  right: 0;
  text-align: center;

  .footer-text {
    font-size: 24rpx;
    color: #86868b;
  }
}
</style>
