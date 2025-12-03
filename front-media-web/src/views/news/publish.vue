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
          <div class="content-editor">
            <div 
              v-for="(block, index) in form.content" 
              :key="index" 
              class="content-block"
            >
              <!-- 文本块 -->
              <div v-if="block.type === 'text'" class="block-wrapper text-block">
                <el-input
                  v-model="block.value"
                  type="textarea"
                  :rows="3"
                  placeholder="请输入正文内容..."
                  resize="none"
                  class="custom-textarea"
                />
              </div>

              <!-- 图片块 -->
              <div v-if="block.type === 'image'" class="block-wrapper image-block">
                <img :src="getImageUrl(block.value)" class="block-image" />
              </div>

              <!-- 块操作栏 -->
              <div class="block-actions">
                <div class="action-group">
                  <button 
                    type="button"
                    class="icon-btn" 
                    @click.prevent="moveBlockUp(index)" 
                    :disabled="index === 0"
                    title="上移"
                  >
                    <el-icon><ArrowUp /></el-icon>
                  </button>
                  <button 
                    type="button"
                    class="icon-btn" 
                    @click.prevent="moveBlockDown(index)" 
                    :disabled="index === form.content.length - 1"
                    title="下移"
                  >
                    <el-icon><ArrowDown /></el-icon>
                  </button>
                  <button 
                    type="button"
                    class="icon-btn delete" 
                    @click.prevent="removeBlock(index)"
                    title="删除"
                  >
                    <el-icon><Delete /></el-icon>
                  </button>
                </div>
              </div>
            </div>

            <!-- 底部添加按钮 -->
            <div class="editor-toolbar">
              <button type="button" class="tool-btn" @click.prevent="addTextBlock">
                <el-icon><Document /></el-icon>
                <span>添加文本</span>
              </button>
              
              <el-dropdown trigger="click" @command="handleImageCommand">
                <button type="button" class="tool-btn">
                  <el-icon><Picture /></el-icon>
                  <span>添加图片</span>
                  <el-icon class="ml-1 text-xs"><ArrowDown /></el-icon>
                </button>
                <template #dropdown>
                  <el-dropdown-menu>
                    <el-dropdown-item command="local">
                      <el-upload
                        class="upload-trigger-item"
                        action=""
                        :http-request="handleUploadImage"
                        :show-file-list="false"
                        accept="image/*"
                      >
                        <div class="flex items-center gap-2">
                          <el-icon><Upload /></el-icon>
                          <span>本地上传</span>
                        </div>
                      </el-upload>
                    </el-dropdown-item>
                    <el-dropdown-item command="material">
                      <div class="flex items-center gap-2">
                        <el-icon><Folder /></el-icon>
                        <span>素材库</span>
                      </div>
                    </el-dropdown-item>
                  </el-dropdown-menu>
                </template>
              </el-dropdown>
            </div>
          </div>
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
             <div v-for="(_, index) in imageCount" :key="index" class="relative group">
               <el-dropdown trigger="click" @command="(cmd: string) => handleCoverCommand(cmd, index)">
                 <div class="image-selector hover:border-blue-500 transition-colors duration-300">
                    <img v-if="form.images[index]" :src="getImageUrl(form.images[index])" class="selected-image" />
                    <div v-else class="placeholder-content">
                      <el-icon class="plus-icon"><Plus /></el-icon>
                      <span class="placeholder-text">添加图片</span>
                    </div>
                 </div>
                 <template #dropdown>
                   <el-dropdown-menu>
                     <el-dropdown-item command="local">
                       <el-upload
                         action=""
                         :http-request="(opts: any) => handleUploadCover(opts, index)"
                         :show-file-list="false"
                         accept="image/*"
                         class="w-full"
                       >
                         <div class="flex items-center gap-2">
                           <el-icon><Upload /></el-icon>
                           <span>本地上传</span>
                         </div>
                       </el-upload>
                     </el-dropdown-item>
                     <el-dropdown-item command="material">
                       <div class="flex items-center gap-2">
                         <el-icon><Folder /></el-icon>
                         <span>素材库</span>
                       </div>
                     </el-dropdown-item>
                   </el-dropdown-menu>
                 </template>
               </el-dropdown>
             </div>
           </div>
        </el-form-item>

        <el-form-item prop="publishTime">
          <template #label>
            <span class="form-label-text">定时发布</span>
            <span class="form-label-tip">默认为立即发布</span>
          </template>
          <el-date-picker
            v-model="form.publishTime"
            type="datetime"
            placeholder="选择发布时间"
            class="custom-select w-full"
            format="YYYY-MM-DD HH:mm:ss"
            value-format="YYYY-MM-DD HH:mm:ss"
            :disabled-date="disabledDate"
          />
        </el-form-item>

        <div class="form-actions">
          <button type="button" class="action-btn secondary" @click="handleSubmit(false)">
            存草稿
          </button>
          <button type="button" class="action-btn primary" @click="handleSubmit(true)">
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
           <button type="button" class="close-btn" @click="dialogVisible = false">
             <el-icon><Close /></el-icon>
           </button>
         </div>
       </template>
       
       <div class="material-grid">
          <div v-for="item in materials" :key="item.id" class="material-item" @click="confirmImage(item.url)">
             <img :src="getImageUrl(item.url)" class="material-img" alt="material" />
             <div class="selection-overlay">
               <el-icon class="check-icon"><Check /></el-icon>
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
import { getMaterialList, uploadPicture } from '@/api/material'
import { ElMessage } from 'element-plus'
import type { FormInstance, UploadRequestOptions } from 'element-plus'
import { 
  ArrowUp, 
  ArrowDown, 
  Delete, 
  Document, 
  Picture, 
  Folder, 
  Upload, 
  Plus, 
  Close, 
  Check 
} from '@element-plus/icons-vue'

const route = useRoute()
const router = useRouter()
const formRef = ref<FormInstance>()
const channels = ref<any[]>([])
const dialogVisible = ref(false)
// 区分素材库选择用途：'cover' - 封面, 'content' - 正文插入
const materialSelectMode = ref<'cover' | 'content'>('cover')
// 当前操作的图片索引（用于封面）
const currentImageIndex = ref(0)

const materials = ref<any[]>([])
const materialTotal = ref(0)
const fileHost = ref('')

const isEdit = computed(() => !!route.query.id)

interface ContentBlock {
  type: 'text' | 'image'
  value: string
}

const form = reactive({
  id: undefined,
  title: '',
  // content 现在是一个块数组
  content: [] as ContentBlock[],
  type: 1,
  channelId: undefined,
  images: [] as string[],
  status: 0,
  publishTime: null as string | null
})

const imageCount = computed(() => {
  if (form.type === 1) return 1
  if (form.type === 3) return 3
  return 0
})

const validatePublishTime = (_: any, value: any, callback: any) => {
  if (value && new Date(value).getTime() < Date.now()) {
    callback(new Error('不能选择过去的时间'))
  } else {
    callback()
  }
}

const rules = {
  title: [{ required: true, message: '请输入文章标题', trigger: 'blur' }],
  content: [{ required: true, message: '请输入文章内容', trigger: 'blur' }],
  channelId: [{ required: true, message: '请选择频道', trigger: 'change' }],
  publishTime: [{ validator: validatePublishTime, trigger: 'change' }]
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

// 打开素材库选择封面
const selectCoverImage = (index: number) => {
  materialSelectMode.value = 'cover'
  currentImageIndex.value = index
  dialogVisible.value = true
  loadMaterials()
}

// 打开素材库插入正文图片
const insertImageFromMaterial = () => {
  materialSelectMode.value = 'content'
  dialogVisible.value = true
  loadMaterials()
}

// 确认选择素材
const confirmImage = (url: string) => {
  if (materialSelectMode.value === 'cover') {
    form.images[currentImageIndex.value] = url
  } else {
    // 插入到正文末尾
    form.content.push({ type: 'image', value: url })
    // 自动追加一个文本块
    form.content.push({ type: 'text', value: '' })
  }
  dialogVisible.value = false
}

// 处理图片添加命令
const handleImageCommand = (command: string) => {
  if (command === 'material') {
    insertImageFromMaterial()
  }
  // local command is handled by el-upload directly
}

// 处理封面图片命令
const handleCoverCommand = (command: string, index: number) => {
  if (command === 'material') {
    selectCoverImage(index)
  }
}

// 上传封面图片
const handleUploadCover = async (options: UploadRequestOptions, index: number) => {
  const formData = new FormData()
  formData.append('multipartFile', options.file)
  
  try {
    const res = await uploadPicture(formData)
    if (res.code === 200) {
      form.images[index] = res.data
      ElMessage.success('上传成功')
    } else {
      ElMessage.error(res.errorMessage || '上传失败')
    }
  } catch (error) {
    ElMessage.error('上传失败')
  }
}

const disabledDate = (time: Date) => {
  return time.getTime() < Date.now() - 8.64e7
}

// 本地上传图片
const handleUploadImage = async (options: UploadRequestOptions) => {
  const formData = new FormData()
  formData.append('multipartFile', options.file)
  
  try {
    const res = await uploadPicture(formData)
    if (res.code === 200) {
      // 插入图片块
      form.content.push({ type: 'image', value: res.data })
      // 自动追加一个文本块
      form.content.push({ type: 'text', value: '' })
      ElMessage.success('上传成功')
    } else {
      ElMessage.error(res.errorMessage || '上传失败')
    }
  } catch (error) {
    ElMessage.error('上传失败')
  }
}

// 添加文本块
const addTextBlock = () => {
  form.content.push({ type: 'text', value: '' })
}

// 删除块
const removeBlock = (index: number) => {
  form.content.splice(index, 1)
}

// 上移块
const moveBlockUp = (index: number) => {
  if (index > 0) {
    const temp = form.content[index]
    const prev = form.content[index - 1]
    if (temp && prev) {
      form.content[index] = prev
      form.content[index - 1] = temp
    }
  }
}

// 下移块
const moveBlockDown = (index: number) => {
  if (index < form.content.length - 1) {
    const temp = form.content[index]
    const next = form.content[index + 1]
    if (temp && next) {
      form.content[index] = next
      form.content[index + 1] = temp
    }
  }
}

const handleSubmit = async (isSubmit: boolean) => {
  if (!formRef.value) return
  
  // 简单校验：内容不能为空
  if (form.content.length === 0) {
    ElMessage.warning('请输入文章内容')
    return
  }
  
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
        // 直接序列化 content 数组
        content: JSON.stringify(form.content),
        status: isSubmit ? 1 : 0,
        images: imagesToSend,
        channelId: form.channelId as unknown as number,
        publishTime: form.publishTime || undefined
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
          } else {
            // 兼容旧数据（如果是纯字符串）
            form.content = [{ type: 'text', value: data.content }]
          }
        } catch (e) {
          form.content = [{ type: 'text', value: data.content }]
        }
      } else {
        form.content = [{ type: 'text', value: '' }]
      }
      
      form.type = data.type ?? 1
      form.channelId = data.channelId
      form.status = data.status ?? 0
      form.publishTime = data.publishTime || null
      
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
  } else {
    // 新建时默认添加一个文本块
    form.content = [{ type: 'text', value: '' }]
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
  
  .form-label-tip {
    font-size: 12px;
    color: #86868b;
    margin-left: 8px;
    font-weight: normal;
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
      
      .check-icon {
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

/* 块级编辑器样式 */
.content-editor {
  width: 100%;
  
  .content-block {
    position: relative;
    margin-bottom: 16px;
    border-radius: 12px;
    transition: all 0.2s;
    
    &:hover {
      .block-actions {
        opacity: 1;
      }
    }
    
    .block-wrapper {
      &.image-block {
        display: flex;
        justify-content: center;
        background: #f5f5f7;
        padding: 16px;
        border-radius: 12px;
        
        .block-image {
          max-width: 100%;
          max-height: 400px;
          border-radius: 8px;
          object-fit: contain;
        }
      }
    }
    
    .block-actions {
      position: absolute;
      right: -48px;
      top: 0;
      opacity: 0;
      transition: opacity 0.2s;
      
      .action-group {
        display: flex;
        flex-direction: column;
        gap: 4px;
        background: white;
        padding: 4px;
        border-radius: 8px;
        box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
        
        .icon-btn {
          width: 32px;
          height: 32px;
          display: flex;
          align-items: center;
          justify-content: center;
          border: 1px solid #e5e5e7;
          background: white;
          cursor: pointer;
          color: #86868b;
          border-radius: 6px;
          transition: all 0.2s;
          
          &:hover {
            border-color: #1d1d1f;
            background: #f5f5f7;
            color: #1d1d1f;
          }
          
          &.delete:hover {
            background: #fff1f1;
            color: #ff3b30;
          }
          
          &:disabled {
            opacity: 0.3;
            cursor: not-allowed;
          }
        }
      }
    }
  }
  
  .editor-toolbar {
    display: flex;
    gap: 12px;
    margin-top: 24px;
    padding-top: 24px;
    border-top: 1px dashed #e5e5e7;
    
    .tool-btn {
      display: flex;
      align-items: center;
      gap: 8px;
      height: 40px;
      padding: 0 16px;
      border: 1px solid #e5e5e7;
      background: white;
      border-radius: 20px;
      color: #1d1d1f;
      font-size: 14px;
      font-weight: 500;
      cursor: pointer;
      transition: all 0.2s;
      
      &:hover {
        border-color: #1d1d1f;
        background: #f5f5f7;
      }
      
      .el-icon {
        font-size: 18px;
      }
    }
    
    .upload-trigger {
      display: inline-block;
    }
  }
}

.upload-trigger-item {
  width: 100%;
  
  :deep(.el-upload) {
    width: 100%;
    display: block;
    text-align: left;
  }
}</style>
