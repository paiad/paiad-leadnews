import { defineStore } from 'pinia'
import { ref } from 'vue'
import { login as loginApi } from '@/api/user'
import type { WmLoginDto, ResponseResult, LoginResponse } from '@/api/types'

export const useUserStore = defineStore('user', () => {
  const token = ref(localStorage.getItem('token') || '')
  const user = ref(JSON.parse(localStorage.getItem('user') || '{}'))
  
  function setToken(newToken: string) {
    token.value = newToken
    localStorage.setItem('token', newToken)
  }

  function setUser(newUser: any) {
    user.value = newUser
    localStorage.setItem('user', JSON.stringify(newUser))
  }

  function logout() {
    token.value = ''
    user.value = {}
    localStorage.removeItem('token')
    localStorage.removeItem('user')
  }

  async function login(loginForm: WmLoginDto) {
    try {
      const res = await loginApi(loginForm) as unknown as ResponseResult<LoginResponse>
      if (res.code === 200) {
         if (res.data && res.data.token) {
             setToken(res.data.token)
             setUser(res.data.user)
             return true
         }
      }
    } catch (error) {
      console.error(error)
    }
    return false
  }

  return { token, user, setToken, setUser, logout, login }
})
