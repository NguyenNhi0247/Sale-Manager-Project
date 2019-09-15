import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    cart: [],
    authUser: null,
    showHeader: true,
    showFooter: true,
  },
  getters: {
    cart(state) {
      return state.cart
    },
    cartItemIDs(state) {
      let ids = []
      for (const item of state.cart) {
        ids.push(item.book_id)
      }
      return ids
    },
    cartItemQuantity(state) {
      let quantity = 0
      for (let i = 0; i < state.cart.length; i++) {
        if (!state.cart[i].quantity) {
          state.cart[i].quantity = 1
        }
        quantity += state.cart[i].quantity
      }
      return quantity
    },
    authUser: (state) => {
      return state.authUser
    },
    showHeader: (state) => {
      return state.showHeader
    },
    showFooter: (state) => {
      return state.showFooter
    },
  },
  mutations: {
    addToCart(state, newItem) {
      if (!newItem) {
        return
      }
      if (!newItem.quantity) {
        newItem.quantity = 1
      }

      for (let i = 0; i < state.cart.length; i++) {
        if (newItem.book_id === state.cart[i].book_id) {
          Vue.set(state.cart[i], "quantity", state.cart[i].quantity + 1) // Trigger Vuex reactive
          return
        }
      }
      // Add new item to cart
      state.cart.push(newItem)
    },
    removeFromCart(state, removedItem) {
      for (let i = 0; i < state.cart.length; i++) {
        if (state.cart[i].book_id === removedItem.book_id) {
          Vue.delete(state.cart, i)
          return
        }
      }
    },
    cleanUpCart(state) {
      state.cart = []
    },
    setAuthUser(state, user) {
      state.authUser = user
    },
    setShowHeader(state, v) {
      state.showHeader = v
    },
    setShowFooter(state, v) {
      state.showFooter = v
    },
  }
})
