import Vue from "vue"

export const eventBus = new Vue({
    methods: {
        bookAddedToCart(book) {
            this.$emit('addBookToCart', book)
        },
        snackbarShown(data) {
            this.$emit('showSnackbar', data)
        },
        userLoggedIn() {
            this.$emit('loginUser')
        }
    }
})
 
