<template>
  <div class="login-container">
    <div class="login-box">
      <div class="login-header">
        <div class="logo-icon">
          <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M12 2L2 7L12 12L22 7L12 2Z" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M2 17L12 22L22 17" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            <path d="M2 12L12 17L22 12" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
          </svg>
        </div>
        <h2>Paiad Media</h2>
        <p>Sign in to manage your content</p>
      </div>
      
      <el-form 
        :model="loginForm" 
        :rules="rules" 
        ref="loginFormRef" 
        label-position="top" 
        size="large"
        class="login-form"
      >
        <el-form-item prop="name">
          <el-input 
            v-model="loginForm.name" 
            placeholder="Username" 
            class="custom-input"
          >
            <template #prefix>
              <div class="i-carbon-user text-gray-400" />
            </template>
          </el-input>
        </el-form-item>
        
        <el-form-item prop="password">
          <el-input 
            v-model="loginForm.password" 
            type="password" 
            placeholder="Password" 
            show-password 
            class="custom-input"
          >
            <template #prefix>
              <div class="i-carbon-locked text-gray-400" />
            </template>
          </el-input>
        </el-form-item>
        
        <div class="form-footer">
          <el-checkbox v-model="rememberMe" class="custom-checkbox">Remember me</el-checkbox>
          <a href="#" class="forgot-password">Forgot password?</a>
        </div>
        
        <el-form-item>
          <el-button 
            type="primary" 
            class="login-button" 
            @click="handleLogin" 
            :loading="loading"
          >
            Sign In
          </el-button>
        </el-form-item>
      </el-form>
    </div>
    
    <div class="login-footer">
      <p>&copy; 2025 Paiad Media. All rights reserved.</p>
    </div>
  </div>
</template>

<script setup lang="ts">
import { reactive, ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { ElMessage } from 'element-plus'
import type { FormInstance, FormRules } from 'element-plus'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()
const loginFormRef = ref<FormInstance>()
const loading = ref(false)
const rememberMe = ref(false)

const loginForm = reactive({
  name: 'admin',
  password: 'admin'
})

const rules = reactive<FormRules>({
  name: [{ required: true, message: 'Please enter username', trigger: 'blur' }],
  password: [{ required: true, message: 'Please enter password', trigger: 'blur' }]
})

onMounted(() => {
  const savedCredentials = localStorage.getItem('savedCredentials')
  if (savedCredentials) {
    try {
      const { name, password } = JSON.parse(savedCredentials)
      loginForm.name = name
      loginForm.password = password
      rememberMe.value = true
    } catch (e) {
      console.error('Failed to parse saved credentials', e)
    }
  }
})

const handleLogin = async () => {
  if (!loginFormRef.value) return
  await loginFormRef.value.validate(async (valid) => {
    if (valid) {
      loading.value = true
      const success = await userStore.login(loginForm)
      loading.value = false
      if (success) {
        if (rememberMe.value) {
          localStorage.setItem('savedCredentials', JSON.stringify({
            name: loginForm.name,
            password: loginForm.password
          }))
        } else {
          localStorage.removeItem('savedCredentials')
        }
        
        ElMessage.success('Welcome back')
        router.push('/')
      } else {
        ElMessage.error('Invalid username or password')
      }
    }
  })
}
</script>

<style scoped lang="scss">
.login-container {
  height: 100vh;
  width: 100vw;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  background-image: url('@/assets/login-bg.png');
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  position: relative;
  overflow: hidden;

  // Overlay to ensure text readability if image is too bright/busy
  &::before {
    content: '';
    position: absolute;
    inset: 0;
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(10px); // Global blur for depth
    z-index: 0;
  }
}

.login-box {
  position: relative;
  z-index: 1;
  width: 360px;
  padding: 40px;
  background: rgba(255, 255, 255, 0.75);
  backdrop-filter: blur(24px);
  -webkit-backdrop-filter: blur(24px);
  border-radius: 24px;
  box-shadow: 
    0 20px 40px -12px rgba(0, 0, 0, 0.12),
    0 0 0 1px rgba(255, 255, 255, 0.5) inset;
  animation: slideUpFade 0.6s cubic-bezier(0.16, 1, 0.3, 1);

  .login-header {
    text-align: center;
    margin-bottom: 32px;
    
    .logo-icon {
      width: 48px;
      height: 48px;
      background: linear-gradient(135deg, #000000 0%, #333333 100%);
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      margin: 0 auto 16px;
      color: white;
      box-shadow: 0 8px 16px -4px rgba(0, 0, 0, 0.2);
    }
    
    h2 {
      margin: 0 0 8px;
      color: #1d1d1f;
      font-size: 24px;
      font-weight: 600;
      letter-spacing: -0.5px;
    }
    
    p {
      margin: 0;
      color: #86868b;
      font-size: 14px;
    }
  }
  
  // Customize Element Plus Inputs
  :deep(.el-input__wrapper) {
    background-color: rgba(255, 255, 255, 0.8);
    box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.08) inset;
    border-radius: 12px;
    padding: 1px 16px;
    height: 44px;
    transition: all 0.2s ease;
    
    &:hover {
      background-color: rgba(255, 255, 255, 1);
      box-shadow: 0 0 0 1px rgba(0, 0, 0, 0.15) inset;
    }
    
    &.is-focus {
      background-color: #fff;
      box-shadow: 0 0 0 2px #000000 inset !important; // Apple black focus
    }
    
    input {
      height: 100%;
      color: #1d1d1f;
      font-size: 15px;
      
      &::placeholder {
        color: #86868b;
      }
    }
  }

  .form-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 24px;
    margin-top: -8px;
    
    .custom-checkbox {
      :deep(.el-checkbox__label) {
        color: #424245;
        font-weight: 400;
      }
      :deep(.el-checkbox__inner) {
        border-radius: 4px;
      }
    }
    
    .forgot-password {
      font-size: 13px;
      color: #0066cc;
      text-decoration: none;
      transition: color 0.2s;
      
      &:hover {
        color: #004499;
        text-decoration: underline;
      }
    }
  }
  
  .login-button {
    width: 100%;
    height: 48px;
    font-size: 16px;
    font-weight: 500;
    border-radius: 24px; // Pill shape
    background: #1d1d1f;
    border: none;
    transition: all 0.2s cubic-bezier(0.645, 0.045, 0.355, 1);
    
    &:hover {
      background: #333333;
      transform: scale(1.01);
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
    }
    
    &:active {
      transform: scale(0.98);
    }
  }
}

.login-footer {
  position: absolute;
  bottom: 24px;
  z-index: 1;
  
  p {
    color: #86868b;
    font-size: 12px;
    opacity: 0.8;
  }
}

@keyframes slideUpFade {
  from {
    opacity: 0;
    transform: translateY(20px) scale(0.98);
  }
  to {
    opacity: 1;
    transform: translateY(0) scale(1);
  }
}
</style>

