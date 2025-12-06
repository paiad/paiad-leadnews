<template>
  <div class="w-full">
    <!-- 内容块列表 -->
    <div
      v-for="(block, index) in modelValue"
      :key="index"
      class="relative mb-4 group"
    >
      <ContentBlockVue
        :block="block"
        :index="index"
        :total="modelValue.length"
        :file-host="fileHost"
        @update:block="updateBlock(index, $event)"
        @move-up="$emit('move-up', index)"
        @move-down="$emit('move-down', index)"
        @remove="$emit('remove', index)"
      />
    </div>

    <!-- 工具栏 -->
    <div class="flex gap-3 mt-6 pt-6">
      <button type="button" class="tool-btn" @click="$emit('add-text')">
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
                class="w-full"
                action=""
                :http-request="handleUpload"
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
</template>

<script setup lang="ts">
import { Document, Picture, ArrowDown, Upload, Folder } from '@element-plus/icons-vue'
import { uploadPicture } from '@/api/material'
import { ElMessage } from 'element-plus'
import type { UploadRequestOptions } from 'element-plus'
import type { ContentBlock as ContentBlockType } from '@/types/publish'
import ContentBlockVue from './ContentBlock.vue'

interface Props {
  modelValue: ContentBlockType[]
  fileHost: string
}

interface Emits {
  (e: 'update:modelValue', blocks: ContentBlockType[]): void
  (e: 'add-text'): void
  (e: 'add-image', url: string): void
  (e: 'move-up', index: number): void
  (e: 'move-down', index: number): void
  (e: 'remove', index: number): void
  (e: 'open-material'): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const updateBlock = (index: number, block: ContentBlockType) => {
  const newBlocks = [...props.modelValue]
  newBlocks[index] = block
  emit('update:modelValue', newBlocks)
}

const handleImageCommand = (command: string) => {
  if (command === 'material') {
    emit('open-material')
  }
}

const handleUpload = async (options: UploadRequestOptions) => {
  const formData = new FormData()
  formData.append('multipartFile', options.file)

  try {
    const res = await uploadPicture(formData)
    if (res.code === 200) {
      const url = (res.data && typeof res.data === 'object') ? res.data.url : res.data
      emit('add-image', url)
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
}

.tool-btn:hover {
  border-color: #1d1d1f;
  background: #f5f5f7;
}

.tool-btn .el-icon {
  font-size: 18px;
}
</style>
