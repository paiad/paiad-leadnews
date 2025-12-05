import { createApp } from 'vue'
import { createPinia } from 'pinia'
import App from './App.vue'
import router from './router'
import ElementPlus from 'element-plus'
import 'element-plus/dist/index.css'
import 'virtual:uno.css'


import './style.css'

const app = createApp(App)

app.config.errorHandler = (err) => {
  // 忽略 ResizeObserver 警告，这是浏览器的正常行为
  if (err instanceof Error && err.message.includes('ResizeObserver')) {
    return
  }
  console.error(err)
}

window.onerror = (msg, _source, _lineno, _colno, _error) => {
  // 忽略 ResizeObserver 警告
  if (typeof msg === 'string' && msg.includes('ResizeObserver')) {
    return true
  }
  console.error('Global Error:', msg)
  return false
}

app.use(createPinia())
app.use(router)
app.use(ElementPlus)

app.mount('#app')
