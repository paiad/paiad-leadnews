import request from '@/utils/request'
import type { ResponseResult, WmNewsPageReqDto, WmNewsDto } from './types'

export function getNewsList(data: WmNewsPageReqDto) {
  console.log('[API] getNewsList request:', data)
  return request({
    url: '/api/v1/news/list',
    method: 'post',
    data: data
  }).then((res: any) => {
    console.log('[API] getNewsList response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}

export function getNewsDetail(id: number) {
  console.log('[API] getNewsDetail request:', id)
  return request({
    url: `/api/v1/news/one/${id}`,
    method: 'get'
  }).then((res: any) => {
    console.log('[API] getNewsDetail response:', res)
    return res
  }).catch((error: any) => {
    console.error('[API] getNewsDetail error:', error)
    throw error
  }) as unknown as Promise<ResponseResult>
}

export function submitNews(data: WmNewsDto) {
  console.log('[API] submitNews request:', data)
  return request({
    url: '/api/v1/news/submit',
    method: 'post',
    data
  }).then((res: any) => {
    console.log('[API] submitNews response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}

export function deleteNews(id: number) {
  console.log('[API] deleteNews request:', id)
  return request({
    url: `/api/v1/news/del/${id}`,
    method: 'delete'
  }).then((res: any) => {
    console.log('[API] deleteNews response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}

export function batchDeleteNews(ids: number[]) {
  console.log('[API] batchDeleteNews request:', ids)
  return request({
    url: '/api/v1/news/del/batch',
    method: 'post',
    data: ids
  }).then((res: any) => {
    console.log('[API] batchDeleteNews response:', res)
    return res
  }) as unknown as Promise<ResponseResult>
}
