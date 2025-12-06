<template>
  <div class="bg-white p-6 rounded-xl shadow-sm mb-6">
    <el-form :inline="false" :model="modelValue">
      <!-- 状态选择 -->
      <el-form-item label="状态" class="mb-5 status-form-item">
        <el-radio-group
          :model-value="modelValue.status"
          class="flex gap-2 status-radio-group"
          @change="handleStatusChange"
        >
          <el-radio-button :label="null">全部状态</el-radio-button>
          <el-radio-button :label="0">草稿</el-radio-button>
          <el-radio-button :label="1">已提交</el-radio-button>
          <el-radio-button :label="2">审核失败</el-radio-button>
          <el-radio-button :label="3">审核通过</el-radio-button>
          <el-radio-button :label="9">已发布</el-radio-button>
        </el-radio-group>
      </el-form-item>

      <!-- 其他筛选条件 -->
      <div class="flex items-center gap-4 flex-wrap">
        <el-form-item label="关键字" class="mb-0 filter-item">
          <el-input
            :model-value="modelValue.keyword"
            placeholder="搜索标题"
            clearable
            class="w-50"
            @update:model-value="handleFieldChange('keyword', $event)"
          />
        </el-form-item>

        <el-form-item label="频道" class="mb-0 filter-item">
          <el-select
            :model-value="modelValue.channelId"
            placeholder="全部频道"
            clearable
            filterable
            class="w-45"
            @change="handleFieldChange('channelId', $event)"
          >
            <el-option
              v-for="channel in channels"
              :key="channel.id"
              :label="channel.name"
              :value="channel.id"
            />
          </el-select>
        </el-form-item>

        <el-form-item label="日期" class="mb-0 filter-item">
          <el-date-picker
            :model-value="modelValue.beginPubDate"
            type="datetime"
            placeholder="开始时间"
            value-format="YYYY-MM-DDTHH:mm:ss"
            class="w-50"
            @update:model-value="handleFieldChange('beginPubDate', $event)"
          />
          <span class="mx-2 text-gray-400">-</span>
          <el-date-picker
            :model-value="modelValue.endPubDate"
            type="datetime"
            placeholder="结束时间"
            value-format="YYYY-MM-DDTHH:mm:ss"
            class="w-50"
            @update:model-value="handleFieldChange('endPubDate', $event)"
          />
        </el-form-item>
      </div>
    </el-form>
  </div>
</template>

<script setup lang="ts">
import type { NewsQueryParams, ChannelOption } from '@/types/news'

interface Props {
  modelValue: NewsQueryParams
  channels: ChannelOption[]
}

interface Emits {
  (e: 'update:modelValue', value: NewsQueryParams): void
  (e: 'search'): void
}

const props = defineProps<Props>()
const emit = defineEmits<Emits>()

const handleStatusChange = (value: number | null) => {
  // 直接修改 modelValue 的属性，因为它是 reactive 对象
  ;(props.modelValue as any).status = value ?? undefined
  emit('search')
}

const handleFieldChange = (field: keyof NewsQueryParams, value: any) => {
  // 直接修改 modelValue 的属性
  ;(props.modelValue as any)[field] = value
  emit('search')
}
</script>

<style scoped>
.status-form-item :deep(.el-form-item__label) {
  font-weight: 500;
  color: #1d1d1f;
  width: 60px;
}

.filter-item :deep(.el-form-item__label) {
  font-weight: 500;
  color: #1d1d1f;
  width: auto;
  margin-right: 8px;
}

.status-radio-group :deep(.el-radio-button__inner) {
  padding: 8px 20px;
  border-radius: 6px;
  border: 1px solid #e5e5e7;
  background-color: #f5f5f7;
  color: #1d1d1f;
  transition: all 0.2s ease;
}

.status-radio-group :deep(.el-radio-button:first-child .el-radio-button__inner),
.status-radio-group :deep(.el-radio-button:last-child .el-radio-button__inner) {
  border-radius: 6px;
}

.status-radio-group :deep(.el-radio-button__original-radio:checked + .el-radio-button__inner) {
  background-color: #000000;
  border-color: #000000;
  color: white;
  box-shadow: none;
}

.status-radio-group :deep(.el-radio-button__inner:hover) {
  background-color: #e5e5e7;
}
</style>
