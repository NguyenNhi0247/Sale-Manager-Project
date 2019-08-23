<template>
  <v-container fluid>
    <v-breadcrumbs class="pt-1" :items="breadcrumbItems" large></v-breadcrumbs>

    <v-layout wrap>
      <v-flex offset-2 xs4>
        <v-img height="400" contain :src="book.thumbnails[0]" />
      </v-flex>

      <v-flex xs4>
        <p class="display-1">{{ book.title }}</p>
        <p v-if="book.sub_title" class="subtitle-1 py-0 mt-n2 mb-1">{{ book.sub_title }}</p>
        <v-layout
          v-if="book.total_rating_point && book.total_rated"
          row
          wrap
          align-center
          class="pa-0"
        >
          <v-rating
            class="pl-2"
            color="yellow"
            readonly
            dense
            small
            half-increments
            :value="book.total_rating_point/book.total_rated"
          ></v-rating>
          <span
            class="pt-1 pl-2"
          >{{ getRatingPoint(book.total_rating_point, book.total_rated) }} ({{ book.total_rated }})</span>
        </v-layout>
        <p class="pt-2 pb-0 mb-2 body-2">
          Author<span v-if="book.authors.length > 1">s</span>:
          <span style="color: #304FFE">{{ book.authors.join(", ") }}</span>
        </p>

        <v-divider></v-divider>

        <p class="title red-highlight py-4">{{ book.price | toLocaleString }} ₫</p>

        <v-layout align-left class="pa-0 ma-0 mt-n3">
          <v-flex>
            <v-text-field
              v-model="quantity"
              small
              prepend-icon="mdi-minus"
              append-outer-icon="mdi-plus"
              style="max-width: 120px"
              :value="quantity"
              outlined
              @click:append-outer="increment"
              @click:prepend="decrement"
              :rules="[quantityRules.required, quantityRules.isNumeric, quantityRules.valueRange]"
            />
          </v-flex>
          <v-flex class="ma-0 pa-0 ml-n2">
            <v-btn class="mt-1" depressed large dark color="red">
              <v-icon left>mdi-cart</v-icon>Buy
            </v-btn>
          </v-flex>
          <v-flex class="ma-0 pa-0 ml-n3">
            <v-btn class="mt-1" depressed large dark outlined color="blue accent-4">
              <v-icon left>mdi-eye-check-outline</v-icon>Preview
            </v-btn>
          </v-flex>
          <v-spacer></v-spacer>
        </v-layout>

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

      <!-- <v-flex xs4 class="mt-15">
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
      </v-flex>-->

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

      <!-- <v-flex xs8>
        <v-rating color="yellow" readonly half-increments value="4"></v-rating>
        <div class="grey--text pl-2">abc</div>
      </v-flex>-->
    </v-layout>
  </v-container>
</template>


<script>
import Vue from "vue";
import { axiosConfig } from "../../utils";

export default {
  data() {
    return {
      book: {
        thumbnails: [],
        authors: []
      },
      quantity: 1,
      breadcrumbItems: [
        {
          text: "Home",
          to: "/"
        },
        {
          text: "Books",
          to: "/books"
        },
        {
          text: "",
          disabled: true,
          to: "#"
        }
      ],
      quantityRules: {
        required: value => !!value || "Required.",
        isNumeric: value => !isNaN(value) || "Number only",
        valueRange: value =>
          (parseInt(value) >= 1 && parseInt(value) <= 100) || "1-100"
      }
    };
  },
  watch: {
    book(value) {
      let title =
        value && value.title ? value.title : "Book is your best friend";
      Vue.set(this.breadcrumbItems[2], "text", title);
    }
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
      if (this.quantity == 100) {
        return;
      }
      this.quantity++;
    },
    decrement() {
      if (this.quantity === 1) {
        return;
      }
      this.quantity--;
    },
    getRatingPoint(totalRatingPoint, totalRatedTime) {
      if (totalRatedTime === 0) {
        return 0;
      }
      return parseFloat((totalRatingPoint / totalRatedTime).toFixed(1));
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
.red-highlight {
  color: #ff3425;
}

.v-input__control {
  min-height: 30px !important;
}
</style>
