import Vue from 'vue'
import App from './App.vue' // root
import router from './router' // Router
import store from './store' // Store
import vuetify from './plugins/vuetify';

Vue.config.productionTip = false

new Vue({
  router,
  store,
  vuetify,
  render: h => h(App)
}).$mount('#app')// id="app"
