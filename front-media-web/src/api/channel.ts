import request from '@/utils/request'
import type { ResponseResult } from './types'

export function getChannels() {
  return request({
    url: '/api/v1/channel/channels',
    method: 'get'
  }) as unknown as Promise<ResponseResult>
}
