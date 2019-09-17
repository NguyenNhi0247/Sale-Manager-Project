import Vue from "vue"

export const eventBus = new Vue({
    methods: {
        bookAddedToCart(book) {
            this.$emit('addBookToCart', book)
        },
        bookRemovedFromCart(book) {
            this.$emit('removeBookFromCart', book)
        },
        snackbarShown(data) {
            this.$emit('showSnackbar', data)
        },
        loginModalShown() {
            this.$emit('showLoginModal')
        },
        userLoggedIn() {
            this.$emit('loginUser')
        },
        logoutModalShown() {
            this.$emit('showLogoutModal')
        },
        userLoggedOut() {
            this.$emit('logoutUser')
        },
        bookEditModalShown(data) {
            this.$emit('showBookEditModal', data)
        },
        bookUpdated(id) {
            this.$emit('updateBook', id)
        },
        orderConfirmModalShown(order) {
            this.$emit('showOrderConfirmModal', order)
        },
    }
})

