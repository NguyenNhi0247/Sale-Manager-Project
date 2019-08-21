<template>
  <v-container fluid>
    <v-layout wrap>
      <v-flex xs4>
        <v-img height="250" :src="book.thumbnails[0]" />
      </v-flex>

      <v-flex xs8>
        <h2>{{ book.title }}</h2>
        <p>Author: {{ book.authors[0] }}</p>
        <div>
          <v-rating color="yellow" readonly half-increments :value="book.total_rating_point/book.total_rated"></v-rating>
          <span>{{ book.total_rating_point / book.total_rated }} ({{ book.total_rated }})</span>
        </div>
        <h3 class="pricing">{{ book.price | toLocaleString }} VND</h3>

        <v-btn text large class="mr-3">Preview</v-btn>
        <v-btn depressed large color="error">
          <v-icon left>mdi-cart</v-icon> Buy
        </v-btn>
      </v-flex>
    </v-layout>

    <v-divider class="mt-5 mb-5"></v-divider>

    <v-layout wrap>
      <v-flex xs12>
        <h2>Details</h2>
        <table>
          <tr>
            <td>Pulisher</td>
            <td>{{ book.publisher }}</td>
          </tr>
          <tr>
            <td>Pagination</td>
            <td>{{ book.pagination }}</td>
          </tr>
          <tr>
            <td>Published Place</td>
            <td>{{ book.published_place }}</td>
          </tr>
        </table>
      </v-flex>

      <v-flex xs12>
        <h2>Introduction</h2>
        <p>{{ book.description }}</p>
        <p>{{ book.long_description }}</p>
      </v-flex>
    </v-layout>
  </v-container>
</template>


<script>
import { axiosConfig } from "../../utils";

export default {
  data() {
    return {
      book: {
        thumbnails: [],
        authors: []
      }
    };
  },
  mounted() {
    this.id = this.$route.params.id;
    this.$http
      .get(`/api/v1/books/${this.id}`, axiosConfig)
      .then(resp => {
        console.log(resp.data);
        this.book = resp.data;
      })
      .catch(err => {
        console.log(err);
      });
  },
  methods: {
    addToCart(book) {
      alert(book.title + " added to cart...");
      // TODO
    }
  },
  filters: {
    // Convert v to its location form, return v itself if it's not a number.
    // E.g.: 50000 => 50,000
    toLocaleString(v) {
      if (isNaN(v)) {
        return v;
      }
      return v.toLocaleString();
    }
  }
};
</script>

<style scoped>
h2 {
  color: blue;
  font-weight: 300;
  font-size: 2rem;
}

.v-card--reveal {
  align-items: center;
  bottom: 0;
  justify-content: center;
  opacity: 0.75;
  position: absolute;
  width: 100%;
}

.pricing {
  color: red
}
</style>
