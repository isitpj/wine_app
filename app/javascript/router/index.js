import Vue from 'vue'
import Router from 'vue-router'
import App from '../components/App'
Vue.use(Router)

const router = new Router ({
  routes: [
    {
      path: '/',
      name: 'HelloWorld',
      component: 'app'
    }
  ]
})

export default router
