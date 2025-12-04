<template>
  <div class="flex items-center gap-5">
    <el-image
      :src="coverUrl"
      class="w-20 h-15 rounded-md shrink-0 bg-gray-100"
      fit="cover"
    >
      <template #error>
        <div class="w-full h-full flex items-center justify-center bg-gray-100 text-gray-300 text-2xl">
          <el-icon><Picture /></el-icon>
        </div>
      </template>
    </el-image>
    <span class="flex-1 text-sm text-gray-900 leading-relaxed line-clamp-2 break-words">
      {{ news.title }}
    </span>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { Picture } from '@element-plus/icons-vue'
import type { NewsItem } from '@/types/news'
import { buildImageUrl, DEFAULT_COVER_IMAGE } from '@/utils/format'

interface Props {
  news: NewsItem
  fileHost: string
}

const props = defineProps<Props>()

const coverUrl = computed(() => {
  if (props.news.images) {
    const firstImage = props.news.images.split(',')[0] || ''
    return buildImageUrl(firstImage, props.fileHost)
  }
  return DEFAULT_COVER_IMAGE
})
</script>

<style scoped>
.line-clamp-2 {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>
