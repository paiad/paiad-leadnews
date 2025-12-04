<template>
  <div class="page-container">
    <div class="page-header">
      <h1 class="page-title">素材库</h1>
      <el-upload
        class="upload-demo"
        action=""
        :http-request="handleUpload"
        :show-file-list="false"
        accept="image/*"
      >
        <el-button type="primary" class="action-button">上传图片</el-button>
      </el-upload>
    </div>

    <el-tabs v-model="activeTab" @tab-change="handleTabChange" class="custom-tabs">
      <el-tab-pane label="全部图片" name="all"></el-tab-pane>
      <el-tab-pane label="收藏" name="favorite"></el-tab-pane>
    </el-tabs>

    <div 
      class="content-area"
      v-infinite-scroll="loadMore"
      :infinite-scroll-disabled="disabled"
      infinite-scroll-distance="10"
    >
      <div v-if="materialList.length > 0" class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-6">
        <div v-for="item in materialList" :key="item.id" class="material-card group">
          <el-image
            :src="getImageUrl(item.url)"
            fit="cover"
            class="material-image"
            loading="lazy"
            @click="handlePreview(item.url)"
            style="cursor: pointer;"
          />
          <div class="overlay">
             <div class="overlay-content">
               <span class="date">{{ formatDate(item.createdTime) }}</span>
             </div>
          </div>
          <div class="actions">
            <el-button
              circle
              :class="['action-btn', item.isCollection === 1 ? 'collected' : '']"
              @click.stop="handleCollect(item)"
            >
              <el-icon><StarFilled v-if="item.isCollection === 1" /><Star v-else /></el-icon>
            </el-button>
            <el-button
              circle
              class="action-btn delete-btn"
              @click.stop="handleDelete(item.id)"
            >
              <el-icon><Delete /></el-icon>
            </el-button>
          </div>
        </div>
      </div>
      <div v-else-if="!loading" class="empty-state">
        <el-icon class="empty-icon"><Picture /></el-icon>
        <p>暂无素材</p>
      </div>

      <div v-if="loading" class="loading-state">
        <el-icon class="is-loading"><Loading /></el-icon>
        <span>加载中...</span>
      </div>
      
      <div v-if="noMore && materialList.length > 0" class="no-more-state">
        <span>没有更多了</span>
      </div>
    </div>
    
    <!-- 图片预览全屏遮罩 -->
    <div v-if="previewVisible" class="preview-overlay" @click="previewVisible = false">
      <img :src="previewUrl" class="preview-image" alt="预览" @click.stop />
      <el-button circle class="close-btn" @click="previewVisible = false">
        <el-icon><Close /></el-icon>
      </el-button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue'
import { getMaterialList, uploadPicture, collectMaterial, deleteMaterial } from '@/api/material'
import { ElMessage, ElMessageBox } from 'element-plus'
import type { UploadRequestOptions } from 'element-plus'
import { Picture, Star, StarFilled, Delete, Close, Loading } from '@element-plus/icons-vue'

const previewVisible = ref(false)
const previewUrl = ref('')

const loading = ref(false)
const noMore = ref(false)
const activeTab = ref('all')
const materialList = ref<any[]>([])
const total = ref(0)
const fileHost = ref('')

const queryParams = reactive({
  page: 1,
  size: 20,
  isCollection: 0
})

const disabled = computed(() => loading.value || noMore.value)

const formatDate = (dateStr: string) => {
  if (!dateStr) return ''
  return new Date(dateStr).toLocaleDateString()
}

const getImageUrl = (url: string) => {
  if (!url) return ''
  if (url.startsWith('http')) return url
  return (fileHost.value || '') + url
}

const loadMaterials = async (isLoadMore = false) => {
  if (loading.value) return
  loading.value = true
  
  try {
    const res = await getMaterialList({
      page: queryParams.page,
      size: queryParams.size,
      isCollection: queryParams.isCollection
    })
    
    if (res.code === 200) {
      if (res.host) {
        fileHost.value = res.host
      }
      
      let rows: any[] = []
      let totalCount = 0
      
      if (res.data && Array.isArray(res.data)) {
        rows = res.data
        totalCount = (res as any).total || res.data.length
      }
      
      if (isLoadMore) {
        materialList.value.push(...rows)
      } else {
        materialList.value = rows
      }
      
      total.value = totalCount
      
      // 判断是否还有更多数据
      if (materialList.value.length >= total.value) {
        noMore.value = true
      } else {
        noMore.value = false
      }
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载素材失败')
  } finally {
    loading.value = false
  }
}

const loadMore = () => {
  if (!disabled.value) {
    queryParams.page++
    loadMaterials(true)
  }
}

const handleTabChange = (tab: any) => {
  queryParams.isCollection = tab === 'favorite' ? 1 : 0
  queryParams.page = 1
  noMore.value = false
  materialList.value = []
  loadMaterials(false)
}

const handleUpload = async (options: UploadRequestOptions) => {
  const formData = new FormData()
  formData.append('multipartFile', options.file)
  try {
    const res = await uploadPicture(formData)
    if (res.code === 200) {
      ElMessage.success('上传成功')
      // 重置列表
      queryParams.page = 1
      noMore.value = false
      loadMaterials(false)
    } else {
      ElMessage.error(res.errorMessage || '上传失败')
    }
  } catch (error) {
    ElMessage.error('上传失败')
  }
}

const handleCollect = async (item: any) => {
  try {
    const res = await collectMaterial(item.id)
    if (res.code === 200 && res.data) {
      item.isCollection = res.data.isCollection
      ElMessage.success(item.isCollection === 1 ? '已收藏' : '已取消收藏')
      
      // 如果在收藏tab下取消收藏，移除该项
      if (activeTab.value === 'favorite' && item.isCollection === 0) {
        const index = materialList.value.findIndex(i => i.id === item.id)
        if (index > -1) {
          materialList.value.splice(index, 1)
        }
      }
    } else {
      ElMessage.error(res.errorMessage || '操作失败')
    }
  } catch (error) {
    ElMessage.error('操作失败')
  }
}

const handleDelete = async (id: number) => {
  try {
    await ElMessageBox.confirm('确定要删除这个素材吗？', '提示', {
      confirmButtonText: '确定',
      cancelButtonText: '取消',
      type: 'warning'
    })
    
    const res = await deleteMaterial(id)
    if (res.code === 200) {
      ElMessage.success('删除成功')
      // 从列表中移除
      const index = materialList.value.findIndex(item => item.id === id)
      if (index > -1) {
        materialList.value.splice(index, 1)
      }
    } else {
      ElMessage.error(res.errorMessage || '删除失败')
    }
  } catch (error: any) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

const handlePreview = (url: string) => {
  previewUrl.value = getImageUrl(url)
  previewVisible.value = true
}

onMounted(() => {
  loadMaterials(false)
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

.custom-tabs {
  margin-bottom: 24px;
  
  :deep(.el-tabs__nav-wrap::after) {
    height: 1px;
    background-color: #e5e5e5;
  }
  
  :deep(.el-tabs__item) {
    font-size: 15px;
    color: #86868b;
    
    &.is-active {
      color: #1d1d1f;
      font-weight: 600;
    }
  }
  
  :deep(.el-tabs__active-bar) {
    background-color: #1d1d1f;
  }
}

.content-area {
  min-height: 400px;
}

.material-card {
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  background-color: #f5f5f7;
  aspect-ratio: 1;
  cursor: pointer;
  transition: transform 0.2s ease;
  
  &:hover {
    transform: scale(1.02);
    
    .overlay {
      opacity: 1;
    }
    
    .actions {
      opacity: 1;
    }
  }
  
  .material-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .overlay {
    position: absolute;
    bottom: 0;
    left: 0;
    right: 0;
    padding: 12px;
    background: linear-gradient(to top, rgba(0,0,0,0.6), transparent);
    opacity: 0;
    transition: opacity 0.2s ease;
    
    .date {
      color: white;
      font-size: 12px;
      font-weight: 500;
    }
  }
  
  .actions {
    position: absolute;
    top: 8px;
    right: 8px;
    display: flex;
    gap: 8px;
    opacity: 0;
    transition: opacity 0.2s ease;
    
    .action-btn {
      width: 32px;
      height: 32px;
      padding: 0;
      background-color: rgba(255, 255, 255, 0.9);
      border: none;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.15);
      
      &:hover {
        background-color: #ffffff;
        transform: scale(1.1);
      }
      
      &.collected {
        color: #ff4d4f;
        
        &:hover {
          color: #ff7875;
        }
      }
      
      &.delete-btn {
        &:hover {
          color: #ff4d4f;
          background-color: #fff1f0;
        }
      }
    }
  }
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 300px;
  color: #86868b;
  
  .empty-icon {
    font-size: 48px;
    margin-bottom: 16px;
    opacity: 0.5;
  }
}

.loading-state, .no-more-state {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 24px 0;
  color: #86868b;
  font-size: 14px;
  gap: 8px;
}

.preview-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: rgba(0, 0, 0, 0.95);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 9999;
  cursor: pointer;
  
  .preview-image {
    max-width: 90vw;
    max-height: 90vh;
    object-fit: contain;
    user-select: none;
    pointer-events: none;
  }
  
  .close-btn {
    position: fixed;
    top: 24px;
    right: 24px;
    width: 44px;
    height: 44px;
    background-color: rgba(255, 255, 255, 0.95);
    border: none;
    cursor: pointer;
    transition: all 0.2s ease;
    
    &:hover {
      background-color: #ffffff;
      transform: scale(1.1);
    }
  }
}
</style>
