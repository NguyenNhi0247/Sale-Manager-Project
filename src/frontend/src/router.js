import Vue from 'vue'
import Router from 'vue-router'
import Base from './views/shop/Base.vue'
import Index from './views/shop/Index.vue'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      component: Base,
      children: [
        { name: "index", path: "/", component: Index },
        { name: "product", path: "/product/:id", component: () => import('./views/shop/Product.vue') },
        { name: "reading", path: "/read/:id", component: () => import('./views/shop/Reading.vue')  },
        { name: "checkout", path: "/checkout", component: () => import('./views/shop/Checkout.vue') },
        { name: "payment", path: "/payment", component: () => import('./views/shop/Payment.vue')  },
        { name: "user", path: "/user/:username", component: () => import('./views/shop/User.vue')  },
        { name: "api", path: "/apis", component: () => import('./views/shop/API.vue')  },
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
