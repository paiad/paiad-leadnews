<template>
  <div class="page-container">
    <div class="page-header">
      <h1 class="page-title">素材库</h1>
      <div class="header-actions">
        <el-upload
          class="upload-demo"
          action=""
          :http-request="handleBatchUpload"
          :show-file-list="false"
          accept="image/*"
          :multiple="true"
        >
          <el-button type="primary" class="action-button">上传图片</el-button>
        </el-upload>
      </div>
    </div>

    <div class="tabs-row">
      <el-tabs v-model="activeTab" @tab-change="handleTabChange" class="custom-tabs">
        <el-tab-pane label="全部图片" name="all"></el-tab-pane>
        <el-tab-pane label="收藏" name="favorite"></el-tab-pane>
      </el-tabs>
      <div class="tabs-actions">
        <el-button 
          v-if="!isEditMode"
          type="default" 
          @click="enterEditMode"
          class="manage-btn"
        >
          管理
        </el-button>
        <el-button 
          v-else
          type="primary" 
          @click="exitEditMode"
          class="done-btn"
        >
          完成
        </el-button>
      </div>
    </div>

    <div class="content-area" v-loading="loading">
      <div v-if="materialList.length > 0" class="material-grid">
        <div 
          v-for="item in materialList" 
          :key="item.id" 
          class="material-card group"
          :class="{ 'selected': isEditMode && selectedIds.includes(item.id) }"
          @click="isEditMode && toggleSelection(item.id)"
        >
          <el-image
            :src="getImageUrl(item.url)"
            fit="cover"
            class="material-image"
            loading="lazy"
            @click.stop="!isEditMode && handlePreview(item.url)"
            :style="{ cursor: isEditMode ? 'pointer' : 'zoom-in' }"
          />
          <!-- 选择指示器 -->
          <div v-if="isEditMode" class="selection-indicator">
            <el-icon v-if="selectedIds.includes(item.id)"><Select /></el-icon>
          </div>
          <div class="overlay" v-if="!isEditMode">
             <div class="overlay-content">
               <span class="date">{{ formatDate(item.createdTime) }}</span>
             </div>
          </div>
          <div class="actions" v-if="!isEditMode">
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
    </div>
    
    <!-- 分页器 -->
    <div class="pagination-container" v-if="total > 0">
      <el-pagination
        v-model:current-page="queryParams.page"
        v-model:page-size="queryParams.size"
        :page-sizes="[12, 24, 48, 96]"
        :total="total"
        layout="total, sizes, prev, pager, next"
        background
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
      />
    </div>
    
    <!-- 浮动操作栏 - 仅在编辑模式且有选中项时显示 -->
    <transition name="slide-up">
      <div v-if="isEditMode && selectedIds.length > 0" class="floating-action-bar">
        <div class="selection-info">
          <span class="selection-count">已选择 {{ selectedIds.length }} 项</span>
          <el-button link @click="clearSelection" class="clear-btn">取消选择</el-button>
        </div>
        <el-button type="danger" @click="handleBatchDelete" class="batch-delete-btn">
          <el-icon><Delete /></el-icon>
          批量删除
        </el-button>
      </div>
    </transition>
    
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
import { ref, reactive, onMounted } from 'vue'
import { getMaterialList, batchUploadPictures, collectMaterial, deleteMaterial, batchDeleteMaterial } from '@/api/material'
import { ElMessage, ElMessageBox } from 'element-plus'
import type { UploadRequestOptions } from 'element-plus'
import { Picture, Star, StarFilled, Delete, Close, Select } from '@element-plus/icons-vue'

const previewVisible = ref(false)
const previewUrl = ref('')
const isEditMode = ref(false)
const selectedIds = ref<number[]>([])

const loading = ref(false)
const activeTab = ref('all')
const materialList = ref<any[]>([])
const total = ref(0)
const fileHost = ref('')

const queryParams = reactive({
  page: 1,
  size: 24,
  isCollection: 0
})

const formatDate = (dateStr: string) => {
  if (!dateStr) return ''
  return new Date(dateStr).toLocaleDateString()
}

const getImageUrl = (url: string) => {
  if (!url) return ''
  if (url.startsWith('http')) return url
  return (fileHost.value || '') + url
}

// 编辑模式控制
const enterEditMode = () => {
  isEditMode.value = true
}

const exitEditMode = () => {
  isEditMode.value = false
  selectedIds.value = []
}

const clearSelection = () => {
  selectedIds.value = []
}

const toggleSelection = (id: number) => {
  const index = selectedIds.value.indexOf(id)
  if (index === -1) {
    selectedIds.value.push(id)
  } else {
    selectedIds.value.splice(index, 1)
  }
}

const loadMaterials = async () => {
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
      
      if (res.data && Array.isArray(res.data)) {
        materialList.value = res.data
      } else {
        materialList.value = []
      }
      
      // 后端返回的 total 字段
      total.value = (res as any).total || 0
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载素材失败')
  } finally {
    loading.value = false
  }
}

const handleSizeChange = (val: number) => {
  queryParams.size = val
  queryParams.page = 1
  loadMaterials()
}

const handleCurrentChange = (val: number) => {
  queryParams.page = val
  loadMaterials()
}

const handleTabChange = (tab: any) => {
  queryParams.isCollection = tab === 'favorite' ? 1 : 0
  queryParams.page = 1
  loadMaterials()
}

// 批量上传处理 - 收集所有文件后一次性上传
const pendingFiles: File[] = []
let uploadTimer: ReturnType<typeof setTimeout> | null = null

const handleBatchUpload = async (options: UploadRequestOptions) => {
  pendingFiles.push(options.file)
  
  // 使用防抖，等待所有文件选择完成后再统一上传
  if (uploadTimer) {
    clearTimeout(uploadTimer)
  }
  
  uploadTimer = setTimeout(async () => {
    if (pendingFiles.length === 0) return
    
    const formData = new FormData()
    pendingFiles.forEach(file => {
      formData.append('multipartFiles', file)
    })
    
    try {
      const res = await batchUploadPictures(formData)
      if (res.code === 200) {
        ElMessage.success(`成功上传 ${pendingFiles.length} 张图片`)
        queryParams.page = 1
        loadMaterials()
      } else {
        ElMessage.error(res.errorMessage || '上传失败')
      }
    } catch (error) {
      ElMessage.error('上传失败')
    } finally {
      // 清空待上传列表
      pendingFiles.length = 0
    }
  }, 300)
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
          total.value--
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
      loadMaterials()
    } else {
      ElMessage.error(res.errorMessage || '删除失败')
    }
  } catch (error: any) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

const handleBatchDelete = async () => {
  if (selectedIds.value.length === 0) {
    ElMessage.warning('请先选择要删除的素材')
    return
  }
  
  try {
    await ElMessageBox.confirm(
      `确定要删除选中的 ${selectedIds.value.length} 个素材吗？`,
      '批量删除确认',
      {
        confirmButtonText: '确定删除',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )
    
    const res = await batchDeleteMaterial(selectedIds.value)
    if (res.code === 200) {
      ElMessage.success('批量删除成功')
      selectedIds.value = []
      loadMaterials()
    } else {
      ElMessage.error(res.errorMessage || '批量删除失败')
    }
  } catch (error: any) {
    if (error !== 'cancel') {
      console.error('批量删除失败:', error)
      ElMessage.error('批量删除失败')
    }
  }
}

const handlePreview = (url: string) => {
  previewUrl.value = getImageUrl(url)
  previewVisible.value = true
}

onMounted(() => {
  loadMaterials()
})
</script>

<style scoped lang="scss">
.page-container {
  max-width: 1200px;
  margin: 0 auto;
  padding-bottom: 80px;
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
  
  .header-actions {
    display: flex;
    gap: 12px;
    align-items: center;
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

.tabs-row {
  display: flex;
  align-items: flex-end;
  justify-content: space-between;
  margin-bottom: 24px;
  border-bottom: 1px solid #e5e5e5;
  
  .tabs-actions {
    margin-bottom: 8px;
    
    .manage-btn {
      border-radius: 8px;
      font-weight: 500;
      border-color: #e5e5e7;
      
      &:hover {
        border-color: #000000;
        color: #000000;
      }
    }
    
    .done-btn {
      border-radius: 8px;
      font-weight: 500;
      background-color: #000000;
      border-color: #000000;
      
      &:hover {
        background-color: #333333;
        border-color: #333333;
      }
    }
  }
}

.custom-tabs {
  flex: 1;
  margin-bottom: 0;
  
  :deep(.el-tabs__nav-wrap::after) {
    display: none;
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

.material-grid {
  display: grid;
  grid-template-columns: repeat(6, 1fr);
  gap: 16px;
  
  @media (max-width: 1200px) {
    grid-template-columns: repeat(4, 1fr);
  }
  
  @media (max-width: 768px) {
    grid-template-columns: repeat(2, 1fr);
  }
}

.material-card {
  position: relative;
  border-radius: 12px;
  overflow: hidden;
  background-color: #f5f5f7;
  aspect-ratio: 1;
  cursor: pointer;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
  
  &:hover {
    transform: scale(1.02);
    
    .overlay {
      opacity: 1;
    }
    
    .actions {
      opacity: 1;
    }
  }
  
  &.selected {
    box-shadow: 0 0 0 3px #000000;
    
    .selection-indicator {
      background-color: #000000;
      color: white;
    }
  }
  
  .material-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .selection-indicator {
    position: absolute;
    top: 8px;
    left: 8px;
    width: 24px;
    height: 24px;
    border-radius: 50%;
    background-color: rgba(255, 255, 255, 0.9);
    border: 2px solid #e5e5e7;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10;
    transition: all 0.2s ease;
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

.pagination-container {
  display: flex;
  justify-content: center;
  margin-top: 32px;
  padding-bottom: 24px;
}

// 浮动操作栏
.floating-action-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: white;
  border-top: 1px solid #e5e5e7;
  box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.1);
  padding: 16px 24px;
  display: flex;
  justify-content: space-between;
  align-items: center;
  z-index: 100;
  
  .selection-info {
    display: flex;
    align-items: center;
    gap: 16px;
    
    .selection-count {
      font-size: 14px;
      color: #1d1d1f;
      font-weight: 500;
    }
    
    .clear-btn {
      color: #86868b;
      font-size: 14px;
      
      &:hover {
        color: #0066cc;
      }
    }
  }
  
  .batch-delete-btn {
    border-radius: 8px;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 6px;
  }
}

// 动画
.slide-up-enter-active,
.slide-up-leave-active {
  transition: all 0.3s ease;
}

.slide-up-enter-from,
.slide-up-leave-to {
  transform: translateY(100%);
  opacity: 0;
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
