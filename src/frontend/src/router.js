import Vue from 'vue'
import Router from 'vue-router'
import Base from './views/shop/Base.vue'
import Index from './views/shop/Index.vue'
import Product from './views/shop/Product.vue'
import Checkout from './views/shop/Checkout.vue'
import Payment from './views/shop/Payment.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      component: Base,
      children: [
        { name: "index", path: "/", component: Index },
        { name: "product", path: "/product/:id", component: Product },
        { name: "checkout", path: "/checkout", component: Checkout },
        { name: "payment", path: "/payment", component: Payment },
      ]
    },
    {
      path: '/admin',
      name: 'admin',
      // route level code-splitting
      // this generates a separate chunk (about.[hash].js) for this route
      // which is lazy-loaded when the route is visited.
      component: () => import(/* webpackChunkName: "admin" */ './views/admin/Admin.vue')
    }
  ]
})
