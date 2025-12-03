import request from '@/utils/request'
import type { ResponseResult, WmLoginDto } from './types'

export function login(data: WmLoginDto) {
  return request<ResponseResult>({
    url: '/login/in',
    method: 'post',
    data
  })
}
