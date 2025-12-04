<template>
  <div class="max-w-300 mx-auto pb-20">
    <!-- 页面标题 -->
    <header class="flex justify-between items-center mb-8">
      <h1 class="text-2xl font-semibold text-gray-900 m-0">内容管理</h1>
    </header>

    <!-- 筛选表单 -->
    <NewsFilter
      v-model="queryParams"
      :channels="channels"
      @search="handleSearch"
    />

    <!-- 数据表格 -->
    <NewsTable
      ref="tableRef"
      :data="newsList"
      :loading="loading"
      :total="total"
      :page="queryParams.page"
      :page-size="queryParams.size"
      :is-edit-mode="isEditMode"
      :file-host="fileHost"
      @edit="handleEdit"
      @delete="handleDelete"
      @selection-change="handleSelectionChange"
      @page-change="handlePageChange"
      @size-change="handleSizeChange"
      @toggle-edit-mode="toggleEditMode"
    />

    <!-- 浮动操作栏 -->
    <FloatingActionBar
      :visible="isEditMode && selectedIds.length > 0"
      :count="selectedIds.length"
      @clear="clearSelection"
      @delete="handleBatchDelete"
    />
  </div>
</template>

<script setup lang="ts">
import { onMounted, ref } from 'vue'
import { useRouter } from 'vue-router'
import { useNewsList } from '@/composables/news/useNewsList'
import { useNewsSelection } from '@/composables/news/useNewsSelection'
import { NewsStatus } from '@/types/news'
import type { NewsItem } from '@/types/news'
import NewsFilter from './components/NewsFilter.vue'
import NewsTable from './components/NewsTable.vue'
import FloatingActionBar from './components/FloatingActionBar.vue'

const router = useRouter()
const tableRef = ref()

// 使用 composables
const {
  loading,
  newsList,
  total,
  channels,
  fileHost,
  queryParams,
  fetchChannels,
  fetchNews,
  removeNews,
  removeBatchNews,
  resetPage
} = useNewsList()

const {
  isEditMode,
  selectedIds,
  toggleEditMode,
  clearSelection,
  handleSelectionChange
} = useNewsSelection(tableRef)

/**
 * 搜索处理
 */
const handleSearch = () => {
  resetPage()
  fetchNews()
}

/**
 * 页码变化处理
 */
const handlePageChange = (page: number) => {
  queryParams.page = page
  fetchNews()
}

/**
 * 每页条数变化处理
 */
const handleSizeChange = (size: number) => {
  queryParams.size = size
  resetPage()
  fetchNews()
}

/**
 * 编辑文章
 */
const handleEdit = (id: number) => {
  router.push(`/layout/news/publish?id=${id}`)
}

/**
 * 删除文章
 */
const handleDelete = async (row: NewsItem) => {
  await removeNews(row.id, row.title, row.status === NewsStatus.PUBLISHED)
}

/**
 * 批量删除
 */
const handleBatchDelete = async () => {
  const success = await removeBatchNews(selectedIds.value)
  if (success) {
    clearSelection()
  }
}

// 初始化
onMounted(() => {
  fetchChannels()
  fetchNews()
})
</script>
