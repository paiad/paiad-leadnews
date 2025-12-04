import request from '@/utils/request'
import type { ResponseResult, WmMaterialDto } from './types'

export function getMaterialList(data: WmMaterialDto) {
  console.log('[API] getMaterialList request:', data)
  return request({
    url: '/api/v1/material/list',
    method: 'post',
    data: data
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

export function collectMaterial(id: number) {
  console.log('[API] collectMaterial request:', id)
  return request({
    url: `/api/v1/material/collect/${id}`,
    method: 'post'
  }).then((res: any) => {
    console.log('[API] collectMaterial response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}

export function deleteMaterial(id: number) {
  console.log('[API] deleteMaterial request:', id)
  return request({
    url: `/api/v1/material/del/${id}`,
    method: 'delete'
  }).then((res: any) => {
    console.log('[API] deleteMaterial response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}

export function batchDeleteMaterial(ids: number[]) {
  console.log('[API] batchDeleteMaterial request:', ids)
  return request({
    url: '/api/v1/material/del/batch',
    method: 'post',
    data: ids
  }).then((res: any) => {
    console.log('[API] batchDeleteMaterial response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}

export function batchUploadPictures(data: FormData) {
  console.log('[API] batchUploadPictures request')
  return request({
    url: '/api/v1/material/upload_pictures',
    method: 'post',
    data,
    headers: {
      'Content-Type': 'multipart/form-data'
    }
  }).then((res: any) => {
    console.log('[API] batchUploadPictures response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}
