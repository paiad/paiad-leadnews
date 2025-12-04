import { ref } from 'vue'
import { getMaterialList } from '@/api/material'
import type { MaterialItem, MaterialSelectMode } from '@/types/publish'

/**
 * 素材选择 Composable
 */
export function useMaterialPicker() {
  const dialogVisible = ref(false)
  const materials = ref<MaterialItem[]>([])
  const materialTotal = ref(0)
  const fileHost = ref('')
  const selectMode = ref<MaterialSelectMode>('cover')
  const currentCoverIndex = ref(0)

  /**
   * 加载素材列表
   */
  const loadMaterials = async (page = 1) => {
    try {
      const res = await getMaterialList({ page, size: 20, isCollection: 0 })
      
      if (res.code === 200) {
        if (res.host) {
          fileHost.value = res.host
        }
        
        if (res.data) {
          if (res.data.rows && Array.isArray(res.data.rows)) {
            materials.value = res.data.rows
            materialTotal.value = res.data.total || 0
          } else if (Array.isArray(res.data)) {
            materials.value = res.data
            materialTotal.value = res.data.length
          } else {
            materials.value = []
            materialTotal.value = 0
          }
        } else {
          materials.value = []
          materialTotal.value = 0
        }
      } else {
        materials.value = []
        materialTotal.value = 0
      }
    } catch (error) {
      console.error('[useMaterialPicker] loadMaterials error:', error)
      materials.value = []
      materialTotal.value = 0
    }
  }

  /**
   * 打开选择封面图片对话框
   */
  const openForCover = (index: number) => {
    selectMode.value = 'cover'
    currentCoverIndex.value = index
    dialogVisible.value = true
    loadMaterials()
  }

  /**
   * 打开选择正文图片对话框
   */
  const openForContent = () => {
    selectMode.value = 'content'
    dialogVisible.value = true
    loadMaterials()
  }

  /**
   * 关闭对话框
   */
  const closeDialog = () => {
    dialogVisible.value = false
  }

  /**
   * 设置文件主机地址
   */
  const setFileHost = (host: string) => {
    fileHost.value = host
  }

  return {
    dialogVisible,
    materials,
    materialTotal,
    fileHost,
    selectMode,
    currentCoverIndex,
    loadMaterials,
    openForCover,
    openForContent,
    closeDialog,
    setFileHost
  }
}
