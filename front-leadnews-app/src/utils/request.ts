/**
 * uni.request 封装
 * 统一请求处理、Token 附加、错误处理
 */

// 基础 URL 配置
// H5 端使用相对路径（通过 Vite 代理）
// 小程序端使用完整 URL
const BASE_URL = (() => {
  // #ifdef H5
  return ''
  // #endif
  // #ifdef MP-WEIXIN
  return 'http://localhost:51801'
  // #endif
  // #ifndef H5 || MP-WEIXIN
  return 'http://localhost:51801'
  // #endif
})()

interface RequestOptions {
  url: string
  method?: 'GET' | 'POST' | 'PUT' | 'DELETE'
  data?: any
  header?: Record<string, string>
}

interface ResponseData<T = any> {
  code: number
  message: string
  data: T
}

/**
 * 封装的请求方法
 */
function request<T = any>(options: RequestOptions): Promise<ResponseData<T>> {
  return new Promise((resolve, reject) => {
    // 获取 token
    const token = uni.getStorageSync('token')
    
    // 合并请求头
    const header: Record<string, string> = {
      'Content-Type': 'application/json',
      ...options.header,
    }
    
    // 如果有 token，添加到请求头
    if (token) {
      header['token'] = token
    }

    // 拼接完整 URL
    const fullUrl = options.url.startsWith('http') ? options.url : `${BASE_URL}${options.url}`
    
    console.log('请求URL:', fullUrl)
    console.log('请求数据:', options.data)
    
    uni.request({
      url: fullUrl,
      method: options.method || 'GET',
      data: options.data,
      header,
      success: (res) => {
        console.log('响应数据:', res.data)
        const data = res.data as ResponseData<T>
        
        // 请求成功
        if (data.code === 200 || data.code === 0) {
          resolve(data)
        } else {
          // 业务错误
          uni.showToast({
            title: data.message || '请求失败',
            icon: 'none',
            duration: 2000,
          })
          reject(data)
        }
      },
      fail: (err) => {
        console.error('请求失败:', err)
        // 网络错误
        uni.showToast({
          title: '网络错误，请检查网络连接',
          icon: 'none',
          duration: 2000,
        })
        reject(err)
      },
    })
  })
}

/**
 * GET 请求
 */
export function get<T = any>(url: string, data?: any): Promise<ResponseData<T>> {
  return request<T>({ url, method: 'GET', data })
}

/**
 * POST 请求
 */
export function post<T = any>(url: string, data?: any): Promise<ResponseData<T>> {
  return request<T>({ url, method: 'POST', data })
}

export default {
  request,
  get,
  post,
}
