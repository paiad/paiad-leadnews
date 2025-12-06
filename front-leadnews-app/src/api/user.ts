/**
 * 用户相关 API
 */
import { post } from '@/utils/request'

/**
 * 登录参数
 */
export interface LoginParams {
  phone: string
  password: string
}

/**
 * 登录响应数据
 */
export interface LoginResult {
  token: string
  user: {
    id: number
    phone: string
    name: string
  }
}

/**
 * 用户登录
 * @param data 登录参数
 */
export function login(data: LoginParams) {
  return post<LoginResult>('/api/v1/login/login_auth', data)
}
