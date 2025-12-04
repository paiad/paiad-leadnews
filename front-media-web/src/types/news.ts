/**
 * 新闻状态常量
 */
export const NewsStatus = {
  /** 草稿 */
  DRAFT: 0,
  /** 已提交 */
  SUBMITTED: 1,
  /** 审核失败 */
  AUDIT_FAILED: 2,
  /** 审核通过 */
  AUDIT_PASSED: 3,
  /** 已发布 */
  PUBLISHED: 9
} as const

export type NewsStatus = typeof NewsStatus[keyof typeof NewsStatus]

/**
 * 状态配置接口
 */
export interface StatusConfig {
  label: string
  type: 'info' | 'warning' | 'danger' | 'success' | ''
}

/**
 * 新闻列表项
 */
export interface NewsItem {
  id: number
  title: string
  status: NewsStatus
  images?: string
  publishTime?: string
  channelId?: number
}

/**
 * 新闻筛选查询参数
 */
export interface NewsQueryParams {
  page: number
  size: number
  keyword?: string
  status?: NewsStatus
  channelId?: number
  beginPubDate?: string
  endPubDate?: string
}

/**
 * 频道选项
 */
export interface ChannelOption {
  id: number
  name: string
}
