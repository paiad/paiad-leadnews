export interface ResponseResult<T = any> {
  code: number
  errorMessage: string
  data: T
  host?: string
}

export interface PageRequestDto {
  size: number
  page: number
}

export interface WmLoginDto {
  name: string
  password: string
}

export interface LoginResponse {
  token: string
  user: {
    id: number
    name: string
    headImage: string
  }
}

export interface WmMaterialDto extends PageRequestDto {
  isCollection?: number // 1 or 0
}

export interface WmNewsDto {
  id?: number
  title: string
  channelId: number
  labels?: string
  publishTime?: string // Date
  content: string
  type: number // 0, 1, 3, -1
  submitedTime?: string // Date
  status?: number // 1 submit, 0 draft
  images?: string[]
}

export interface WmNewsPageReqDto extends PageRequestDto {
  status?: number
  beginPubDate?: string
  endPubDate?: string
  channelId?: number
  keyword?: string
}

export interface WmChannel {
  id: number
  name: string
  description?: string
  isDefault?: boolean
  status?: boolean
  ord?: number
  createdTime?: string
}
