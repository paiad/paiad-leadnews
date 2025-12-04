<template>
  <div
    class="min-h-12 flex flex-wrap gap-2 px-3 py-2 bg-gray-100 rounded-xl border border-transparent transition-all focus-within:bg-white focus-within:border-black focus-within:shadow-sm w-full cursor-text items-center"
    @click="focusInput"
  >
    <!-- 标签列表 -->
    <div
      v-for="(tag, index) in modelValue"
      :key="index"
      class="bg-white border border-gray-200 px-2.5 py-1 rounded-md text-sm text-gray-900 flex items-center gap-1.5 shadow-sm"
    >
      <span>{{ tag }}</span>
      <el-icon
        class="cursor-pointer text-gray-400 hover:text-gray-900 transition-colors text-xs"
        @click.stop="removeTag(tag)"
      >
        <Close />
      </el-icon>
    </div>

    <!-- 输入框 -->
    <input
      ref="inputRef"
      v-model="inputValue"
      class="bg-transparent border-none outline-none flex-1 min-w-20 h-full text-sm text-gray-900 placeholder:text-gray-400"
      placeholder="输入标签..."
      @keydown.enter.prevent="confirmInput"
      @keydown.backspace="handleBackspace"
    />
  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue'
import { Close } from '@element-plus/icons-vue'

interface Props {
  modelValue: string[]
}

interface Emits {
  (e: 'update:modelValue', tags: string[]): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const inputRef = ref<HTMLInputElement>()
const inputValue = ref('')

const focusInput = () => {
  inputRef.value?.focus()
}

const confirmInput = () => {
  if (inputValue.value) {
    const newTags = inputValue.value
      .split(/[,，]/)
      .map(t => t.trim())
      .filter(t => t && !props.modelValue.includes(t))

    if (newTags.length > 0) {
      emit('update:modelValue', [...props.modelValue, ...newTags])
    }
    inputValue.value = ''
  }
}

const removeTag = (tag: string) => {
  emit('update:modelValue', props.modelValue.filter(t => t !== tag))
}

const handleBackspace = () => {
  if (!inputValue.value && props.modelValue.length > 0) {
    emit('update:modelValue', props.modelValue.slice(0, -1))
  }
}
</script>
