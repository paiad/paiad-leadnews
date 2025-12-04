<template>
  <div class="flex items-center gap-5">
    <!-- 文本块 -->
    <div v-if="block.type === 'text'" class="flex-1">
      <el-input
        v-model="localValue"
        type="textarea"
        :rows="3"
        placeholder="请输入正文内容..."
        resize="none"
        class="content-textarea"
      />
    </div>

    <!-- 图片块 -->
    <div v-if="block.type === 'image'" class="flex-1 flex justify-center bg-gray-100 p-4 rounded-xl">
      <img :src="imageUrl" class="max-w-full max-h-100 rounded-lg object-contain" />
    </div>

    <!-- 操作按钮 -->
    <div class="flex flex-col gap-1 bg-white p-1 rounded-lg shadow-md opacity-0 group-hover:opacity-100 transition-opacity">
      <button
        type="button"
        class="action-btn"
        :disabled="isFirst"
        title="上移"
        @click="$emit('move-up')"
      >
        <el-icon><ArrowUp /></el-icon>
      </button>
      <button
        type="button"
        class="action-btn"
        :disabled="isLast"
        title="下移"
        @click="$emit('move-down')"
      >
        <el-icon><ArrowDown /></el-icon>
      </button>
      <button
        type="button"
        class="action-btn delete"
        title="删除"
        @click="$emit('remove')"
      >
        <el-icon><Delete /></el-icon>
      </button>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { ArrowUp, ArrowDown, Delete } from '@element-plus/icons-vue'
import type { ContentBlock } from '@/types/publish'
import { buildImageUrl } from '@/utils/format'

interface Props {
  block: ContentBlock
  index: number
  total: number
  fileHost: string
}

interface Emits {
  (e: 'update:block', block: ContentBlock): void
  (e: 'move-up'): void
  (e: 'move-down'): void
  (e: 'remove'): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const isFirst = computed(() => props.index === 0)
const isLast = computed(() => props.index === props.total - 1)

const localValue = computed({
  get: () => props.block.value,
  set: (val) => emit('update:block', { ...props.block, value: val })
})

const imageUrl = computed(() => {
  return buildImageUrl(props.block.value, props.fileHost)
})
</script>

<style scoped>
.content-textarea :deep(.el-textarea__inner) {
  background-color: #f5f5f7;
  box-shadow: none;
  border: 1px solid #e5e5e7;
  border-radius: 12px;
  padding: 16px;
  font-size: 16px;
  color: #1d1d1f;
  transition: all 0.2s ease;
  font-family: inherit;
}

.content-textarea :deep(.el-textarea__inner:focus) {
  background-color: white;
  box-shadow: 0 0 0 2px #000000 inset;
}

.action-btn {
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
}

.action-btn:hover {
  border-color: #1d1d1f;
  background: #f5f5f7;
  color: #1d1d1f;
}

.action-btn.delete:hover {
  background: #fff1f1;
  color: #ff3b30;
  border-color: #ff3b30;
}

.action-btn:disabled {
  opacity: 0.3;
  cursor: not-allowed;
}
</style>
