<template>
  <v-container fluid>
    <v-layout>
      <!-- Left section => Category list / Advanced search... -->
      <v-flex xs2>
        <h3>Categories</h3>
        <ul>
          <li><a href="#">Children</a></li>
          <li><a href="#">Science</a></li>
          <li><a href="#">Programming</a></li>
          <li><a href="#">Thriller</a></li>
          <li><a href="#">Business Management</a></li>
          <li><a href="#">Religious</a></li>
          <li><a href="#">Romance</a></li>
        </ul>
        <p style="font-size: 0.8rem; margin-top: 15px; margin-right: 10px"><i>TODO: Styling this left-section later. Also add more advanced search/filter options if possible.</i></p>
      </v-flex>

      <!-- Right section => Display list of books -->
      <v-flex xs10>
        <!-- Best sellers - Can change this by banner/carousel later -->
        <h2>Best Sellers</h2>
        <v-container fluid grid-list-md pa-3 px-0>
          <v-layout wrap>
            <v-flex xs4 v-for="(book, idx) in books" :key="idx">
              <v-hover v-slot:default="{ hover }">
                <v-card :elevation="hover ? 24 : 2">
                  <v-img height="250" :src="book.thumbnail"/>
                  <v-card-title>{{ book.title }}</v-card-title>
                  <v-card-text class="mb-0 pb-0">
                    <span>{{ book.author }}</span>
                  </v-card-text>
                  <v-card-text class="mt-0">
                    <v-layout align-center>
                      <v-rating :value="book.total_rating_point / book.total_rated" color="amber" half-increments dense size="14" readonly></v-rating>
                      <div class="grey--text ml-4">{{ book.total_rating_point / book.total_rated }} ({{ book.total_rated }})</div>
                    </v-layout>

                    <div class="my-4 subtitle-1 black--text">{{ book.price | toLocaleString }} VND • {{ book.publisher }}</div>

                    <div>{{ book.description }}</div>

                    <!-- Categories -->
                    <v-chip-group active-class="deep-purple accent-4 white--text" column>
                      <v-chip small v-for="category in book.categories">{{ category.name }}</v-chip>
                    </v-chip-group>
                  </v-card-text>
                  <v-divider class="mx-4"></v-divider>

                  <v-card-actions right>
                    <v-btn color="indigo accent-4" small text light @click="addToCart">
                      <v-icon small>mdi-cart</v-icon>&nbsp;Add To Cart
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
        <v-container fluid grid-list-md pa-3 px-0>
          <v-layout wrap>
            <v-flex xs4 v-for="(book, idx) in books" :key="idx">
              <v-hover v-slot:default="{ hover }">
                <v-card :elevation="hover ? 24 : 2">
                  <v-img height="250" :src="book.thumbnail"/>
                  <v-card-title>{{ book.title }}</v-card-title>
                  <v-card-text class="mb-0 pb-0">
                    <span>{{ book.author }}</span>
                  </v-card-text>
                  <v-card-text class="mt-0">
                    <v-layout align-center>
                      <v-rating :value="book.total_rating_point / book.total_rated" color="amber" half-increments dense size="14" readonly></v-rating>
                      <div class="grey--text ml-4">{{ book.total_rating_point / book.total_rated }} ({{ book.total_rated }})</div>
                    </v-layout>

                    <div class="my-4 subtitle-1 black--text">{{ book.price | toLocaleString }} VND • {{ book.publisher }}</div>

                    <div>{{ book.description }}</div>

                    <!-- Book's categories -->
                    <v-chip-group active-class="deep-purple accent-4 white--text" column>
                      <v-chip small v-for="category in book.categories">{{ category.name }}</v-chip>
                    </v-chip-group>
                  </v-card-text>
                  <v-divider class="mx-4"></v-divider>

                  <v-card-actions right>
                    <v-btn color="indigo accent-4" small text light @click="addToCart">
                      <v-icon small>mdi-cart</v-icon>&nbsp;Add To Cart
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
export default {
  name: "index",
  data() {
    return {
      // Fake data for displaying books.
      // Later then we will need to call to backend API to get the list of books from databse then
      // display it here.
      books: [
        {
          title: "The Little Prince",
          author: "Antoine de Saint-Exupéry",
          thumbnail: "https://cdn.vuetifyjs.com/images/cards/cooking.png",
          total_rated: 100,
          total_rating_point: 470,
          price: 50000,
          publisher: "Reynal & Hitchcock",
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          categories: [
            { name: "Children", url: "/category/children" },
            { name: "Scientific", url: "/category/scientific" },
          ]
        },
        {
          title: "The Little Prince",
          author: "Antoine de Saint-Exupéry",
          thumbnail: "https://cdn.vuetifyjs.com/images/cards/cooking.png",
          total_rated: 100,
          total_rating_point: 470,
          price: 50000,
          publisher: "Reynal & Hitchcock",
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          categories: [
            { name: "Children", url: "/category/children" },
            { name: "Scientific", url: "/category/scientific" },
          ]
        },
        {
          title: "The Little Prince",
          author: "Antoine de Saint-Exupéry",
          thumbnail: "https://cdn.vuetifyjs.com/images/cards/cooking.png",
          total_rated: 100,
          total_rating_point: 470,
          price: 50000,
          publisher: "Reynal & Hitchcock",
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          categories: [
            { name: "Children", url: "/category/children" },
            { name: "Scientific", url: "/category/scientific" },
          ]
        },
        {
          title: "The Little Prince",
          author: "Antoine de Saint-Exupéry",
          thumbnail: "https://cdn.vuetifyjs.com/images/cards/cooking.png",
          total_rated: 100,
          total_rating_point: 470,
          price: 50000,
          publisher: "Reynal & Hitchcock",
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          categories: [
            { name: "Children", url: "/category/children" },
            { name: "Scientific", url: "/category/scientific" },
          ]
        },
        {
          title: "The Little Prince",
          author: "Antoine de Saint-Exupéry",
          thumbnail: "https://cdn.vuetifyjs.com/images/cards/cooking.png",
          total_rated: 100,
          total_rating_point: 470,
          price: 50000,
          publisher: "Reynal & Hitchcock",
          description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
          categories: [
            { name: "Children", url: "/category/children" },
            { name: "Scientific", url: "/category/scientific" },
          ]
        }
      ]
    }
  },
  filters: {
    // Convert v to its location form, return v itself if it's not a number.
    // E.g.: 50000 => 50,000
    toLocaleString(v) {
      if (isNaN(v)) {
        return v
      }
      return v.toLocaleString()
    }
  },
  methods: {
    addToCart() {
      alert("Book added to cart...")
    }
  }
};
</script>

// scoped mean the CSS defined here only has the affect to DOM inside this component ONLY.
// E.g.: h2 in other components/pages will not be affected by the CSS below.
<style scoped>
  h2 {
    color: #4CAF50;
    font-weight: 400;
    font-size: 2rem;
  }  
</style>
