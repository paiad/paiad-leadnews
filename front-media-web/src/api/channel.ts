import request from '@/utils/request'
import type { ResponseResult } from './types'

// 频道类型定义
export interface WmChannel {
  id?: number
  name: string
  description?: string
  isDefault?: boolean
  status?: boolean
  ord?: number
  createdTime?: string
}

export interface ChannelQueryDto {
  page?: number
  size?: number
  name?: string
}

// 获取所有频道（下拉选择用）
export function getChannels() {
  return request({
    url: '/api/v1/channel/channels',
    method: 'get'
  }) as unknown as Promise<ResponseResult>
}

// 分页查询频道
export function getChannelList(data: ChannelQueryDto) {
  return request({
    url: '/api/v1/channel/list',
    method: 'post',
    data
  }) as unknown as Promise<ResponseResult>
}

// 新增频道
export function saveChannel(data: WmChannel) {
  return request({
    url: '/api/v1/channel/save',
    method: 'post',
    data
  }) as unknown as Promise<ResponseResult>
}

// 修改频道
export function updateChannel(data: WmChannel) {
  return request({
    url: '/api/v1/channel/update',
    method: 'post',
    data
  }) as unknown as Promise<ResponseResult>
}

// 删除频道
export function deleteChannel(id: number) {
  return request({
    url: `/api/v1/channel/del/${id}`,
    method: 'delete'
  }) as unknown as Promise<ResponseResult>
}
