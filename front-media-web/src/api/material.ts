import request from '@/utils/request'
import type { ResponseResult, WmMaterialDto } from './types'

export function getMaterialList(data: WmMaterialDto) {
  console.log('[API] getMaterialList request:', data)
  return request({
    url: '/api/v1/material/list',
    method: 'post',
    data: {
      ...data,
      page: data.page > 0 ? data.page - 1 : 0
    }
  }).then((res: any) => {
    console.log('[API] getMaterialList response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}

export function uploadPicture(data: FormData) {
  console.log('[API] uploadPicture request')
  return request({
    url: '/api/v1/material/upload_picture',
    method: 'post',
    data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  }).then((res: any) => {
    console.log('[API] uploadPicture response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}
