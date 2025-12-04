import { NewsStatus, type StatusConfig } from '@/types/news'

/**
 * 状态配置映射
 */
export const STATUS_CONFIG: Record<NewsStatus, StatusConfig> = {
  [NewsStatus.DRAFT]: { label: '草稿', type: 'info' },
  [NewsStatus.SUBMITTED]: { label: '已提交', type: 'warning' },
  [NewsStatus.AUDIT_FAILED]: { label: '审核失败', type: 'danger' },
  [NewsStatus.AUDIT_PASSED]: { label: '审核通过', type: 'success' },
  [NewsStatus.PUBLISHED]: { label: '已发布', type: 'success' }
}

/**
 * 获取状态标签文本
 */
export const getStatusLabel = (status: NewsStatus): string =>
  STATUS_CONFIG[status]?.label ?? '未知'

/**
 * 获取状态标签类型
 */
export const getStatusType = (status: NewsStatus): string =>
  STATUS_CONFIG[status]?.type ?? ''

/**
 * 格式化日期时间
 */
export const formatDate = (dateStr?: string): string =>
  dateStr ? new Date(dateStr).toLocaleString() : '-'

/**
 * 构建完整图片URL
 */
export const buildImageUrl = (url: string, host: string): string => {
  if (!url) return ''
  return url.startsWith('http') ? url : `${host}${url}`
}

/**
 * 默认封面图片URL
 */
export const DEFAULT_COVER_IMAGE = 'https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/no-img.png'
