<template>
  <div class="page-container">
    <div class="page-header">
      <h1 class="page-title">频道管理</h1>
      <div class="header-actions">
        <el-button type="primary" class="action-button" @click="handleAdd">
          <el-icon><Plus /></el-icon>
          <span style="padding-left: 3px;">新增频道</span>
        </el-button>
      </div>
    </div>

    <div class="content-area" v-loading="loading">
      <el-table :data="channelList" style="width: 100%" class="custom-table">
        <el-table-column prop="id" label="ID" width="80" />
        <el-table-column prop="name" label="频道名称" min-width="180" />
        <el-table-column prop="description" label="描述" min-width="300" show-overflow-tooltip />
        <el-table-column label="创建时间" width="180">
          <template #default="{ row }">
            {{ formatDate(row.createdTime) }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="150" fixed="right">
          <template #default="{ row }">
            <el-button link type="primary" @click="handleEdit(row)">编辑</el-button>
            <el-button link type="danger" @click="handleDelete(row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div v-if="channelList.length === 0 && !loading" class="empty-state">
        <el-icon class="empty-icon"><List /></el-icon>
        <p>暂无频道数据</p>
      </div>
    </div>



    <!-- 新增/编辑弹窗 -->
    <el-dialog
      v-model="dialogVisible"
      :title="isEdit ? '编辑频道' : '新增频道'"
      width="500px"
      :close-on-click-modal="false"
      class="custom-dialog"
    >
      <el-form
        ref="formRef"
        :model="formData"
        :rules="formRules"
        label-width="80px"
        class="channel-form"
      >
        <el-form-item label="频道名称" prop="name">
          <el-input v-model="formData.name" placeholder="请输入频道名称" maxlength="20" />
        </el-form-item>
        <el-form-item label="描述" prop="description">
          <el-input
            v-model="formData.description"
            type="textarea"
            :rows="3"
            placeholder="请输入频道描述"
            maxlength="200"
          />
        </el-form-item>
      </el-form>
      <template #footer>
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="handleSubmit" :loading="submitting">
          确定
        </el-button>
      </template>
    </el-dialog>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from 'vue'
import { getChannelList, saveChannel, updateChannel, deleteChannel, type WmChannel } from '@/api/channel'
import { ElMessage, ElMessageBox, type FormInstance, type FormRules } from 'element-plus'
import { Plus, List } from '@element-plus/icons-vue'

const loading = ref(false)
const channelList = ref<WmChannel[]>([])
const total = ref(0)

const queryParams = reactive({
  page: 1,
  size: 1000,
  name: ''
})

// 弹窗相关
const dialogVisible = ref(false)
const isEdit = ref(false)
const submitting = ref(false)
const formRef = ref<FormInstance>()

const formData = reactive<WmChannel>({
  id: undefined,
  name: '',
  description: ''
})

const formRules: FormRules = {
  name: [
    { required: true, message: '请输入频道名称', trigger: 'blur' },
    { min: 1, max: 20, message: '长度在 1 到 20 个字符', trigger: 'blur' }
  ]
}

const formatDate = (dateStr: string) => {
  if (!dateStr) return ''
  return new Date(dateStr).toLocaleString('zh-CN')
}

const loadChannels = async () => {
  if (loading.value) return
  loading.value = true

  try {
    const res = await getChannelList({
      page: queryParams.page,
      size: queryParams.size,
      name: queryParams.name || undefined
    })

    if (res.code === 200) {
      // 按照ID升序排列（从小到大）
      const channels = res.data || []
      channelList.value = channels.sort((a: WmChannel, b: WmChannel) => {
        const idA = a.id ?? 0
        const idB = b.id ?? 0
        return idA - idB
      })
      total.value = (res as any).total || 0
    } else {
      ElMessage.error(res.errorMessage || '加载失败')
    }
  } catch (error) {
    console.error(error)
    ElMessage.error('加载频道列表失败')
  } finally {
    loading.value = false
  }
}



const resetForm = () => {
  formData.id = undefined
  formData.name = ''
  formData.description = ''
}

const handleAdd = () => {
  isEdit.value = false
  resetForm()
  dialogVisible.value = true
}

const handleEdit = (row: WmChannel) => {
  isEdit.value = true
  formData.id = row.id
  formData.name = row.name
  formData.description = row.description || ''
  dialogVisible.value = true
}

const handleSubmit = async () => {
  if (!formRef.value) return
  
  try {
    await formRef.value.validate()
  } catch {
    return
  }

  submitting.value = true
  try {
    const res = isEdit.value
      ? await updateChannel({ ...formData })
      : await saveChannel({ ...formData })

    if (res.code === 200) {
      ElMessage.success(isEdit.value ? '修改成功' : '新增成功')
      dialogVisible.value = false
      loadChannels()
    } else {
      ElMessage.error(res.errorMessage || '操作失败')
    }
  } catch (error) {
    ElMessage.error('操作失败')
  } finally {
    submitting.value = false
  }
}

const handleDelete = async (row: WmChannel) => {
  try {
    await ElMessageBox.confirm(
      `确定要删除频道「${row.name}」吗？`,
      '删除确认',
      {
        confirmButtonText: '确定删除',
        cancelButtonText: '取消',
        type: 'warning'
      }
    )

    const res = await deleteChannel(row.id!)
    if (res.code === 200) {
      ElMessage.success('删除成功')
      loadChannels()
    } else {
      ElMessage.error(res.errorMessage || '删除失败')
    }
  } catch (error: any) {
    if (error !== 'cancel') {
      ElMessage.error('删除失败')
    }
  }
}

onMounted(() => {
  loadChannels()
})
</script>

<style scoped lang="scss">
.page-container {
  max-width: 1200px;
  margin: 0 auto;
}

.page-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 24px;

  .page-title {
    font-size: 24px;
    font-weight: 600;
    color: #1d1d1f;
    margin: 0;
  }

  .action-button {
    background-color: #000000;
    border: none;
    border-radius: 16px;
    padding: 8px 16px;
    font-weight: 555;
    display: flex;
    align-items: center;
    gap: 6px;

    &:hover {
      background-color: #333333;
    }
  }
}

.content-area {
  background: white;
  border-radius: 16px;
  padding: 20px;
  min-height: 400px;
}

.custom-table {
  :deep(.el-table__header th) {
    background-color: #f5f5f7;
    color: #1d1d1f;
    font-weight: 600;
  }

  :deep(.el-table__row) {
    &:hover > td {
      background-color: #fafafa;
    }
  }
}

.empty-state {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 300px;
  color: #86868b;

  .empty-icon {
    font-size: 48px;
    margin-bottom: 16px;
    opacity: 0.5;
  }
}



.custom-dialog {
  :deep(.el-dialog__header) {
    padding: 20px 24px;
    border-bottom: 1px solid #e5e5e7;
  }

  :deep(.el-dialog__body) {
    padding: 24px;
  }

  :deep(.el-dialog__footer) {
    padding: 16px 24px;
    border-top: 1px solid #e5e5e7;
  }
}

.channel-form {
  :deep(.el-form-item__label) {
    font-weight: 500;
  }
}
</style>
