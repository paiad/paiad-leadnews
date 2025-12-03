<template>
  <div class="login-container">
    <div class="login-box">
      <div class="login-header">
        <h2>Paiad 媒体平台</h2>
        <p>登录以管理您的内容</p>
      </div>
      <el-form :model="loginForm" :rules="rules" ref="loginFormRef" label-position="top" size="large">
        <el-form-item label="用户名" prop="name">
          <el-input v-model="loginForm.name" placeholder="请输入用户名" />
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input v-model="loginForm.password" type="password" placeholder="请输入密码" show-password />
        </el-form-item>
        <el-form-item>
          <el-checkbox v-model="rememberMe">记住我</el-checkbox>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" class="login-button" @click="handleLogin" :loading="loading">登录</el-button>
        </el-form-item>
      </el-form>
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
  name: [{ required: true, message: '请输入用户名', trigger: 'blur' }],
  password: [{ required: true, message: '请输入密码', trigger: 'blur' }]
})

// 组件挂载时恢复保存的凭据
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
  await loginFormRef.value.validate(async (valid, fields) => {
    if (valid) {
      loading.value = true
      const success = await userStore.login(loginForm)
      loading.value = false
      if (success) {
        // 根据"记住我"选项保存或清除凭据
        if (rememberMe.value) {
          localStorage.setItem('savedCredentials', JSON.stringify({
            name: loginForm.name,
            password: loginForm.password
          }))
        } else {
          localStorage.removeItem('savedCredentials')
        }
        
        ElMessage.success('欢迎回来')
        router.push('/')
      } else {
        ElMessage.error('用户名或密码错误')
      }
    } else {
      console.log('error submit!', fields)
    }
  })
}
</script>

<style scoped lang="scss">
.login-container {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #f5f5f7;
}

.login-box {
  width: 380px;
  padding: 48px;
  background: white;
  border-radius: 18px;
  box-shadow: 0 4px 24px rgba(0, 0, 0, 0.04);
  
  .login-header {
    text-align: center;
    margin-bottom: 40px;
    
    h2 {
      margin: 0 0 12px;
      color: #1d1d1f;
      font-size: 28px;
      font-weight: 600;
    }
    
    p {
      margin: 0;
      color: #86868b;
      font-size: 15px;
    }
  }
  
  :deep(.el-input__wrapper) {
    box-shadow: 0 0 0 1px #d2d2d7 inset;
    border-radius: 8px;
    padding: 8px 12px;
    
    &.is-focus {
      box-shadow: 0 0 0 2px #000000 inset;
    }
  }
  
  .login-button {
    width: 100%;
    height: 44px;
    font-size: 16px;
    font-weight: 500;
    border-radius: 8px;
    background-color: #000000;
    border: none;
    margin-top: 10px;
    
    &:hover {
      background-color: #333333;
    }
  }
}
</style>
