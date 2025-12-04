<template>
  <transition name="slide-up">
    <div
      v-if="visible"
      class="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 shadow-lg px-6 py-4 flex justify-between items-center z-100"
    >
      <div class="flex items-center gap-4">
        <span class="text-sm text-gray-900 font-medium">已选择 {{ count }} 项</span>
        <el-button link class="text-gray-400 text-sm hover:text-blue-500" @click="$emit('clear')">
          取消选择
        </el-button>
      </div>
      <el-button type="danger" class="rounded-lg font-medium flex items-center gap-1.5" @click="$emit('delete')">
        <el-icon><Delete /></el-icon>
        批量删除
      </el-button>
    </div>
  </transition>
</template>

<script setup lang="ts">
import { Delete } from '@element-plus/icons-vue'

interface Props {
  visible: boolean
  count: number
}

interface Emits {
  (e: 'clear'): void
  (e: 'delete'): void
}

defineProps<Props>()
defineEmits<Emits>()
</script>

<style scoped>
.slide-up-enter-active,
.slide-up-leave-active {
  transition: all 0.3s ease;
}

.slide-up-enter-from,
.slide-up-leave-to {
  transform: translateY(100%);
  opacity: 0;
}
</style>
