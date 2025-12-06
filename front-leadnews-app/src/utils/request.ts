/**
 * uni.request 封装
 * 统一请求处理、Token 附加、错误处理
 */

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
    
    uni.request({
      url: options.url,
      method: options.method || 'GET',
      data: options.data,
      header,
      success: (res) => {
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
