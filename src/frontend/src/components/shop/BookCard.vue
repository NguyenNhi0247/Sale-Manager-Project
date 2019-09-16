<template>
  <v-hover v-slot:default="{ hover }">
    <v-card
      :elevation="hover ? 24 : 2"
      ripple
      @click.native.stop="bookClicked(book)"
      style="cursor: pointer; width: 100% !important"
    >
      <v-img contain height="250" :src="getDefaultThumbnail(book.thumbnails)" />
      <v-card-title class="pb-0 book-card-title">{{ book.title }}</v-card-title>
      <v-card-text class="pb-0">
        <span>{{ book.authors[0] }}</span>

        <v-layout class="mt-0 pt-0" align-center>
          <div class="my-3 subtitle-2 black--text">{{ book.price | toLocaleString }} ₫</div>
          <v-spacer></v-spacer>
          <v-rating
            :value="getRatingPoint(book.total_rating_point, book.total_rated)"
            color="amber"
            half-increments
            dense
            size="12"
            readonly
          ></v-rating>
          <div
            class="grey--text pl-2 pt-1"
          >{{ getRatingPoint(book.total_rating_point, book.total_rated) }} ({{ book.total_rated }})</div>
        </v-layout>
        <!-- <div>{{ book.description }}</div> -->
        <!-- Categories -->
        <!-- <v-chip
                          class="mr-1"
                          link
                          :href="category.url"
                          small
                          ripple
                          v-for="(category, idx) in book.categories"
                          :key="idx"
        >{{ category.name }}</v-chip>-->
      </v-card-text>

      <v-divider class="mx-3 mt-1"></v-divider>
      <v-card-actions>
        <v-spacer></v-spacer>
        <v-btn
          v-if="isPurchased"
          color="green accent-4"
          light
          text
          @click.native.prevent.stop="readBook(book)"
          ripple
        >
          <v-icon small>mdi-eye-check-outline</v-icon>&nbsp;Read it
        </v-btn>
        <div v-else>
          <v-btn
            v-if="!isAlreadyInCart"
            color="blue accent-4"
            light
            text
            @click.native.prevent.stop="addBookToCart(book)"
            ripple
          >
            <v-icon small>mdi-cart-plus</v-icon>&nbsp;Add to cart
          </v-btn>
          <v-btn
            v-else
            color="orange accent-4"
            light
            text
            @click.native.prevent.stop="removeBookFromCart(book)"
          >
            <v-icon small>mdi-cart-remove</v-icon>&nbsp;Remove From Cart
          </v-btn>
        </div>
      </v-card-actions>
    </v-card>
  </v-hover>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";
import { eventBus } from "../../event";

export default {
  name: "book-card",
  props: {
    book: {},
    isPurchased: {
      type: Boolean
    }
  },
  data() {
    return {
      isAlreadyInCart: false
    };
  },
  computed: {
    ...mapGetters(["cartItemIDs", "authUser"]),
    isAuth() {
      return this.authUser && this.authUser.id && true;
    }
  },
  watch: {
    cartItemIDs(ids) {
      // TODO: This func only triggered once at start up
      this.checkItemAlreadyInCart(ids);
    }
  },
  methods: {
    ...mapMutations(["addToCart", "removeFromCart"]),
    bookClicked(book) {
      this.$router.push({ path: `/product/${book.id}` });
    },
    readBook(book) {
      this.$router.push({ path: `/read/${book.id}` });
    },
    addBookToCart(book) {
      if (!this.isAuth) {
        eventBus.loginModalShown();
        return;
      }

      let jsBook = { book_id: book.id, price: book.price, quantity: 1 };
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
    },
    removeBookFromCart(book) {
      if (!this.isAuth) {
        eventBus.loginModalShown();
        return;
      }

      let jsBook = { book_id: book.id, price: book.price, quantity: 1 };
      this.$http
        .delete(`/api/v1/carts/books/${book.id}`, this.getAuthHeader())
        .then(resp => {
          console.log("BOOK REMOVED FROM CART", resp.data);
          this.removeFromCart(jsBook); // Save book to global vuex store
          eventBus.bookRemovedFromCart(jsBook);
        })
        .catch(err => {
          this.showError(err, "Cannot remove book from cart");
        });
    },
    checkItemAlreadyInCart(ids) {
      if (!ids) {
        return;
      }
      for (let i = 0; i < ids.length; i++) {
        if (this.book.id == ids[i]) {
          this.isAlreadyInCart = true;
          return;
        }
      }
      this.isAlreadyInCart = false;
    },
    categoryClicked(category) {
      alert(category.name + " clicked");
      // TODO
    },
    getDefaultThumbnail(thumbnails) {
      return thumbnails && thumbnails.length > 0
        ? thumbnails[0]
        : "https://salt.tikicdn.com/cache/w1200/ts/product/60/5f/0c/1322d346b88a6940b8c93d105dec840d.jpg";
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
  },
  mounted() {
    if (this.cartItemIDs) {
      this.checkItemAlreadyInCart(this.cartItemIDs);
    }
  }
};
</script>

<style>
.v-card--reveal {
  align-items: center;
  bottom: 0;
  justify-content: center;
  opacity: 0.75;
  position: absolute;
  width: 100%;
}

.book-card-title {
  font-size: 1.2rem;
  line-height: 1.4rem;
}
</style>
