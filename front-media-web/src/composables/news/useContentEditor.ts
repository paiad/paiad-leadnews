import { ref } from 'vue'
import type { ContentBlock } from '@/types/publish'

/**
 * 内容块编辑器 Composable
 */
export function useContentEditor() {
  const blocks = ref<ContentBlock[]>([])

  /**
   * 添加文本块
   */
  const addTextBlock = () => {
    blocks.value.push({ type: 'text', value: '' })
  }

  /**
   * 添加图片块
   */
  const addImageBlock = (url: string) => {
    blocks.value.push({ type: 'image', value: url })
  }

  /**
   * 删除块
   */
  const removeBlock = (index: number) => {
    blocks.value.splice(index, 1)
  }

  /**
   * 上移块
   */
  const moveBlockUp = (index: number) => {
    if (index > 0) {
      const current = blocks.value[index]
      const prev = blocks.value[index - 1]
      if (current && prev) {
        blocks.value[index] = prev
        blocks.value[index - 1] = current
      }
    }
  }

  /**
   * 下移块
   */
  const moveBlockDown = (index: number) => {
    if (index < blocks.value.length - 1) {
      const current = blocks.value[index]
      const next = blocks.value[index + 1]
      if (current && next) {
        blocks.value[index] = next
        blocks.value[index + 1] = current
      }
    }
  }

  /**
   * 设置块列表
   */
  const setBlocks = (newBlocks: ContentBlock[]) => {
    blocks.value = newBlocks
  }

  /**
   * 初始化默认文本块
   */
  const initDefaultBlock = () => {
    blocks.value = [{ type: 'text', value: '' }]
  }

  return {
    blocks,
    addTextBlock,
    addImageBlock,
    removeBlock,
    moveBlockUp,
    moveBlockDown,
    setBlocks,
    initDefaultBlock
  }
}
