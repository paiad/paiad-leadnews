<template>
  <div
    class="tag-input-container"
    @click="focusInput"
  >
    <!-- 标签列表 -->
    <div
      v-for="(tag, index) in modelValue"
      :key="index"
      class="tag-item"
    >
      <span>{{ tag }}</span>
      <el-icon
        class="tag-close"
        @click.stop="removeTag(tag)"
      >
        <Close />
      </el-icon>
    </div>

    <!-- 输入框 -->
    <input
      ref="inputRef"
      v-model="inputValue"
      class="tag-input"
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

<style scoped>
.tag-input-container {
  display: flex;
  flex-wrap: nowrap;
  align-items: center;
  gap: 6px;
  height: 40px;
  padding: 0 12px;
  background-color: #f5f5f7;
  border: 1px solid #d1d1d6;
  border-radius: 10px;
  cursor: text;
  transition: all 0.2s ease;
  width: 100%;
  box-sizing: border-box;
  overflow: hidden;
}

.tag-input-container:focus-within {
  background-color: white;
  border-color: #1d1d1f;
}

.tag-item {
  display: inline-flex;
  align-items: center;
  gap: 4px;
  height: 26px;
  padding: 0 10px;
  background-color: #e8e8ed;
  border-radius: 13px;
  font-size: 13px;
  color: #1d1d1f;
  white-space: nowrap;
  flex-shrink: 0;
}

.tag-close {
  cursor: pointer;
  color: #86868b;
  font-size: 11px;
  transition: color 0.15s;
  margin-left: 2px;
}

.tag-close:hover {
  color: #ff3b30;
}

.tag-input {
  flex: 1;
  min-width: 80px;
  height: 100%;
  border: none;
  outline: none;
  background: transparent;
  font-size: 14px;
  color: #1d1d1f;
}

.tag-input::placeholder {
  color: #86868b;
}
</style>

