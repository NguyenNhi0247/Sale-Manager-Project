import Vue from "vue"

export const eventBus = new Vue({
    methods: {
        bookAddedToCart(book) {
            this.$emit('addBookToCart', book)
        }
    }
})
 
