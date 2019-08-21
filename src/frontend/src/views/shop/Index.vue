<template>
  <v-container fluid pb-4>
    <v-layout>
      <!-- Left section => Category list / Advanced search... -->
      <v-flex xs2>
        <h3>Categories</h3>
        <ul>
          <li>
            <a href="#">Children</a>
          </li>
          <li>
            <a href="#">Science</a>
          </li>
          <li>
            <a href="#">Programming</a>
          </li>
          <li>
            <a href="#">Thriller</a>
          </li>
          <li>
            <a href="#">Business Management</a>
          </li>
          <li>
            <a href="#">Religious</a>
          </li>
          <li>
            <a href="#">Romance</a>
          </li>
        </ul>
        <p style="font-size: 0.8rem; margin-top: 15px; margin-right: 10px">
          <i>TODO: Styling this left-section later. Also add more advanced search/filter options if possible.</i>
        </p>
      </v-flex>

      <!-- Right section => Display list of books -->
      <v-flex xs10>



        <h2>Best Sellers</h2>
        <v-container fluid grid-list-md pt-3 px-0 pb-4>
          <v-layout wrap>
            <v-flex xs3 v-for="book in books" :key="book.id">
              <v-hover v-slot:default="{ hover }">
                <v-card
                  :elevation="hover ? 24 : 2"
                  ripple
                  @click.native.stop="bookClicked(book)"
                  style="cursor: pointer"
                >
                  <v-img :aspect-ratio="16/9" height="250" :src="book.thumbnails[0]" />
                  <v-card-title class="pb-0">{{ book.title }}</v-card-title>
                  <v-card-text class="pb-0">
                    <span>{{ book.author }}</span>

                    <v-layout class="mt-0 pt-0" align-center>
                      <div class="my-3 subtitle-1 black--text">{{ book.price | toLocaleString }} VND</div>
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

                  <v-divider class="mx-3"></v-divider>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn
                      color="#0078D9"
                      light
                      text
                      @click.native.prevent.stop="addToCart(book)"
                      ripple
                    >
                      <v-icon small>mdi-cart-outline</v-icon>&nbsp;Add to cart
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-hover>
            </v-flex>
          </v-layout>
        </v-container>

        <!-- Example of a category -->
        <v-divider class="mt-5 mb-3"></v-divider>
        <h2>Children</h2>
        <v-container fluid grid-list-md pt-3 px-0 pb-4>
          <v-layout wrap>
            <v-flex xs3 v-for="book in books" :key="book.id">
              <v-hover v-slot:default="{ hover }">
                <v-card
                  :elevation="hover ? 24 : 2"
                  ripple
                  @click.native.stop="bookClicked(book)"
                  style="cursor: pointer"
                >
                  <v-img :aspect-ratio="16/9" height="250" :src="book.thumbnails[0]" />
                  <v-card-title class="pb-0">{{ book.title }}</v-card-title>
                  <v-card-text class="pb-0">
                    <span>{{ book.author }}</span>

                    <v-layout class="mt-0 pt-0" align-center>
                      <div class="my-3 subtitle-1 black--text">{{ book.price | toLocaleString }} VND</div>
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

                  <v-divider class="mx-3"></v-divider>
                  <v-card-actions>
                    <v-spacer></v-spacer>
                    <v-btn
                      color="#0078D9"
                      light
                      text
                      @click.native.prevent.stop="addToCart(book)"
                      ripple
                    >
                      <v-icon small>mdi-cart-outline</v-icon>&nbsp;Add to cart
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-hover>
            </v-flex>
          </v-layout>
        </v-container>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { eventBus } from "../../event";
import { axiosConfig } from "../../utils";

export default {
  name: "index",
  data() {
    return {
      books: [],

    };
  },
  mounted() {
    this.$http
        .get("/api/v1/books", axiosConfig)
        .then(resp => {
          console.log(resp);
          this.books = resp.data;
        })
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
    }
  }
};
</script>

// scoped mean the CSS defined here only has the affect to DOM inside this component ONLY.
// E.g.: h2 in other components/pages will not be affected by the CSS below.
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
