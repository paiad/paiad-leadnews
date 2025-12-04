/**
 * 内容块类型
 */
export interface ContentBlock {
  type: 'text' | 'image'
  value: string
}

/**
 * 封面类型常量
 */
export const CoverType = {
  /** 无图 */
  NONE: 0,
  /** 单图 */
  SINGLE: 1,
  /** 三图 */
  TRIPLE: 3,
  /** 自动 */
  AUTO: -1
} as const

export type CoverType = typeof CoverType[keyof typeof CoverType]

/**
 * 发布表单数据
 */
export interface PublishFormData {
  id?: number
  title: string
  content: ContentBlock[]
  type: CoverType
  channelId?: number
  labels: string
  images: string[]
  status: number
  publishTime: string | null
}

/**
 * 素材项
 */
export interface MaterialItem {
  id: number
  url: string
}

/**
 * 素材选择模式
 */
export type MaterialSelectMode = 'cover' | 'content'
