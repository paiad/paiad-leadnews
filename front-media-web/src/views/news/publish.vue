<template>
  <div class="max-w-300 mx-auto animate-fade-in">
    <!-- 页面标题 -->
    <header class="mb-8 flex items-center gap-4">
      <button 
        type="button" 
        class="back-btn"
        @click="router.back()"
      >
        <el-icon :size="20"><ArrowLeft /></el-icon>
      </button>
      <h1 class="text-2xl font-bold text-gray-900 tracking-tight m-0">{{ isEdit ? '编辑文章' : '发布文章' }}</h1>
    </header>

    <!-- 表单卡片 -->
    <div class="bg-white p-10 rounded-3xl shadow-sm border border-gray-50">
      <el-form
        ref="formRef"
        :model="form"
        :rules="rules"
        label-position="top"
        size="large"
        class="publish-form"
      >
        <!-- 标题 -->
        <el-form-item prop="title" class="title-item">
          <el-input
            v-model="form.title"
            placeholder="请输入文章标题"
            class="custom-input"
          />
        </el-form-item>

        <!-- 内容编辑器 -->
        <el-form-item label="内容" prop="content">
          <ContentEditor
            v-model="form.content"
            :file-host="fileHost"
            @add-text="addTextBlock"
            @add-image="addImageBlock"
            @move-up="moveBlockUp"
            @move-down="moveBlockDown"
            @remove="removeBlock"
            @open-material="openMaterialForContent"
          />
        </el-form-item>

        <!-- 封面选择 -->
        <CoverSelector
          v-model:model-type="form.type"
          v-model:model-images="form.images"
          :file-host="fileHost"
          @open-material="openMaterialForCover"
        />

        <!-- 标签 - 单独一行 -->
        <el-form-item label="标签" prop="labels">
          <TagInput v-model="tags" />
        </el-form-item>

        <!-- 频道、定时发布 - 同一行 -->
        <div class="form-row">
          <el-form-item label="频道" prop="channelId" class="form-row-item">
            <el-select
              v-model="form.channelId"
              placeholder="请选择频道"
              class="custom-select w-full"
            >
              <el-option
                v-for="channel in channels"
                :key="channel.id"
                :label="channel.name"
                :value="channel.id"
              />
            </el-select>
          </el-form-item>

          <el-form-item prop="publishTime" class="form-row-item">
            <template #label>
              <span class="font-medium text-gray-900">定时发布</span>
              <span class="text-xs text-gray-400 ml-2 font-normal">默认立即</span>
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
        </div>

        <!-- 上下架状态（仅编辑已发布文章时显示） -->
        <el-form-item v-if="showShelfStatus" label="上下架状态">
          <el-tag :type="form.enable === 1 ? 'success' : 'info'" effect="light">
            {{ form.enable === 1 ? '已上架' : '已下架' }}
          </el-tag>
          <span class="text-xs text-gray-400 ml-2">上下架操作请在内容管理页面进行</span>
        </el-form-item>

        <!-- 操作按钮 -->
        <div class="mt-12 flex justify-end gap-4">
          <button type="button" class="btn-secondary" @click="handleSubmit(false)">
            存草稿
          </button>
          <button type="button" class="btn-primary" @click="handleSubmit(true)">
            发布
          </button>
        </div>
      </el-form>
    </div>

    <!-- 素材选择对话框 -->
    <MaterialDialog
      v-model="dialogVisible"
      :materials="materials"
      :total="materialTotal"
      :file-host="fileHost"
      @select="handleMaterialSelect"
      @page-change="loadMaterials"
    />
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed, onMounted, watch } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { getChannels } from '@/api/channel'
import { submitNews, getNewsDetail } from '@/api/news'
import { ElMessage } from 'element-plus'
import { ArrowLeft } from '@element-plus/icons-vue'
import type { FormInstance } from 'element-plus'
import type { ContentBlock, CoverType } from '@/types/publish'
import type { ChannelOption } from '@/types/news'
import { useMaterialPicker } from '@/composables/news/useMaterialPicker'
import ContentEditor from './components/ContentEditor.vue'
import CoverSelector from './components/CoverSelector.vue'
import TagInput from './components/TagInput.vue'
import MaterialDialog from './components/MaterialDialog.vue'

const route = useRoute()
const router = useRouter()
const formRef = ref<FormInstance>()
const channels = ref<ChannelOption[]>([])
const tags = ref<string[]>([])

// 素材选择
const {
  dialogVisible,
  materials,
  materialTotal,
  fileHost,
  selectMode,
  currentCoverIndex,
  loadMaterials,
  openForCover,
  openForContent,
  setFileHost
} = useMaterialPicker()

const isEdit = computed(() => !!route.query.id)

// 表单数据
const form = reactive({
  id: undefined as number | undefined,
  title: '',
  content: [] as ContentBlock[],
  type: 1 as CoverType,
  channelId: undefined as number | undefined,
  labels: '',
  images: [] as string[],
  status: 0,
  publishTime: null as string | null,
  enable: 1 as number // 上下架状态：1=上架, 0=下架
})

// 是否显示上下架状态（仅编辑已发布文章时显示）
const showShelfStatus = computed(() => isEdit.value && form.status === 9)

// 同步标签到 form.labels
watch(tags, (newVal) => {
  form.labels = newVal.join(',')
}, { deep: true })

// 表单验证规则
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

const disabledDate = (time: Date) => {
  return time.getTime() < Date.now() - 8.64e7
}

// 内容块操作
const addTextBlock = () => {
  form.content.push({ type: 'text', value: '' })
}

const addImageBlock = (url: string) => {
  form.content.push({ type: 'image', value: url })
}

const removeBlock = (index: number) => {
  form.content.splice(index, 1)
}

const moveBlockUp = (index: number) => {
  if (index > 0) {
    const current = form.content[index]
    const prev = form.content[index - 1]
    if (current && prev) {
      form.content[index] = prev
      form.content[index - 1] = current
    }
  }
}

const moveBlockDown = (index: number) => {
  if (index < form.content.length - 1) {
    const current = form.content[index]
    const next = form.content[index + 1]
    if (current && next) {
      form.content[index] = next
      form.content[index + 1] = current
    }
  }
}

// 素材选择
const openMaterialForContent = () => {
  openForContent()
}

const openMaterialForCover = (index: number) => {
  openForCover(index)
}

const handleMaterialSelect = (url: string) => {
  if (selectMode.value === 'cover') {
    form.images[currentCoverIndex.value] = url
  } else {
    form.content.push({ type: 'image', value: url })
  }
}

// 加载频道
const loadChannels = async () => {
  try {
    const res = await getChannels()
    if (res.code === 200) {
      channels.value = res.data || []
    }
  } catch (error) {
    console.error('加载频道失败:', error)
  }
}

// 提交表单
const handleSubmit = async (isPublish: boolean) => {
  if (!formRef.value) return

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
        content: JSON.stringify(form.content),
        status: isPublish ? 1 : 0,
        images: imagesToSend,
        channelId: form.channelId as number,
        labels: form.labels,
        publishTime: form.publishTime || undefined
      }

      try {
        const res = await submitNews(data)
        if (res.code === 200) {
          ElMessage.success(isPublish ? '发布成功' : '草稿保存成功')
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

// 加载文章数据（编辑模式）
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
      form.labels = data.labels || ''
      tags.value = form.labels ? form.labels.split(',') : []
      form.status = data.status ?? 0
      form.enable = data.enable ?? 1
      form.publishTime = null

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
        setFileHost(res.host)
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

// 初始化
onMounted(() => {
  loadChannels()
  if (isEdit.value) {
    loadNewsData(Number(route.query.id))
  } else {
    form.content = [{ type: 'text', value: '' }]
  }
})
</script>

<style scoped>
.animate-fade-in {
  animation: fadeSlideUp 0.6s cubic-bezier(0.16, 1, 0.3, 1);
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

.form-row {
  display: flex;
  gap: 24px;
  margin-bottom: 8px;
}

.form-row-item {
  flex: 1;
  min-width: 0;
}

.publish-form :deep(.el-form-item__label) {
  font-weight: 500;
  color: #1d1d1f;
  margin-bottom: 8px;
  font-size: 14px;
}

.title-item {
  margin-bottom: 32px;
}

/* 标题输入框特定样式 */
.custom-input :deep(.el-input__wrapper) {
  background-color: transparent;
  box-shadow: none !important;
  border: none;
  border-bottom: 2px solid #e5e5e7;
  border-radius: 0;
  padding: 8px 0;
  height: auto;
  transition: all 0.3s ease;
}

.custom-input :deep(.el-input__wrapper.is-focus) {
  background-color: transparent;
  box-shadow: none !important;
  border-bottom-color: #1d1d1f;
}

.custom-input :deep(.el-input__inner) {
  font-size: 26px;
  font-weight: 600;
  color: #1d1d1f;
  height: 50px;
  line-height: 50px;
  padding: 0;
}

.custom-input :deep(.el-input__inner::placeholder) {
  color: #86868b;
  font-weight: 500;
}

.custom-select :deep(.el-input__wrapper) {
  background-color: #f5f5f7;
  box-shadow: none;
  border: 1px solid #e5e5e7;
  border-radius: 12px;
  height: 48px;
  padding: 0 16px;
  transition: all 0.2s ease;
}

.custom-select :deep(.el-input__wrapper.is-focus) {
  background-color: white;
  box-shadow: 0 0 0 2px #000000 inset !important;
}

.custom-select :deep(.el-input__inner) {
  font-size: 16px;
  color: #1d1d1f;
  height: 48px;
  line-height: 48px;
}

.btn-secondary {
  height: 48px;
  padding: 0 32px;
  border-radius: 24px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  border: none;
  background: #f5f5f7;
  color: #1d1d1f;
}

.btn-secondary:hover {
  background: #e5e5e7;
}

.btn-primary {
  height: 48px;
  padding: 0 32px;
  border-radius: 24px;
  font-size: 16px;
  font-weight: 500;
  cursor: pointer;
  transition: all 0.2s;
  border: none;
  background: #1d1d1f;
  color: white;
}

.btn-primary:hover {
  background: #333333;
  transform: scale(1.02);
}

.btn-primary:active {
  transform: scale(0.98);
}

.back-btn {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  border: 1px solid #e5e5e7;
  background: #ffffff;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
  color: #1d1d1f;
}

.back-btn:hover {
  background: #f5f5f7;
  border-color: #1d1d1f;
}
</style>
