import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    cart: []
  },
  getters: {
    getCart(state) {
      return state.cart
    },
    getCartItemIDs(state) {
      let ids = []
      for (const item of state.cart) {
        ids.push(item.id)
      }
      return ids
    },
    getCartItemQuantity(state) {
      let quantity = 0
      for (let i = 0; i < state.cart.length; i++) {
        if (!state.cart[i].quantity) {
          state.cart[i].quantity = 1
        }
        quantity += state.cart[i].quantity
      }
      return quantity
    }
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
        if (newItem.id === state.cart[i].id) {
          Vue.set(state.cart[i], "quantity", state.cart[i].quantity+1) // Trigger Vuex reactive
          return
        }
      }
      // Add new item to cart
      state.cart.push(newItem)
    },
    removeFromCart(state, removedItem) {
      for (let i = 0; i < state.cart.length; i++) {
        if (state.cart[i].id === removedItem.id) {
          Vue.delete(state.cart, i)
          return
        }
      }
    }
  }
})
