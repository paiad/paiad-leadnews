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
  console.error(err)
  alert('Runtime Error: ' + err)
}

window.onerror = (msg, _source, _lineno, _colno, _error) => {
  alert('Global Error: ' + msg)
}

app.use(createPinia())
app.use(router)
app.use(ElementPlus)

app.mount('#app')
