<template>
  <v-container fill-height fluid grid-list-xl>
    <v-layout justify-center wrap>
      <v-flex xs6 md6 v-for="book_details in books_details" :key="book_details.id">
        <material-card color="green" title="Product Detail">
          <v-cart slot="offset" class="mx-auto d-block" size="200">
            <v-img :aspect-ratio="16/9" height="250" :src="book_details.thumbnail" />
          </v-cart>
        </material-card>
      </v-flex>
      <v-flex xs6 md6 v-for="book_details in books_details" :key="book_details.id">
        <material-card class="v-card-profile">
          <v-card-text class="text-xs-center">
            <h1 class="my-3 card-title font-weight-light">{{ book_details.title }}</h1>
            <h4 class="category text-gray font-weight-thin mb-6" si>{{ book_details.authors }}</h4>
            <p class="card-description font-weight-light">{{ book_details.description }}</p>
            <v-layout class="mt-0 pt-0 pl-3" align-center>
              <div class="my-3 subtitle-1 black--text">{{ book_details.price | toLocaleString }} VND</div>
              <v-spacer></v-spacer>
              <v-rating :value="book_details.total_rating_point / book_details.total_rated" color="amber" half-increments dense
                size="12" readonly></v-rating>
              <div class="grey--text pl-2 pr-5">{{ book_details.total_rating_point / book_details.total_rated }}
                ({{ book_details.total_rated }})</div>
            </v-layout>
            <v-card-actions>
              <v-spacer></v-spacer>
              <v-btn color="primary" round class="font-weight-light"  @click.native.prevent.stop="addToCart(book_details)" ripple>
                <v-icon small>mdi-cart-outline</v-icon><b>&nbsp;Add to cart</b>
              </v-btn>
            </v-card-actions>
          </v-card-text>
        </material-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>


<script>

import { axiosConfig } from "../../utils";

export default {
  data() {
    return {
      books_details:{
        
      }
    }
  },
  mounted() {
    this.id = this.$route.params.id
    this.$http
        .post(`/api/v1/get-book-details?id=${this.id}`,axiosConfig)
        .then(resp => {
          console.log(resp.data)
          this.books_details = resp.data;
        })
        .catch(err => {
          console.log(err);
        });
        
  },
  methods: {
    addToCart(book_details) {
        alert(book_details.title + " added to cart...");
        // TODO
      },

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
    },
};
</script>

<style scoped>
  h2 {
    color: #0078d9;
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
</style>
