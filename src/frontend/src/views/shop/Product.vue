<template>
  <v-container fluid>
    <v-breadcrumbs class="pt-1" :items="breadcrumbItems" large></v-breadcrumbs>

    <!-- Book image, title, pricing... -->
    <v-container v-if="book && book.id" fluid class="pa-0 ma-0">
      <v-layout wrap class="pb-6 pt-5">
        <v-flex offset-2 xs4>
          <v-img height="400" contain :src="book.thumbnails[0]" />
        </v-flex>

        <v-flex xs4>
          <p class="display-1">{{ book.title }}</p>
          <p v-if="book.sub_title" class="b-title py-0 mt-n2 mb-1">{{ book.sub_title }}</p>
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
            Author
            <span v-if="book.authors.length > 1">s</span>:
            <span style="color: #304FFE">{{ book.authors.join(", ") }}</span>
          </p>

          <v-divider></v-divider>

          <p class="title red-highlight py-4">{{ book.price | toLocaleString }} ₫</p>

          <v-layout align-left class="pa-0 ma-0 mt-n3">
            <v-flex>
              <v-text-field
                class="quantity-input"
                v-model="quantity"
                small
                prepend-icon="mdi-minus"
                append-outer-icon="mdi-plus"
                :value="quantity"
                outlined
                @click:append-outer="increment"
                @click:prepend="decrement"
                :rules="[quantityRules.required, quantityRules.isNumeric, quantityRules.valueRange]"
              />
            </v-flex>
            <v-flex class="ma-0 pa-0 ml-n2">
              <v-btn class="mt-1" depressed large dark color="red" @click="addBookToCart">
                <v-icon left>mdi-cart</v-icon>Buy
              </v-btn>
            </v-flex>
            <v-flex class="ma-0 pa-0 ml-n3">
              <v-btn
                class="mt-1"
                depressed
                large
                dark
                outlined
                color="blue accent-4"
                @click="previewBook"
              >
                <v-icon left>mdi-eye-check-outline</v-icon>Preview
              </v-btn>
            </v-flex>
            <v-spacer></v-spacer>
          </v-layout>
        </v-flex>
      </v-layout>

      <!-- Book information -->
      <v-layout wrap class="mt-6 pt-6 px-5">
        <v-flex xs12 md8>
          <p class="title">Information</p>

          <v-simple-table>
            <tbody>
              <tr>
                <td>Pulisher</td>
                <td>{{ book.publisher }}</td>
              </tr>
              <tr>
                <td>Authors</td>
                <td>{{ book.authors.join(", ") }}</td>
              </tr>
              <tr>
                <td>Categories</td>
                <td>{{ book.categories.join(", ") }}</td>
              </tr>
              <tr>
                <td>Ebook formats</td>
                <td>{{ book.ebook_formats | toEbookFormatsList }}</td>
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
      </v-layout>

      <!-- Book introduction -->
      <v-layout wrap class="mt-6 pt-6 px-5">
        <v-flex xs12 md8>
          <p class="title">Introduction</p>
          <p class="body-2" style="white-space: pre-wrap;">{{ book.description }}</p>
          <p class="body-2" style="white-space: pre-wrap;">{{ book.long_description }}</p>
        </v-flex>
      </v-layout>

      <!-- Review, others -->
      <v-layout wrap class="mt-6 pt-6 px-5">
        <v-flex xs12 md8>
          <p class="title">Reviews</p>
          <h3>// TODO: WIP</h3>
        </v-flex>
      </v-layout>
    </v-container>

    <v-container v-else>No book data</v-container>
  </v-container>
</template>


<script>
import Vue from "vue";
import { axiosConfig } from "../../utils";
import { mapGetters, mapMutations } from "vuex";
import { eventBus } from "../../event";

export default {
  data() {
    return {
      id: 0,
      book: null,
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
  computed: {
    ...mapGetters(["authUser"]),
    isAuth() {
      return this.authUser && this.authUser.id && true;
    }
  },
  mounted() {
    this.id = this.$route.params.id;
    this.loadBook()
  },
  methods: {
    ...mapMutations(["addToCart"]),
    loadBook() {
      this.$http
        .get(`/api/v1/books/${this.id}`, axiosConfig)
        .then(resp => {
          console.log("BOOK DETAILS", resp.data);
          this.book = resp.data;
        })
        .catch(err => {
          this.showError(err, "Cannot get book details.");
        });
    },
    addBookToCart() {
      if (!this.isAuth) {
        eventBus.loginModalShown();
        return;
      }

      let jsBook = {
        book_id: this.book.id,
        price: this.book.price,
        quantity: this.quantity
      };
      this.$http
        .post(
          "/api/v1/carts/insert-book",
          JSON.stringify(jsBook),
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("BOOK ADDED TO CART", resp.data);
          // Save book to global vuex store
          this.addToCart(jsBook);
          // Notify other components that a new book was added to cart,
          // so it can update/re-render if needed
          eventBus.bookAddedToCart(jsBook);
        })
        .catch(err => {
          this.showError(err, "Cannot add book to cart");
        });
      // TODO
    },
    previewBook() {
      this.$router.push({ path: `/read/${this.book.id}` });
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
    },
    toEbookFormatsList(v) {
      let s = "";
      for (let f of v) {
        // s += f.type + " (" + f.file_path + "), ";
        s += f.type + ", ";
      }
      return s.replace(/, $/, "");
    }
  }
};
</script>

<style scoped>
.red-highlight {
  color: #ff3425;
}

.b-title {
  font-size: 1.2rem;
  font-weight: 300;
  color: #777;
}
</style>

<style>
/* .v-text-field--outlined fieldset,.v-input__slot fieldset {
  height: 40px !important;
} */

.quantity-input {
  max-width: 120px;
}

.quantity-input,
.quantity-input fieldset {
  height: 40px !important;
}

.quantity-input .v-input__slot {
  margin-top: 10px;
}

.quantity-input .v-text-field__slot input {
  padding-top: 0;
  padding-bottom: 16px;
}
</style>
