import request from '@/utils/request'
import type { ResponseResult, WmNewsPageReqDto, WmNewsDto } from './types'

export function getNewsList(data: WmNewsPageReqDto) {
  console.log('[API] getNewsList request:', data)
  return request({
    url: '/api/v1/news/list',
    method: 'post',
    data: {
      ...data,
      page: data.page > 0 ? data.page - 1 : 0
    }
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
