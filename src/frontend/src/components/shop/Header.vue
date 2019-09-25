<template>
  <v-app-bar fixed elevation="2" color="indigo accent-4 white--text" dark>
    <v-img
      src="../../assets/logo.svg"
      aspect-ratio="1/1"
      height="35"
      max-width="35"
      style="filter: invert(1); cursor: pointer"
      @click="toIndexPage"
    ></v-img>
    <v-toolbar-title class="pl-3" style="cursor: pointer" @click="toIndexPage">Bookstore</v-toolbar-title>
    <v-spacer></v-spacer>

    <!-- Right button group -->
    
    <v-autocomplete
      v-model="select"
      :loading="loading"
      :items="items"
      :search-input.sync="search"
      cache-items
      class="mr-3"
      color="indigo accent-4"
      solo-inverted
      dark
      single-line
      flat
      hide-details
      clearable
      label="Search"
      prepend-inner-icon="mdi-magnify"
      @keyup.enter="bookClicked(search)"
    ></v-autocomplete>
  

    <!-- <v-text-field
      class="mr-3"
      color="indigo accent-4"
      solo-inverted
      dark
      single-line
      flat
      hide-details
      clearable
      label="Search"
      prepend-inner-icon="mdi-magnify"
    ></v-text-field> -->

    <v-menu
      v-if="isAuth"
      bottom
      offset-y
      open-on-hover
      open-delay="150"
      close-on-content-click
      transition="slide-y-transition"
    >
      <template v-slot:activator="{ on }">
        <v-avatar v-on="on" class="mr-2" size="36" style="cursor: pointer">
          <!-- <img src="https://cdn.vuetifyjs.com/images/john.jpg" alt="John"> -->
          <v-icon>mdi-account-circle</v-icon>
        </v-avatar>
      </template>

      <v-list>
        <v-subheader>{{this.authUser.display_name}}</v-subheader>
        <v-divider></v-divider>
        <div v-if="isAdmin">
          <v-list-item @click="toAdminPage" ripple>
            <v-list-item-icon class="mr-3">
              <v-icon>mdi-view-dashboard-outline</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>Administrator</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
          <v-divider></v-divider>
        </div>
        <v-list-item-group color="primary">
          <v-list-item
            v-for="(item, idx) in menuItems"
            :key="idx"
            @click.native.stop="menuItemClicked(idx)"
            ripple
          >
            <v-list-item-icon class="mr-3">
              <v-icon v-text="item.icon"></v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list-item-group>
      </v-list>
    </v-menu>

    <v-badge
      v-if="isAuth"
      :value="cartItemQuantity > 0"
      overlap
      top
      color="yellow accent-4"
      style="margin-top: 5px !important"
    >
      <template v-slot:badge>
        <span>{{ cartItemQuantity }}</span>
      </template>
      <v-btn
        class="ma-2 text-none"
        outlined
        @click="cartClicked"
        style="margin-top: 0 !important; margin-right: 0px !important; font-weight: 400"
      >
        <v-icon left>mdi-cart</v-icon>Your Cart
      </v-btn>
    </v-badge>
    <v-btn v-else class="ml-2" outlined @click="btnLoginClicked">
      <v-icon class="pr-2">mdi-account-circle</v-icon>Login
    </v-btn>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";
import { eventBus } from "../../event";
import { axiosConfig } from "../../utils";


export default {
  name: "my-header",
  data: () => ({
    menuItems: [
      { title: "Profile", icon: "mdi-account-circle" },
      { title: "Settings", icon: "mdi-settings-outline" },
      { title: "Logout", icon: "mdi-logout-variant" }
    ],

    loading: false,
        items: [],
        search: null,
        select: null,
        states: [
          
        ],
  }),
  computed: {
    ...mapGetters(["cartItemQuantity", "authUser"]),
    isAuth() {
      return this.authUser && this.authUser.id && true;
    },
    isAdmin() {
      if (!this.isAuth) {
        return false;
      }
      return this.authUser.role === 1;
    }
  },
  watch: {
    authUser(val) {
      if (val && val.id && true) {
        this.listCartItems();
      }
    },

    search (val) {
      val && val !== this.select && this.querySelections(val);
      this.$http
        .get(`/api/v1/books/search/${val}`, this.getAuthHeader)
        .then(resp => {
          let i=0;
          for (i = 0; i < resp.data.length; i++) {
              this.states.push(resp.data[i].title);

              //this.$router.push({ path: `/product/${resp.data[i].id}` });
            }
          
        })
        
      },
  },
  methods: {
    querySelections (v) {
        this.loading = true
        // Simulated ajax query
        setTimeout(() => {
          this.items = this.states.filter(e => {
            return (e || '').toLowerCase().indexOf((v || '').toLowerCase()) > -1
          })
          this.loading = false
        }, 500)
      },
      bookClicked(book_name) {
      this.$http
        .get(`/api/v1/books/book_id/${book_name}`, this.getAuthHeader)
        .then(resp => {
          this.$router.push({ path: `/product/${resp.data}` });
          
        })
    },



    ...mapMutations(["addToCart", "cleanUpCart"]),
    listCartItems() {
      // Load all books added to cart and put it to global vuex store
      this.$http
        .get("/api/v1/carts/list", this.getAuthHeader())
        .then(resp => {
          console.log("LIST ITEMS IN CART", resp.data);

          this.cleanUpCart();
          for (let i = 0; i < resp.data.length; i++) {
            this.addToCart(resp.data[i]);
            eventBus.bookAddedToCart(resp.data[i]);
          }
        })
        .catch(err => {
          this.showError(err, "Cannot list books in cart");
        });
    },
    toIndexPage() {
      this.$router.push({ name: "index" });
    },
    cartClicked() {
      // Tell vue-router to redirect us to the checkout page based on the name/path of the route.
      // Take a look on router.js file.
      this.$router.push({ name: "checkout" });
    },
    btnLoginClicked() {
      eventBus.loginModalShown();
    },
    menuItemClicked(idx) {
      switch (idx) {
        case 0: // Profile
          this.$router.push({
            name: "user",
            params: { username: this.authUser.username }
          });
          break;
        case 1: // Settings
          break;
        case 2: // Logout
          eventBus.logoutModalShown();
          break;
      }
    },
    toAdminPage() {
      this.$router.push({ path: "/admin" });
    }
  },
  created() {
    // eventBus.$on("loginUser", () => {
    //   this.listCartItems()
    // })
    eventBus.$on("logoutUser", () => {
      this.cleanUpCart();
    });
  },
  mounted() {
    this.listCartItems();
  }
};
</script>
    