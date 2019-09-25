import Vue from 'vue'
import Router from 'vue-router'
import Base from './views/shop/Base.vue'
import Index from './views/shop/Index.vue'

import AdminBase from './views/admin/Base.vue'

Vue.use(Router)

export default new Router({
    routes: [{
            path: '/',
            component: Base,
            children: [
                { name: "index", path: "/", component: Index },
                { name: "product", path: "/product/:id", component: () =>
                        import ('./views/shop/Product.vue') },
                { name: "category", path: "/category/:name", component: () =>
                        import ('./views/shop/Category.vue') },
                { name: "reading", path: "/read/:id", component: () =>
                        import ('./views/shop/Reading.vue') },
                { name: "checkout", path: "/checkout", component: () =>
                        import ('./views/shop/Checkout.vue') },
                { name: "user", path: "/user/:username", component: () =>
                        import ('./views/shop/User.vue') },
            ]
        },
        {
            path: '/admin',
            component: AdminBase,
            children: [
                { name: "dashboard", path: "/", component: () =>
                        import ('./views/admin/Dashboard.vue') },
                { name: "userManagement", path: "users", component: () =>
                        import ('./views/admin/User.vue') },
                { name: "bookManagement", path: "books", component: () =>
                        import ('./views/admin/Book.vue') },
                { name: "bookArchived", path: "books/archived", component: () =>
                        import ('./views/admin/BookArchived.vue') },
                { name: "adminSettings", path: "settings", component: () =>
                        import ('./views/admin/Settings.vue') },
                { name: "adminHelp", path: "help", component: () =>
                        import ('./views/admin/Help.vue') },
            ]
        }
    ]
})
