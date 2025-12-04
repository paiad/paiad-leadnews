<template>
  <div class="page-container">
    <div class="page-header">
      <h1 class="page-title">内容管理</h1>
    </div>

    <div class="filter-card">
      <el-form :inline="false" :model="queryParams">
        <!-- 第一行：状态选择 -->
        <el-form-item label="状态" class="status-form-item">
          <el-radio-group v-model="queryParams.status" class="status-radio-group" @change="handleSearch">
            <el-radio-button :label="null">全部状态</el-radio-button>
            <el-radio-button :label="0">草稿</el-radio-button>
            <el-radio-button :label="1">已提交</el-radio-button>
            <el-radio-button :label="2">审核失败</el-radio-button>
            <el-radio-button :label="3">审核通过</el-radio-button>
            <el-radio-button :label="9">已发布</el-radio-button>
          </el-radio-group>
        </el-form-item>
        
        <!-- 第二行：其他筛选条件 -->
        <div class="filter-row">
          <el-form-item label="关键字" class="filter-item">
            <el-input v-model="queryParams.keyword" placeholder="搜索标题" clearable style="width: 200px;" @change="handleSearch" />
          </el-form-item>
          <el-form-item label="频道" class="filter-item">
            <el-select v-model="queryParams.channelId" placeholder="全部频道" clearable filterable style="width: 180px;" @change="handleSearch">
              <el-option v-for="channel in channels" :key="channel.id" :label="channel.name" :value="channel.id" />
            </el-select>
          </el-form-item>
          <el-form-item label="日期" class="filter-item">
            <el-date-picker
              v-model="queryParams.beginPubDate"
              type="datetime"
              placeholder="开始时间"
              value-format="YYYY-MM-DDTHH:mm:ss"
              style="width: 200px;"
              @change="handleSearch"
            />
            <span class="date-separator">-</span>
            <el-date-picker
              v-model="queryParams.endPubDate"
              type="datetime"
              placeholder="结束时间"
              value-format="YYYY-MM-DDTHH:mm:ss"
              style="width: 200px;"
              @change="handleSearch"
            />
          </el-form-item>
        </div>
      </el-form>
    </div>

    <div v-loading="loading" class="table-container">
      <el-table :data="newsList" style="width: 100%" :header-cell-style="{ background: '#f5f5f7', color: '#86868b', fontWeight: '500' }">
        <el-table-column label="标题" min-width="300">
          <template #header>
            <div style="padding-left: 39px;">标题</div>
          </template>
          <template #default="scope">
            <div class="title-cell">
              <el-image
                v-if="scope.row.images"
                :src="getImageUrl(scope.row.images.split(',')[0])"
                class="title-cover-image"
                fit="cover"
              >
                <template #error>
                  <div class="image-error">
                    <i class="el-icon-picture-outline"></i>
                  </div>
                </template>
              </el-image>
              <div v-else class="title-cover-placeholder">
                <i class="el-icon-picture-outline"></i>
              </div>
              <div class="title-text">{{ scope.row.title }}</div>
            </div>
          </template>
        </el-table-column>
        <el-table-column label="状态" width="120">
          <template #header>
            <div style="padding-left: 16px;">状态</div>
          </template>
          <template #default="scope">
            <el-tag :type="getStatusType(scope.row.status)" effect="plain" round>{{ getStatusLabel(scope.row.status) }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="publishTime" label="发布时间" width="180">
            <template #header>
              <div style="padding-left: 16px;">发布时间</div>
            </template>
            <template #default="scope">
                {{ formatDate(scope.row.publishTime) }}
            </template>
        </el-table-column>
        <el-table-column label="操作" width="150" fixed="right">
          <template #default="scope">
            <el-button link type="primary" size="small" @click="handleEdit(scope.row.id)" class="edit-link">编辑</el-button>
          </template>
        </el-table-column>
      </el-table>
      
      <div class="pagination-container">
        <el-pagination
          v-model:current-page="queryParams.page"
          v-model:page-size="queryParams.size"
          :page-sizes="[10, 20, 50]"
          :total="total"
          layout="sizes, prev, next"
          background
          small
          @size-change="handleSizeChange"
          @current-change="loadNews"
        />
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { getNewsList } from '@/api/news'
import { getChannels } from '@/api/channel'
import { ElMessage } from 'element-plus'

const router = useRouter()
const loading = ref(false)
const newsList = ref<any[]>([])
const total = ref(0)
const channels = ref<any[]>([])
const fileHost = ref('')

const queryParams = reactive({
  page: 1,
  size: 10,
  keyword: '',
  status: undefined,
  channelId: undefined,
  beginPubDate: undefined,
  endPubDate: undefined
})

const getStatusLabel = (status: number) => {
  const map: Record<number, string> = {
    0: '草稿',
    1: '已提交',
    2: '审核失败',
    3: '审核通过',
    9: '已发布'
  }
  return map[status] || '未知'
}

const getStatusType = (status: number) => {
  const map: Record<number, string> = {
    0: 'info',
    1: 'warning',
    2: 'danger',
    3: 'success',
    9: 'success'
  }
  return map[status] || ''
}

const formatDate = (dateStr: string) => {
    if(!dateStr) return '-'
    return new Date(dateStr).toLocaleString()
}

const getImageUrl = (url: string) => {
  if (!url) return ''
  if (url.startsWith('http')) return url
  return (fileHost.value || '') + url
}

const loadChannels = async () => {
  try {
    const res = await getChannels()
    if (res.code === 200) {
      channels.value = res.data || []
    }
  } catch (error) {
    console.error(error)
  }
}

const loadNews = async () => {
  loading.value = true
  try {
    const res = await getNewsList(queryParams)
    console.log('[News List] API response:', res)
    
    if (res.code === 200) {
      // Store host for image URLs
      if (res.host) {
        fileHost.value = res.host
        console.log('[News List] File host:', fileHost.value)
      }
      
      // Handle different response structures
      if (res.data) {
        // Check if data has rows property (paginated response)
        if (res.data.rows && Array.isArray(res.data.rows)) {
          newsList.value = res.data.rows
          total.value = res.data.total || 0
          console.log('[News List] Loaded rows:', newsList.value.length, 'Total:', total.value)
        } 
        // Check if data itself is an array
        else if (Array.isArray(res.data)) {
          newsList.value = res.data
          total.value = res.data.length
          console.log('[News List] Loaded array:', newsList.value.length)
        }
        // Single object or other structure
        else {
          console.warn('[News List] Unexpected data structure:', res.data)
          newsList.value = []
          total.value = 0
        }
      } else {
        console.warn('[News List] No data in response')
        newsList.value = []
        total.value = 0
      }
    } else {
      console.error('[News List] Error response:', res)
      ElMessage.error(res.errorMessage || '加载内容失败')
      newsList.value = []
      total.value = 0
    }
  } catch (error) {
    console.error('[News List] Exception:', error)
    ElMessage.error('加载内容失败')
    newsList.value = []
    total.value = 0
  } finally {
    loading.value = false
  }
}

const handleSearch = () => {
  queryParams.page = 1
  loadNews()
}

const handleSizeChange = () => {
  queryParams.page = 1
  loadNews()
}

const handleEdit = (id: number) => {
  router.push(`/layout/news/publish?id=${id}`)
}

onMounted(() => {
  loadChannels()
  loadNews()
})
</script>

<style scoped lang="scss">
.page-container {
  max-width: 1200px;
  margin: 0 auto;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 32px;
  
  .page-title {
    font-size: 24px;
    font-weight: 600;
    color: #1d1d1f;
    margin: 0;
  }
  
  .action-button {
    background-color: #000000;
    border: none;
    border-radius: 20px;
    padding: 8px 20px;
    font-weight: 500;
    
    &:hover {
      background-color: #333333;
    }
  }
}

.filter-card {
  background: white;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  margin-bottom: 24px;
  
  :deep(.el-form-item__label) {
    font-weight: 500;
    color: #1d1d1f;
  }
  
  .status-form-item {
    margin-bottom: 20px;
    
    :deep(.el-form-item__label) {
      width: 60px;
    }
    
    .status-radio-group {
      display: flex;
      gap: 8px;
      
      :deep(.el-radio-button__inner) {
        padding: 8px 20px;
        border-radius: 6px;
        border: 1px solid #e5e5e7;
        background-color: #f5f5f7;
        color: #1d1d1f;
        transition: all 0.2s ease;
      }
      
      :deep(.el-radio-button:first-child .el-radio-button__inner) {
        border-radius: 6px;
      }
      
      :deep(.el-radio-button:last-child .el-radio-button__inner) {
        border-radius: 6px;
      }
      
      :deep(.el-radio-button__original-radio:checked + .el-radio-button__inner) {
        background-color: #000000;
        border-color: #000000;
        color: white;
        box-shadow: none;
      }
      
      :deep(.el-radio-button__inner:hover) {
        background-color: #e5e5e7;
      }
    }
  }
  
  .filter-row {
    display: flex;
    align-items: center;
    gap: 16px;
    flex-wrap: wrap;
    
    .filter-item {
      margin-bottom: 0;
      
      :deep(.el-form-item__label) {
        width: auto;
        margin-right: 8px;
      }

      .date-separator {
        margin: 0 8px;
        color: #86868b;
      }
    }
  }
  
  .search-button {
    background-color: #000000;
    border: none;
    border-radius: 6px;
    padding: 8px 24px;
    
    &:hover {
      background-color: #333333;
    }
  }
}

.table-container {
  background: white;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  overflow: hidden;
  padding-bottom: 20px;
  
  .title-cell {
    display: flex;
    align-items: center;
    gap: 20px;
    padding-left: 16px;
    
    .title-cover-image {
      flex-shrink: 0;
      width: 80px;
      height: 60px;
      border-radius: 6px;
      overflow: hidden;
      background-color: #f5f5f7;
    }
    
    .title-cover-placeholder {
      flex-shrink: 0;
      width: 80px;
      height: 60px;
      border-radius: 6px;
      background-color: #f5f5f7;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #c0c4cc;
      font-size: 24px;
    }
    
    .image-error {
      width: 100%;
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      background-color: #f5f5f7;
      color: #c0c4cc;
      font-size: 24px;
    }
    
    .title-text {
      flex: 1;
      font-size: 14px;
      color: #1d1d1f;
      line-height: 1.5;
      overflow: hidden;
      display: -webkit-box;
      -webkit-line-clamp: 2;
      line-clamp: 2;
      -webkit-box-orient: vertical;
      word-break: break-word;
    }
  }
  
  .edit-link {
    color: #0066cc;
    font-weight: 500;
    
    &:hover {
      color: #004499;
    }
  }
}

.pagination-container {
  display: flex;
  justify-content: flex-end;
  padding: 20px 24px 0;
}
</style>
