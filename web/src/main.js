import Vue from 'vue'
import Buefy from 'buefy'
import VueRouter from 'vue-router'
import App from './App.vue'
import LoginPage from './pages/login.vue'
import Connector from './pages/connector.vue'
import ResetPassword from './pages/resetPassword.vue'

Vue.use(Buefy)
Vue.use(VueRouter)
Vue.config.productionTip = false

const routes = [
  { path: '/', component: LoginPage },
  { path: '/feed/:connector', component: Connector, props: (route) => ({connector: route.params.connector, query: route.query}) },
  { path: '/reset/:token', component: ResetPassword, props: true }
]

const router = new VueRouter({ routes, mode: 'history' })

new Vue({
  router,
  render: h => h(App),
}).$mount('#app')
