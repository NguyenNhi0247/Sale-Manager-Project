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
          <v-rating
            color="yellow"
            readonly
            half-increments
            :value="book.total_rating_point/book.total_rated"
          ></v-rating>
          <span>{{ book.total_rating_point / book.total_rated }} ({{ book.total_rated }})</span>
        </div>
        <h3 class="pricing">{{ book.price | toLocaleString }} ₫</h3>

        <div class="quantity-toggle">
          <v-btn @click="decrement()">&mdash;</v-btn>
          <input style="width: 30px;padding-left: 10px;" type="text" :value="quantity" readonly />
          <v-btn @click="increment()">&#xff0b;</v-btn>
        </div>
        <v-btn depressed large color="error">
          <v-icon left>mdi-cart</v-icon>Buy
        </v-btn>

        <v-alert type="warning" class="mt-5" width="450px">
          Please select the shipping address.
          <a href="#">Type Address</a>
        </v-alert>
      </v-flex>
    </v-layout>

    <v-divider class="mt-5 mb-5"></v-divider>

    <v-layout wrap>
      <v-flex xs12>
        <h2>Details</h2>

        <v-simple-table>
          <tbody>
            <tr>
              <td>Pulisher</td>
              <td>{{ book.publisher }}</td>
            </tr>
            <tr>
              <td>Authors</td>
              <td>{{ book.authors[0] }}</td>
            </tr>
            <tr>
              <td>Pagination</td>
              <td>{{ book.pagination }}</td>
            </tr>
            <tr>
              <td>Published At</td>
              <td>{{ book.published_at }}</td>
            </tr>
            <tr>
              <td>Published Place</td>
              <td>{{ book.published_place }}</td>
            </tr>
          </tbody>
        </v-simple-table>
      </v-flex>

      <v-flex xs12>
        <h2>Introduction</h2>
        <p>{{ book.description }}</p>
        <p>{{ book.long_description }}</p>
      </v-flex>

      <v-divider class="mt-10 mb-10"></v-divider>

      <v-flex xs4>
        <h2>Preview</h2>

        <h4>Average Review</h4>

        <h1 color="error">{{ book.total_rating_point }}/{{ book.total_rated }}</h1>
        <v-rating
          color="yellow"
          readonly
          half-increments
          :value="book.total_rating_point/book.total_rated"
        ></v-rating>
        <p>{{ book.total_rated }} (comment)</p>
      </v-flex>

      <v-flex xs4 class="mt-15">
        <p class="mb-0">
          5
          <v-icon left color="yellow">mdi-star</v-icon>
          <vm-progress :percentage="0">0%</vm-progress>
        </p>
        <p class="mb-0">
          4
          <v-icon left color="yellow">mdi-star</v-icon>
          <vm-progress :percentage="70">70%</vm-progress>
        </p>
        <p class="mb-0">
          3
          <v-icon left color="yellow">mdi-star</v-icon>
          <vm-progress :percentage="30">30%</vm-progress>
        </p>
        <p class="mb-0">
          2
          <v-icon left color="yellow">mdi-star</v-icon>
          <vm-progress :percentage="30">30%</vm-progress>
        </p>
        <p class="mb-0">
          1
          <v-icon left color="yellow">mdi-star</v-icon>
          <vm-progress :percentage="20">20%</vm-progress>
        </p>
      </v-flex>

      <v-flex xs4 class="mt-15">
        <h4>Share your preview</h4>
        <v-btn depressed color="yellow" center>
          <v-icon left>mdi-pencil</v-icon>Write your preview
        </v-btn>
      </v-flex>

      <v-divider class="mt-5 mb-5"></v-divider>

      <v-flex xs4>
        <v-avatar slot="offset" class="mx-auto d-block" size="130">
          <img src="https://demos.creative-tim.com/vue-material-dashboard/img/marc.aba54d65.jpg" />
          <p>nhi</p>
        </v-avatar>
      </v-flex>

      <v-flex xs8>
        <v-rating color="yellow" readonly half-increments value="4"></v-rating>
        <div class="grey--text pl-2">abc</div>
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
      },
      quantity: 1
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
    },
    increment() {
      this.quantity++;
    },
    decrement() {
      if (this.quantity === 1) {
        alert("Quantity not allowed");
      } else {
        this.quantity--;
      }
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
  color: red;
}
.p-preview {
  margin-bottom: 0px;
  font-size: 10px;
}
</style>
