<template>
  <el-dialog
    v-model="visible"
    title="选择素材"
    width="800px"
    class="material-dialog"
    :show-close="false"
  >
    <template #header="{ titleId, titleClass }">
      <div class="flex justify-between items-center mb-5 text-lg font-semibold">
        <span :id="titleId" :class="titleClass">选择素材</span>
        <button type="button" class="bg-transparent border-none text-xl cursor-pointer text-gray-400 hover:text-gray-900" @click="closeDialog">
          <el-icon><Close /></el-icon>
        </button>
      </div>
    </template>

    <!-- 素材网格 -->
    <div class="grid grid-cols-4 gap-4 max-h-100 overflow-y-auto p-1">
      <div
        v-for="item in materials"
        :key="item.id"
        class="aspect-square cursor-pointer rounded-xl overflow-hidden relative group"
        @click="selectMaterial(item.url)"
      >
        <img :src="getImageUrl(item.url)" class="w-full h-full object-cover transition-transform group-hover:scale-105" alt="material" />
        <div class="absolute inset-0 bg-black/40 flex items-center justify-center opacity-0 group-hover:opacity-100 transition-opacity">
          <el-icon class="text-white text-3xl"><Check /></el-icon>
        </div>
      </div>
    </div>

    <!-- 分页 -->
    <div class="mt-6 flex justify-center">
      <el-pagination
        layout="prev, pager, next"
        :total="total"
        background
        small
        @current-change="$emit('page-change', $event)"
      />
    </div>
  </el-dialog>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Close, Check } from '@element-plus/icons-vue'
import type { MaterialItem } from '@/types/publish'
import { buildImageUrl } from '@/utils/format'

interface Props {
  modelValue: boolean
  materials: MaterialItem[]
  total: number
  fileHost: string
}

interface Emits {
  (e: 'update:modelValue', visible: boolean): void
  (e: 'select', url: string): void
  (e: 'page-change', page: number): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const visible = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
})

const getImageUrl = (url: string) => {
  return buildImageUrl(url, props.fileHost)
}

const closeDialog = () => {
  emit('update:modelValue', false)
}

const selectMaterial = (url: string) => {
  emit('select', url)
  closeDialog()
}
</script>

<style scoped>
:deep(.el-pagination.is-background .el-pager li:not(.is-disabled).is-active) {
  background-color: #1d1d1f;
}
</style>
