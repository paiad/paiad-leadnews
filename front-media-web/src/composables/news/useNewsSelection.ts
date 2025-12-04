import { ref, type Ref } from 'vue'
import type { NewsItem } from '@/types/news'

/**
 * 新闻选择状态管理 Composable
 */
export function useNewsSelection(tableRef: Ref<any>) {
  // 编辑模式状态
  const isEditMode = ref(false)
  // 已选中的ID列表
  const selectedIds = ref<number[]>([])

  /**
   * 进入编辑模式
   */
  const enterEditMode = () => {
    isEditMode.value = true
  }

  /**
   * 退出编辑模式
   */
  const exitEditMode = () => {
    isEditMode.value = false
    clearSelection()
  }

  /**
   * 切换编辑模式
   */
  const toggleEditMode = () => {
    if (isEditMode.value) {
      exitEditMode()
    } else {
      enterEditMode()
    }
  }

  /**
   * 清空选择
   */
  const clearSelection = () => {
    selectedIds.value = []
    tableRef.value?.clearSelection()
  }

  /**
   * 处理选择变化
   */
  const handleSelectionChange = (selection: NewsItem[]) => {
    selectedIds.value = selection.map(item => item.id)
  }

  return {
    isEditMode,
    selectedIds,
    enterEditMode,
    exitEditMode,
    toggleEditMode,
    clearSelection,
    handleSelectionChange
  }
}
