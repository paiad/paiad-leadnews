import { ref, watch } from 'vue'

/**
 * 标签输入 Composable
 */
export function useTagInput() {
  const tags = ref<string[]>([])
  const tagInput = ref('')
  const tagInputRef = ref<HTMLInputElement>()

  /**
   * 确认输入标签
   */
  const confirmTag = () => {
    if (tagInput.value) {
      const newTags = tagInput.value
        .split(/[,，]/)
        .map(t => t.trim())
        .filter(t => t)
      
      newTags.forEach(tag => {
        if (tag && !tags.value.includes(tag)) {
          tags.value.push(tag)
        }
      })
      tagInput.value = ''
    }
  }

  /**
   * 删除标签
   */
  const removeTag = (tag: string) => {
    tags.value = tags.value.filter(t => t !== tag)
  }

  /**
   * 处理退格键
   */
  const handleBackspace = () => {
    if (!tagInput.value && tags.value.length > 0) {
      tags.value.pop()
    }
  }

  /**
   * 聚焦输入框
   */
  const focusInput = () => {
    tagInputRef.value?.focus()
  }

  /**
   * 设置标签列表
   */
  const setTags = (newTags: string[]) => {
    tags.value = newTags
  }

  /**
   * 获取标签字符串
   */
  const getLabelsString = () => {
    return tags.value.join(',')
  }

  /**
   * 从字符串解析标签
   */
  const parseFromString = (labelsStr: string) => {
    tags.value = labelsStr ? labelsStr.split(',').filter(t => t) : []
  }

  return {
    tags,
    tagInput,
    tagInputRef,
    confirmTag,
    removeTag,
    handleBackspace,
    focusInput,
    setTags,
    getLabelsString,
    parseFromString
  }
}
