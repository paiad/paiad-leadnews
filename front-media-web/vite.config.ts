import { fileURLToPath, URL } from 'node:url'
import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import UnoCSS from 'unocss/vite'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [vue(), UnoCSS()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    proxy: {
      '/wemedia/MEDIA': {
        target: 'http://localhost:51803',
        changeOrigin: true,
        rewrite: (path) => path.replace(/^\/wemedia\/MEDIA/, '')
      }
    }
  }
})
