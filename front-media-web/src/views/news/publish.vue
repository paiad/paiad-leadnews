<template>
  <div class="page-container">
    <div class="page-header">
      <h1 class="page-title">{{ isEdit ? '编辑文章' : '发布文章' }}</h1>
    </div>

    <div class="form-card">
      <el-form :model="form" label-position="top" :rules="rules" ref="formRef" size="large" class="custom-form">
        <el-form-item label="标题" prop="title">
          <el-input 
            v-model="form.title" 
            placeholder="请输入文章标题" 
            class="custom-input"
          />
        </el-form-item>

        <el-form-item label="内容" prop="content">
          <el-input
            v-model="form.content"
            type="textarea"
            :rows="15"
            placeholder="请输入文章内容..."
            resize="none"
            class="custom-textarea"
          />
        </el-form-item>

        <el-form-item label="封面" prop="type">
          <div class="cover-type-selector">
            <div 
              class="type-option" 
              :class="{ active: form.type === 0 }"
              @click="form.type = 0"
            >
              无图
            </div>
            <div 
              class="type-option" 
              :class="{ active: form.type === 1 }"
              @click="form.type = 1"
            >
              单图
            </div>
            <div 
              class="type-option" 
              :class="{ active: form.type === 3 }"
              @click="form.type = 3"
            >
              三图
            </div>
            <div 
              class="type-option" 
              :class="{ active: form.type === -1 }"
              @click="form.type = -1"
            >
              自动
            </div>
          </div>
        </el-form-item>

        <el-form-item v-if="form.type > 0" label="选择图片">
           <div class="image-selector-container">
             <div v-for="(_, index) in imageCount" :key="index" class="image-selector" @click="selectImage(index)">
                <img v-if="form.images[index]" :src="getImageUrl(form.images[index])" class="selected-image" />
                <div v-else class="placeholder-content">
                  <div class="i-carbon-add plus-icon" />
                  <span class="placeholder-text">添加图片</span>
                </div>
             </div>
           </div>
        </el-form-item>

        <el-form-item label="频道" prop="channelId">
          <el-select 
            v-model="form.channelId" 
            placeholder="请选择频道" 
            class="custom-select w-full"
          >
            <el-option v-for="channel in channels" :key="channel.id" :label="channel.name" :value="channel.id" />
          </el-select>
        </el-form-item>

        <div class="form-actions">
          <button class="action-btn secondary" @click="handleSubmit(false)">
            存草稿
          </button>
          <button class="action-btn primary" @click="handleSubmit(true)">
            发布
          </button>
        </div>
      </el-form>
    </div>
    
    <el-dialog 
      v-model="dialogVisible" 
      title="选择素材" 
      width="800px" 
      class="material-dialog"
      :show-close="false"
    >
       <template #header="{ titleId, titleClass }">
         <div class="dialog-header">
           <span :id="titleId" :class="titleClass">选择素材</span>
           <button class="close-btn" @click="dialogVisible = false">
             <div class="i-carbon-close" />
           </button>
         </div>
       </template>
       
       <div class="material-grid">
          <div v-for="item in materials" :key="item.id" class="material-item" @click="confirmImage(item.url)">
             <img :src="getImageUrl(item.url)" class="material-img" alt="material" />
             <div class="selection-overlay">
               <div class="i-carbon-checkmark-filled" />
             </div>
          </div>
       </div>
       <div class="dialog-footer">
         <el-pagination 
           layout="prev, pager, next" 
           :total="materialTotal" 
           @current-change="loadMaterials" 
           background 
           small
         />
       </div>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getChannels } from '@/api/channel'
import { submitNews, getNewsDetail } from '@/api/news'
import { getMaterialList } from '@/api/material'
import { ElMessage } from 'element-plus'
import type { FormInstance } from 'element-plus'

const route = useRoute()
const router = useRouter()
const formRef = ref<FormInstance>()
const channels = ref<any[]>([])
const dialogVisible = ref(false)
const currentImageIndex = ref(0)
const materials = ref<any[]>([])
const materialTotal = ref(0)
const fileHost = ref('')

const isEdit = computed(() => !!route.query.id)

const form = reactive({
  id: undefined,
  title: '',
  content: '',
  type: 1,
  channelId: undefined,
  images: [] as string[],
  status: 0
})

const imageCount = computed(() => {
  if (form.type === 1) return 1
  if (form.type === 3) return 3
  return 0
})

const rules = {
  title: [{ required: true, message: '请输入文章标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入文章内容', trigger: 'blur' }],
  channelId: [{ required: true, message: '请选择频道', trigger: 'change' }]
}

const getImageUrl = (url: string) => {
  if (!url) return ''
  if (url.startsWith('http')) return url
  return (fileHost.value || '') + url
}

const loadChannels = async () => {
  const res = await getChannels()
  if (res.code === 200) {
    channels.value = res.data
  }
}

const loadMaterials = async (page = 1) => {
  const res = await getMaterialList({ page, size: 20, isCollection: 0 })
  
  if (res.code === 200) {
    if (res.host) {
      fileHost.value = res.host
    }
    
    if (res.data) {
      if (res.data.rows && Array.isArray(res.data.rows)) {
        materials.value = res.data.rows
        materialTotal.value = res.data.total || 0
      } else if (Array.isArray(res.data)) {
        materials.value = res.data
        materialTotal.value = res.data.length
      } else {
        materials.value = []
        materialTotal.value = 0
      }
    } else {
      materials.value = []
      materialTotal.value = 0
    }
  } else {
    materials.value = []
    materialTotal.value = 0
  }
}

const selectImage = (index: number) => {
  currentImageIndex.value = index
  dialogVisible.value = true
  loadMaterials()
}

const confirmImage = (url: string) => {
  form.images[currentImageIndex.value] = url
  dialogVisible.value = false
}

const handleSubmit = async (isSubmit: boolean) => {
  if (!formRef.value) return
  await formRef.value.validate(async (valid) => {
    if (valid) {
      let imagesToSend = form.images.filter((img): img is string => !!img)
      
      if (form.type === 1 && imagesToSend.length > 1) {
          imagesToSend = imagesToSend.slice(0, 1)
      } else if (form.type === 3 && imagesToSend.length > 3) {
          imagesToSend = imagesToSend.slice(0, 3)
      } else if (form.type === 0) {
          imagesToSend = []
      }

      const data = {
        ...form,
        content: JSON.stringify([{
          type: 'text',
          value: form.content
        }]),
        status: isSubmit ? 1 : 0,
        images: imagesToSend,
        channelId: form.channelId as unknown as number
      }
      
      try {
        const res = await submitNews(data)
        if (res.code === 200) {
          ElMessage.success(isSubmit ? '发布成功' : '草稿保存成功')
          router.push('/layout/news/index')
        } else {
          ElMessage.error(res.errorMessage || '操作失败')
        }
      } catch (error) {
        ElMessage.error('操作失败')
      }
    }
  })
}

const loadNewsData = async (id: number) => {
  try {
    const res = await getNewsDetail(id)
    
    if (res.code === 200 && res.data) {
      const data = res.data
      
      form.id = data.id
      form.title = data.title || ''
      
      if (data.content) {
        try {
          const contentArr = JSON.parse(data.content)
          if (Array.isArray(contentArr)) {
            form.content = contentArr
              .filter((item: any) => item.type === 'text')
              .map((item: any) => item.value)
              .join('\n')
          } else {
            form.content = data.content
          }
        } catch (e) {
          form.content = data.content
        }
      } else {
        form.content = ''
      }
      
      form.type = data.type ?? 1
      form.channelId = data.channelId
      form.status = data.status ?? 0
      
      if (data.images) {
        if (typeof data.images === 'string') {
          form.images = data.images.split(',').filter((img: string) => img.trim())
        } else if (Array.isArray(data.images)) {
          form.images = data.images.filter((img: string) => img)
        } else {
          form.images = []
        }
      } else {
        form.images = []
      }
      
      if (res.host) {
        fileHost.value = res.host
      }
    } else {
      ElMessage.error(res.errorMessage || '加载文章失败')
    }
  } catch (error: any) {
    if (error.response?.status === 404) {
      ElMessage.error('文章不存在')
    } else {
      ElMessage.error('加载文章失败')
    }
  }
}

onMounted(() => {
  loadChannels()
  if (isEdit.value) {
    loadNewsData(Number(route.query.id))
  }
})
</script>

<style scoped lang="scss">
.page-container {
  max-width: 1200px;
  margin: 0 auto;
  animation: fadeSlideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
}

.page-header {
  margin-bottom: 32px;
  
  .page-title {
    font-size: 32px;
    font-weight: 700;
    color: #1d1d1f;
    margin: 0;
    letter-spacing: -0.02em;
  }
}

.form-card {
  background: white;
  padding: 40px;
  border-radius: 24px;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.02);
  border: 1px solid rgba(0, 0, 0, 0.02);
  
  :deep(.el-form-item__label) {
    font-weight: 500;
    color: #1d1d1f;
    margin-bottom: 8px;
    font-size: 14px;
  }
  
  .custom-input {
    :deep(.el-input__wrapper) {
      background-color: #f5f5f7;
      box-shadow: none;
      border: 1px solid #e5e5e7;
      border-radius: 12px;
      padding: 8px 16px;
      height: 48px;
      transition: all 0.2s ease;
      
      &.is-focus {
        background-color: white;
        box-shadow: 0 0 0 2px #000000 inset !important;
      }
      
      input {
        font-size: 16px;
        color: #1d1d1f;
      }
    }
  }
  
  .custom-textarea {
    :deep(.el-textarea__inner) {
      background-color: #f5f5f7;
      box-shadow: none;
      border: 1px solid #e5e5e7;
      border-radius: 12px;
      padding: 16px;
      font-size: 16px;
      color: #1d1d1f;
      transition: all 0.2s ease;
      font-family: inherit;
      
      &:focus {
        background-color: white;
        box-shadow: 0 0 0 2px #000000 inset !important;
      }
    }
  }
  
  .custom-select {
    width: 100%;
    
    :deep(.el-input__wrapper) {
      background-color: #f5f5f7;
      box-shadow: none;
      border: 1px solid #e5e5e7;
      border-radius: 12px;
      height: 48px;
      padding: 0 16px;
      transition: all 0.2s ease;
      
      &.is-focus {
        background-color: white;
        box-shadow: 0 0 0 2px #000000 inset !important;
      }
      
      .el-input__inner {
        font-size: 16px;
        color: #1d1d1f;
        height: 48px;
        line-height: 48px;
      }
    }
  }
}

.cover-type-selector {
  display: flex;
  gap: 8px;
  background: #f5f5f7;
  padding: 4px;
  border-radius: 12px;
  width: fit-content;
  
  .type-option {
    padding: 8px 24px;
    border-radius: 8px;
    font-size: 14px;
    font-weight: 500;
    color: #86868b;
    cursor: pointer;
    transition: all 0.2s ease;
    
    &:hover {
      color: #1d1d1f;
    }
    
    &.active {
      background: white;
      color: #1d1d1f;
      box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
    }
  }
}

.image-selector-container {
  display: flex;
  gap: 16px;
}

.image-selector {
  width: 140px;
  height: 140px;
  border: 2px dashed #e5e5e7;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
  overflow: hidden;
  background: #f9f9f9;
  
  &:hover {
    border-color: #000000;
    background-color: #f5f5f7;
  }
  
  .selected-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .placeholder-content {
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 8px;
    color: #86868b;
    
    .plus-icon {
      font-size: 24px;
    }
    
    .placeholder-text {
      font-size: 12px;
      font-weight: 500;
    }
  }
}

.form-actions {
  margin-top: 48px;
  display: flex;
  justify-content: flex-end;
  gap: 16px;
  
  .action-btn {
    height: 48px;
    padding: 0 32px;
    border-radius: 24px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.2s;
    border: none;
    
    &.secondary {
      background: #f5f5f7;
      color: #1d1d1f;
      
      &:hover {
        background: #e5e5e7;
      }
    }
    
    &.primary {
      background: #1d1d1f;
      color: white;
      
      &:hover {
        background: #333333;
        transform: scale(1.02);
      }
      
      &:active {
        transform: scale(0.98);
      }
    }
  }
}

.dialog-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
  font-size: 18px;
  font-weight: 600;
  
  .close-btn {
    background: transparent;
    border: none;
    font-size: 20px;
    cursor: pointer;
    color: #86868b;
    
    &:hover {
      color: #1d1d1f;
    }
  }
}

.material-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 16px;
  max-height: 400px;
  overflow-y: auto;
  padding: 4px;
  
  .material-item {
    aspect-ratio: 1;
    cursor: pointer;
    border-radius: 12px;
    overflow: hidden;
    position: relative;
    
    .material-img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      transition: transform 0.3s;
    }
    
    .selection-overlay {
      position: absolute;
      inset: 0;
      background: rgba(0, 0, 0, 0.4);
      display: flex;
      align-items: center;
      justify-content: center;
      opacity: 0;
      transition: opacity 0.2s;
      
      .i-carbon-checkmark-filled {
        color: white;
        font-size: 32px;
      }
    }
    
    &:hover {
      .material-img {
        transform: scale(1.05);
      }
      
      .selection-overlay {
        opacity: 1;
      }
    }
  }
}

.dialog-footer {
  margin-top: 24px;
  display: flex;
  justify-content: center;
  
  :deep(.el-pagination.is-background .el-pager li:not(.is-disabled).is-active) {
    background-color: #1d1d1f;
  }
}

@keyframes fadeSlideUp {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>
