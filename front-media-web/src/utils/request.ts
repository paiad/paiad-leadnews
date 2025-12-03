import axios from 'axios'
import { ElMessage } from 'element-plus'

const service = axios.create({
  baseURL: '/wemedia/MEDIA',
  timeout: 5000
})

service.interceptors.request.use(
  (config) => {
    // Add token here if needed
    const token = localStorage.getItem('token')
    if (token) {
      config.headers['token'] = token
    }
    
    // Add userId if available (simulating gateway behavior)
    const userStr = localStorage.getItem('user')
    if (userStr) {
      try {
        const user = JSON.parse(userStr)
        if (user && user.id) {
          config.headers['userId'] = user.id
        }
      } catch (e) {
        // ignore
      }
    }
    
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

service.interceptors.response.use(
  (response) => {
    const res = response.data
    if (res.code !== 200 && res.code !== 0 && res.code !== 50 && res.code !== 20000) {
       ElMessage.error(res.errorMessage || 'Error')
       return Promise.reject(new Error(res.errorMessage || 'Error'))
    } else {
      return res
    }
  },
  (error) => {
    ElMessage.error(error.message)
    return Promise.reject(error)
  }
)

export default service
