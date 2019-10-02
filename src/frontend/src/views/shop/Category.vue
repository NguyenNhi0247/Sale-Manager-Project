<template>
  <v-container >
    <v-layout>
      <v-flex >

        <h2 class="text-center mt-10">{{ name }} Books</h2>
        <v-container fluid grid-list-md pt-3 px-0 pb-4>
          <v-layout row align-end v-if="resultBook.length > 0">
            <v-flex d-flex xs3 v-for="book in resultBook" :key="book.id">
              <book-card :book="book"></book-card>
            </v-flex>
          </v-layout>
        </v-container>

      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import BookCard from "../../components/shop/BookCard";

export default {
  name: "children",
  components: {
    "book-card": BookCard
  },
  data() {
    return {
      name: "",
      resultBook: []
    };
  },

  mounted() {
    this.name = this.$route.params.name;    
    this.$http
        .get(`/api/v1/books/category/${this.name}`, this.getAuthHeader)
        .then(resp => {
            this.resultBook = resp.data;
        })
  }
};

</script>
<style scoped>
h2 {
  color: #0078d9;
  font-weight: 300;
  font-size: 1.8rem;
}
</style>
