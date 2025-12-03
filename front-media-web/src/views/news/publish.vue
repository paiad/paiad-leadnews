<template>
  <div class="page-container">
    <div class="page-header">
      <h1 class="page-title">{{ isEdit ? '编辑文章' : '发布文章' }}</h1>
    </div>

    <div class="form-card">
      <el-form :model="form" label-position="top" :rules="rules" ref="formRef" size="large">
        <el-form-item label="标题" prop="title">
          <el-input v-model="form.title" placeholder="请输入文章标题" />
        </el-form-item>

        <el-form-item label="内容" prop="content">
          <el-input
            v-model="form.content"
            type="textarea"
            :rows="15"
            placeholder="请输入文章内容..."
            resize="none"
          />
        </el-form-item>

        <el-form-item label="封面" prop="type">
          <el-radio-group v-model="form.type">
            <el-radio :label="0">无图</el-radio>
            <el-radio :label="1">单图</el-radio>
            <el-radio :label="3">三图</el-radio>
            <el-radio :label="-1">自动</el-radio>
          </el-radio-group>
        </el-form-item>

        <el-form-item v-if="form.type > 0" label="封面图片">
           <div class="image-selector-container">
             <div v-for="(_, index) in imageCount" :key="index" class="image-selector" @click="selectImage(index)">
                <img v-if="form.images[index]" :src="getImageUrl(form.images[index])" class="selected-image" />
                <el-icon v-else class="plus-icon"><Plus /></el-icon>
             </div>
           </div>
        </el-form-item>

        <el-form-item label="频道" prop="channelId">
          <el-select v-model="form.channelId" placeholder="请选择频道" class="w-full">
            <el-option v-for="channel in channels" :key="channel.id" :label="channel.name" :value="channel.id" />
          </el-select>
        </el-form-item>

        <div class="form-actions">
          <el-button size="large" @click="handleSubmit(false)" class="draft-button">存草稿</el-button>
          <el-button type="primary" size="large" @click="handleSubmit(true)" class="submit-button">发布</el-button>
        </div>
      </el-form>
    </div>
    
    <el-dialog v-model="dialogVisible" title="选择素材" width="800px" class="material-dialog">
       <div class="material-grid">
          <div v-for="item in materials" :key="item.id" class="material-item" @click="confirmImage(item.url)">
             <img :src="getImageUrl(item.url)" class="material-img" alt="material" />
          </div>
       </div>
       <div class="dialog-footer">
         <el-pagination layout="prev, pager, next" :total="materialTotal" @current-change="loadMaterials" background />
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
import { Plus } from '@element-plus/icons-vue'
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
  title: [{ required: true, message: '请输入标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入内容', trigger: 'blur' }],
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
  console.log('[News Publish] Loading materials, page:', page)
  const res = await getMaterialList({ page, size: 20, isCollection: 0 })
  console.log('[News Publish] Materials response:', res)
  
  if (res.code === 200) {
    if (res.host) {
      fileHost.value = res.host
      console.log('[News Publish] Material file host:', fileHost.value)
    }
    
    // Handle different response structures
    if (res.data) {
      if (res.data.rows && Array.isArray(res.data.rows)) {
        materials.value = res.data.rows
        materialTotal.value = res.data.total || 0
        console.log('[News Publish] Loaded materials:', materials.value.length, 'Total:', materialTotal.value)
      } else if (Array.isArray(res.data)) {
        materials.value = res.data
        materialTotal.value = res.data.length
        console.log('[News Publish] Loaded materials array:', materials.value.length)
      } else {
        console.warn('[News Publish] Unexpected materials data structure:', res.data)
        materials.value = []
        materialTotal.value = 0
      }
    } else {
      console.warn('[News Publish] No materials data in response')
      materials.value = []
      materialTotal.value = 0
    }
  } else {
    console.error('[News Publish] Materials error response:', res)
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
      // Filter out empty strings or undefined values from images array
      // Also ensure we only send the number of images required by the type
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
          ElMessage.success(isSubmit ? '发布成功' : '已存草稿')
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
    console.log('[News Publish] Loading news detail for id:', id)
    const res = await getNewsDetail(id)
    console.log('[News Publish] News detail response:', res)
    
    if (res.code === 200 && res.data) {
      const data = res.data
      console.log('[News Publish] Setting form data:', data)
      
      form.id = data.id
      form.title = data.title || ''
      
      // Handle content parsing (JSON array or string)
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
          // If parse fails, treat as simple string
          form.content = data.content
        }
      } else {
        form.content = ''
      }
      
      form.type = data.type ?? 1
      form.channelId = data.channelId
      form.status = data.status ?? 0
      
      // Handle images field - can be string (comma-separated) or array
      if (data.images) {
        if (typeof data.images === 'string') {
          // If it's a string, split by comma and filter empty strings
          form.images = data.images.split(',').filter((img: string) => img.trim())
          console.log('[News Publish] Images from string:', form.images)
        } else if (Array.isArray(data.images)) {
          form.images = data.images.filter((img: string) => img)
          console.log('[News Publish] Images from array:', form.images)
        } else {
          form.images = []
          console.warn('[News Publish] Unexpected images format:', data.images)
        }
      } else {
        form.images = []
      }
      
      // Store host for image URLs
      if (res.host) {
        fileHost.value = res.host
        console.log('[News Publish] File host:', fileHost.value)
      }
      
      ElMessage.success('文章详情加载成功')
    } else {
      console.error('[News Publish] Invalid response:', res)
      ElMessage.error(res.errorMessage || '加载文章详情失败')
    }
  } catch (error: any) {
    console.error('[News Publish] Load news error:', error)
    
    // If the detail endpoint doesn't exist, show a helpful message
    if (error.response?.status === 404) {
      ElMessage.error('文章详情接口不存在，请联系后端开发人员')
    } else {
      ElMessage.error('加载文章详情失败')
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
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;
  
  .page-title {
    font-size: 24px;
    font-weight: 600;
    color: #1d1d1f;
    margin: 0;
  }
  
  .back-button {
    border-radius: 20px;
  }
}

.form-card {
  background: white;
  padding: 24px;
  border-radius: 12px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.05);
  
  :deep(.el-form-item__label) {
    font-weight: 500;
    color: #1d1d1f;
    margin-bottom: 8px;
  }
  
  :deep(.el-input__wrapper), :deep(.el-textarea__inner) {
    box-shadow: 0 0 0 1px #e5e5e7 inset;
    border-radius: 6px;
    padding: 8px 12px;
    transition: all 0.2s ease;
    
    &.is-focus {
      box-shadow: 0 0 0 0.5px #9c9c9c inset;
    }
  }
}

.image-selector-container {
  display: flex;
  gap: 16px;
}

.image-selector {
  width: 120px;
  height: 120px;
  border: 1px dashed #d2d2d7;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
  overflow: hidden;
  
  &:hover {
    border-color: #000000;
    background-color: #f5f5f7;
  }
  
  .selected-image {
    width: 100%;
    height: 100%;
    object-fit: cover;
  }
  
  .plus-icon {
    font-size: 24px;
    color: #86868b;
  }
}

.form-actions {
  margin-top: 40px;
  display: flex;
  justify-content: flex-end;
  gap: 12px;
  
  .draft-button {
    border-radius: 8px;
    font-weight: 500;
  }
  
  .submit-button {
    background-color: #000000;
    border: none;
    border-radius: 8px;
    font-weight: 500;
    
    &:hover {
      background-color: #333333;
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
    border-radius: 8px;
    overflow: hidden;
    border: 2px solid transparent;
    
    &:hover {
      border-color: #000000;
    }
    
    .material-img {
      width: 100%;
      height: 100%;
    }
  }
}

.dialog-footer {
  margin-top: 20px;
  display: flex;
  justify-content: flex-end;
}
</style>
