<template>
  <div v-loading="loading" class="bg-white rounded-xl shadow-sm overflow-hidden pb-5">
    <el-table
      ref="tableRef"
      :data="data"
      class="w-full"
      :header-cell-style="{ background: '#f5f5f7', color: '#86868b', fontWeight: '500' }"
      @selection-change="$emit('selection-change', $event)"
    >
      <!-- 选择列 - 仅编辑模式显示 -->
      <el-table-column v-if="isEditMode" type="selection" width="55" />

      <!-- 标题列 -->
      <el-table-column label="标题" min-width="300">
        <template #header>
          <div :class="isEditMode ? '' : 'pl-4'">标题</div>
        </template>
        <template #default="{ row }">
          <NewsTitleCell :news="row" :file-host="fileHost" />
        </template>
      </el-table-column>

      <!-- 状态列 -->
      <el-table-column label="状态" width="120">
        <template #header>
          <div class="pl-4">状态</div>
        </template>
        <template #default="{ row }">
          <el-tag :type="getStatusType(row.status)" effect="plain" round>
            {{ getStatusLabel(row.status) }}
          </el-tag>
        </template>
      </el-table-column>

      <!-- 发布时间列 -->
      <el-table-column label="发布时间" width="180">
        <template #header>
          <div class="pl-4">发布时间</div>
        </template>
        <template #default="{ row }">
          {{ formatDate(row.publishTime) }}
        </template>
      </el-table-column>

      <!-- 操作列 -->
      <el-table-column width="150" fixed="right">
        <template #header>
          <div class="text-right pr-17.5">
            <el-button
              v-if="!isEditMode"
              type="default"
              size="small"
              class="manage-btn"
              @click="$emit('toggle-edit-mode')"
            >
              管理
            </el-button>
            <el-button
              v-else
              type="primary"
              size="small"
              class="done-btn"
              @click="$emit('toggle-edit-mode')"
            >
              完成
            </el-button>
          </div>
        </template>
        <template #default="{ row }">
          <el-button
            link
            type="primary"
            size="small"
            class="text-blue-600 font-medium hover:text-blue-800"
            @click="$emit('edit', row.id)"
          >
            编辑
          </el-button>
          <el-button
            link
            type="danger"
            size="small"
            class="text-red-500 font-medium ml-2 hover:text-red-700"
            @click="$emit('delete', row)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 分页 -->
    <div class="flex justify-end px-6 pt-5">
      <el-pagination
        v-model:current-page="currentPage"
        v-model:page-size="currentPageSize"
        :page-sizes="[10, 20, 50]"
        :total="total"
        layout="sizes, prev, next"
        background
        small
        @size-change="handleSizeChange"
        @current-change="handlePageChange"
      />
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import type { NewsItem } from '@/types/news'
import { getStatusLabel, getStatusType, formatDate } from '@/utils/format'
import NewsTitleCell from './NewsTitleCell.vue'

interface Props {
  data: NewsItem[]
  loading: boolean
  total: number
  page: number
  pageSize: number
  isEditMode: boolean
  fileHost: string
}

interface Emits {
  (e: 'edit', id: number): void
  (e: 'delete', row: NewsItem): void
  (e: 'selection-change', selection: NewsItem[]): void
  (e: 'page-change', page: number): void
  (e: 'size-change', size: number): void
  (e: 'toggle-edit-mode'): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

// 使用 computed 实现双向绑定
const currentPage = computed({
  get: () => props.page,
  set: (val) => emit('page-change', val)
})

const currentPageSize = computed({
  get: () => props.pageSize,
  set: (val) => emit('size-change', val)
})

const handlePageChange = (val: number) => {
  emit('page-change', val)
}

const handleSizeChange = (val: number) => {
  emit('size-change', val)
}

// 暴露 tableRef 供父组件使用
const tableRef = defineModel<any>('tableRef')
defineExpose({ tableRef })
</script>

<style scoped>
.manage-btn {
  border-radius: 6px;
  font-weight: 500;
  border-color: #e5e5e7;
  background-color: #ffffff;
}

.manage-btn:hover {
  border-color: #000000;
  color: #000000;
}

.done-btn {
  border-radius: 6px;
  font-weight: 500;
  background-color: #000000;
  border-color: #000000;
  color: #ffffff;
}

.done-btn:hover {
  background-color: #333333;
  border-color: #333333;
}
</style>
