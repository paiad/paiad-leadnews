import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      redirect: '/layout/home'
    },
    {
      path: '/login',
      name: 'login',
      component: () => import('@/views/Login.vue')
    },
    {
      path: '/layout',
      name: 'layout',
      component: () => import('@/views/Layout.vue'),
      children: [
        {
          path: 'home',
          name: 'home',
          component: () => import('@/views/Home.vue')
        },
        {
          path: 'material',
          name: 'material',
          component: () => import('@/views/material/index.vue')
        },
        {
          path: 'channel',
          name: 'channel',
          component: () => import('@/views/channel/index.vue')
        },
        {
          path: 'news/index',
          name: 'news-list',
          component: () => import('@/views/news/index.vue')
        },
        {
          path: 'news/publish',
          name: 'news-publish',
          component: () => import('@/views/publish/index.vue')
        },
        {
          path: 'news/edit',
          name: 'news-edit',
          component: () => import('@/views/publish/index.vue')
        },
        {
          path: 'links',
          name: 'links',
          component: () => import('@/views/links/index.vue')
        }
      ]
    }
  ]
})

export default router
