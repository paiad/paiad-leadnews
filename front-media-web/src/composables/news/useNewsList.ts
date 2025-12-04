import { ref, reactive } from 'vue'
import { getNewsList, deleteNews, batchDeleteNews } from '@/api/news'
import { getChannels } from '@/api/channel'
import type { NewsItem, NewsQueryParams, ChannelOption } from '@/types/news'
import { ElMessage, ElMessageBox } from 'element-plus'

/**
 * 新闻列表数据管理 Composable
 */
export function useNewsList() {
  // 状态
  const loading = ref(false)
  const newsList = ref<NewsItem[]>([])
  const total = ref(0)
  const channels = ref<ChannelOption[]>([])
  const fileHost = ref('')

  // 查询参数
  const queryParams = reactive<NewsQueryParams>({
    page: 1,
    size: 10,
    keyword: '',
    status: undefined,
    channelId: undefined,
    beginPubDate: undefined,
    endPubDate: undefined
  })

  /**
   * 获取频道列表
   */
  const fetchChannels = async () => {
    try {
      const res = await getChannels()
      if (res.code === 200) {
        channels.value = res.data || []
      }
    } catch (error) {
      console.error('[useNewsList] fetchChannels error:', error)
    }
  }

  /**
   * 获取新闻列表
   */
  const fetchNews = async () => {
    loading.value = true
    try {
      const res = await getNewsList(queryParams)
      
      if (res.code === 200) {
        if (res.host) {
          fileHost.value = res.host
        }
        
        if (res.data && Array.isArray(res.data)) {
          newsList.value = res.data
          total.value = (res as any).total || res.data.length
        } else {
          newsList.value = []
          total.value = 0
        }
      } else {
        ElMessage.error(res.errorMessage || '加载内容失败')
        newsList.value = []
        total.value = 0
      }
    } catch (error) {
      console.error('[useNewsList] fetchNews error:', error)
      ElMessage.error('加载内容失败')
      newsList.value = []
      total.value = 0
    } finally {
      loading.value = false
    }
  }

  /**
   * 删除单篇新闻
   */
  const removeNews = async (id: number, title: string, isPublished: boolean): Promise<boolean> => {
    const confirmMessage = isPublished
      ? `文章「${title}」已发布，删除后将同时删除APP端相关数据，确定要删除吗？`
      : `确定要删除文章「${title}」吗？`

    try {
      await ElMessageBox.confirm(confirmMessage, '删除确认', {
        confirmButtonText: '确定删除',
        cancelButtonText: '取消',
        type: 'warning'
      })

      const res = await deleteNews(id)
      if (res.code === 200) {
        ElMessage.success('删除成功')
        await fetchNews()
        return true
      } else {
        ElMessage.error(res.errorMessage || '删除失败')
        return false
      }
    } catch (error) {
      if (error !== 'cancel') {
        console.error('[useNewsList] removeNews error:', error)
        ElMessage.error('删除失败')
      }
      return false
    }
  }

  /**
   * 批量删除新闻
   */
  const removeBatchNews = async (ids: number[]): Promise<boolean> => {
    if (ids.length === 0) {
      ElMessage.warning('请先选择要删除的文章')
      return false
    }

    try {
      await ElMessageBox.confirm(
        `确定要删除选中的 ${ids.length} 篇文章吗？`,
        '批量删除确认',
        {
          confirmButtonText: '确定删除',
          cancelButtonText: '取消',
          type: 'warning'
        }
      )

      const res = await batchDeleteNews(ids)
      if (res.code === 200) {
        ElMessage.success('批量删除成功')
        await fetchNews()
        return true
      } else {
        ElMessage.error(res.errorMessage || '批量删除失败')
        return false
      }
    } catch (error) {
      if (error !== 'cancel') {
        console.error('[useNewsList] removeBatchNews error:', error)
        ElMessage.error('批量删除失败')
      }
      return false
    }
  }

  /**
   * 重置页码到第一页
   */
  const resetPage = () => {
    queryParams.page = 1
  }

  return {
    // 状态
    loading,
    newsList,
    total,
    channels,
    fileHost,
    queryParams,
    // 方法
    fetchChannels,
    fetchNews,
    removeNews,
    removeBatchNews,
    resetPage
  }
}
