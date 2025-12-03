<template>
  <div class="flex h-screen bg-[#f5f5f7]">
    <!-- Sidebar -->
    <aside class="w-64 bg-white border-r border-gray-200 flex flex-col">
      <div class="h-16 flex items-center px-6 border-b border-gray-100">
        <span class="text-xl font-bold tracking-tight">Media Platform</span>
      </div>
      
      <nav class="flex-1 p-4 space-y-1">
        <router-link 
          to="/material" 
          class="flex items-center px-4 py-3 text-gray-600 rounded-xl hover:bg-gray-50 hover:text-black transition-colors"
          active-class="bg-gray-100 text-black font-medium"
        >
          <div class="i-carbon-image w-5 h-5 mr-3"></div>
          Materials
        </router-link>
      </nav>
      
      <div class="p-4 border-t border-gray-100">
        <button @click="handleLogout" class="flex items-center px-4 py-3 text-gray-600 rounded-xl hover:bg-gray-50 hover:text-red-600 w-full transition-colors">
          <div class="i-carbon-logout w-5 h-5 mr-3"></div>
          Sign out
        </button>
      </div>
    </aside>

    <!-- Main Content -->
    <main class="flex-1 overflow-auto">
      <div class="p-8">
        <router-view />
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()

const handleLogout = () => {
  userStore.logout()
  router.push('/login')
}
</script>
