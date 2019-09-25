<template>
  <v-container fluid pb-4>
    <v-layout>
      <!-- Left section => Category list / Advanced search... -->
      <v-flex xs2 >
        <v-card
        class="mr-3"
        >
          <!-- <v-toolbar
            color="indigo accent-4"
            dark
            dense
            class="elevation-1"
          >
            <v-toolbar-title class="subtitle-1">Categories</v-toolbar-title>
          </v-toolbar> -->
          <v-list dense>
            <v-subheader>CATEGORIES</v-subheader>
            <template>
              <v-list-item href="/#/category/Children">Children</v-list-item>
              <v-list-item href="/#/category/Science">Science</v-list-item>
              <v-list-item href="/#/category/Love">Love</v-list-item>
              <v-list-item href="/#/category/Vietnam">VietNam</v-list-item>
              <v-list-item href="/#/category/Art">Art</v-list-item>
            </template>
          </v-list>
        </v-card>
      </v-flex>

      <!-- Right section => Display list of books -->
      <v-flex xs10>
        <!-- Promotion banners -->
        <v-carousel cycle continuos height="350" hide-delimiter-background show-arrows-on-hover>
          <v-carousel-item
            v-for="(item, i) in banners"
            :key="i"
            :src="item.img"
            :to="item.url"
            reverse-transition="fade-transition"
            transition="fade-transition"
          ></v-carousel-item>
        </v-carousel>

        <h2 class="mt-5 pt-3">New Books</h2>
        <v-container fluid grid-list-md pt-3 px-0 pb-4>
          <v-layout row wrap justify-space-between align-end v-if="newBooks.length > 0">
            <v-flex d-flex xs3 v-for="book in newBooks" :key="book.id">
              <book-card :book="book"></book-card>
            </v-flex>
          </v-layout>
        </v-container>

        <h2 class="mt-5 pt-3">Best Sellers</h2>
        <v-container fluid grid-list-md pt-3 px-0 pb-4>
          <v-layout row wrap justify-space-between align-end v-if="bestSellers.length > 0">
            <v-flex d-flex xs3 v-for="book in bestSellers" :key="book.id">
              <book-card :book="book"></book-card>
            </v-flex>
          </v-layout>
        </v-container>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { axiosConfig } from "../../utils";
import { eventBus } from "../../event";
import { mapGetters } from "vuex";

import BookCard from "../../components/shop/BookCard";

export default {
  name: "index",
  components: {
    "book-card": BookCard
  },
  data() {
    return {
      banners: [
        {
          img:
            "https://salt.tikicdn.com/cache/w885/ts/banner/01/71/a9/6ac55f6662bd04bbd4ff8ab9e2d37732.jpg",
          url: "/product/80"
        },
        {
          img:
            "https://salt.tikicdn.com/cache/w885/ts/banner/c1/73/8b/0b114d3c8f057d06ff460f0ec719f0bb.jpg",
          url: "/product/85"
        },
        {
          img:
            "https://salt.tikicdn.com/cache/w885/ts/banner/ac/72/8e/d4c7f4c7b95b4b03485a315667c000aa.jpg",
          url: "/product/90"
        },
        {
          img:
            "https://salt.tikicdn.com/cache/w885/ts/banner/a6/ed/d8/60bbc7ad46d7f1bc89d3e1a7cebe81f3.jpg",
          url: "/product/33"
        },
        {
          img:
            "https://salt.tikicdn.com/cache/w885/ts/banner/21/27/6b/5e0d5e9f477032844bee301dc0cf5198.jpg",
          url: "/product/40"
        }
      ],
      bestSellers: [],
      newBooks: []
    };
  },
  computed: {
    ...mapGetters(["authUser"]),
    isAuth() {
      return this.authUser && this.authUser.id && true;
    }
  },
  mounted() {
    this.$http
      .get("/api/v1/books?limit=4&offset=27", axiosConfig)
      .then(resp => {
        console.log("LIST BOOKS (offset=27)", resp.data);
        this.newBooks = resp.data;
      })
      .catch(err => {
        this.showError(err, "Cannot get book list.")
      });

    this.$http
      .get("/api/v1/books?limit=8&offset=40", axiosConfig)
      .then(resp => {
        console.log("LIST BOOKS (offset=40)", resp.data);
        this.bestSellers = resp.data;
      })
      .catch(err => {
        this.showError(err, "Cannot get book list.")
      });
  },
  
};

</script>

// scoped mean the CSS defined here only has the affect to DOM inside this component ONLY.
// E.g.: h2 in other components/pages will not be affected by the CSS below.
<style scoped>
h2 {
  color: #0078d9;
  font-weight: 300;
  font-size: 1.8rem;
}

</style>
