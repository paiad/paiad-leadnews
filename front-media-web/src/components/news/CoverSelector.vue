<template>
  <div>
    <!-- 封面类型选择 -->
    <el-form-item label="封面" prop="type">
      <div class="flex gap-2 bg-gray-100 p-1 rounded-xl w-fit">
        <div
          v-for="option in typeOptions"
          :key="option.value"
          class="type-option"
          :class="{ active: modelType === option.value }"
          @click="$emit('update:modelType', option.value)"
        >
          {{ option.label }}
        </div>
      </div>
    </el-form-item>

    <!-- 无图预览 -->
    <el-form-item v-if="modelType === 0" label="封面预览">
      <div class="flex gap-4">
        <div class="image-selector">
          <img src="https://cdn.jsdelivr.net/gh/paiad/picture-bed@main/img/no-img.png" class="w-full h-full object-cover" />
        </div>
      </div>
    </el-form-item>

    <!-- 单图/三图选择 -->
    <el-form-item v-if="modelType > 0" label="选择图片">
      <div class="flex gap-4">
        <div v-for="(_, index) in imageCount" :key="index" class="relative group">
          <el-dropdown trigger="click" @command="(cmd: string) => handleCommand(cmd, index)">
            <div class="image-selector hover:border-blue-500 transition-colors">
              <img v-if="modelImages[index]" :src="getImageUrl(modelImages[index])" class="w-full h-full object-cover" />
              <div v-else class="flex flex-col items-center gap-2 text-gray-400">
                <el-icon class="text-2xl"><Plus /></el-icon>
                <span class="text-xs font-medium">添加图片</span>
              </div>
            </div>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item command="local">
                  <el-upload
                    action=""
                    :http-request="(opts: any) => handleUpload(opts, index)"
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
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Plus, Upload, Folder } from '@element-plus/icons-vue'
import { uploadPicture } from '@/api/material'
import { ElMessage } from 'element-plus'
import type { UploadRequestOptions } from 'element-plus'
import { buildImageUrl } from '@/utils/format'
import type { CoverType } from '@/types/publish'

interface Props {
  modelType: CoverType
  modelImages: string[]
  fileHost: string
}

interface Emits {
  (e: 'update:modelType', type: number): void
  (e: 'update:modelImages', images: string[]): void
  (e: 'open-material', index: number): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const typeOptions = [
  { label: '无图', value: 0 },
  { label: '单图', value: 1 },
  { label: '三图', value: 3 },
  { label: '自动', value: -1 }
]

const imageCount = computed(() => {
  if (props.modelType === 1) return 1
  if (props.modelType === 3) return 3
  return 0
})

const getImageUrl = (url: string) => {
  return buildImageUrl(url, props.fileHost)
}

const handleCommand = (command: string, index: number) => {
  if (command === 'material') {
    emit('open-material', index)
  }
}

const handleUpload = async (options: UploadRequestOptions, index: number) => {
  const formData = new FormData()
  formData.append('multipartFile', options.file)

  try {
    const res = await uploadPicture(formData)
    if (res.code === 200) {
      const url = (res.data && typeof res.data === 'object') ? res.data.url : res.data
      const newImages = [...props.modelImages]
      newImages[index] = url
      emit('update:modelImages', newImages)
      ElMessage.success('上传成功')
    } else {
      ElMessage.error(res.errorMessage || '上传失败')
    }
  } catch (error) {
    ElMessage.error('上传失败')
  }
}
</script>

<style scoped>
.type-option {
  padding: 0 20px;
  border-radius: 8px;
  font-size: 14px;
  font-weight: 500;
  color: #86868b;
  cursor: pointer;
  transition: all 0.2s ease;
}

.type-option:hover {
  color: #1d1d1f;
}

.type-option.active {
  background: white;
  color: #1d1d1f;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.08);
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
}

.image-selector:hover {
  border-color: #000000;
  background-color: #f5f5f7;
}
</style>
