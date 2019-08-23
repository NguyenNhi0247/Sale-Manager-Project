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
            :value="book.total_rating_point / book.total_rated"
            color="amber"
            half-increments
            dense
            size="12"
            readonly
          ></v-rating>
          <div
            class="grey--text pl-2"
          >{{ book.total_rating_point / book.total_rated }} ({{ book.total_rated }})</div>
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
        <v-btn color="#0078D9" light text @click.native.prevent.stop="addToCart(book)" ripple>
          <v-icon small>mdi-cart-outline</v-icon>&nbsp;Add to cart
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-hover>
</template>

<script>
export default {
  name: "book-card",
  props: {
    book: {}
  },
  methods: {
    bookClicked(book) {
      this.$router.push({ path: `/product/${book.id}` });
    },
    addToCart(book) {
      eventBus.bookAddedToCart(book);
    },
    categoryClicked(category) {
      alert(category.name + " clicked");
      // TODO
    },
    getDefaultThumbnail(thumbnails) {
      return thumbnails && thumbnails.length > 0
        ? thumbnails[0]
        : "https://salt.tikicdn.com/cache/w1200/ts/product/60/5f/0c/1322d346b88a6940b8c93d105dec840d.jpg";
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
