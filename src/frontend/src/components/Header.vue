<template>
  <v-app-bar fixed elevation="2" color="deep-purple accent-4 white--text" dark>
    <v-img
      src="../assets/logo.svg"
      aspect-ratio="1/1"
      height="35"
      max-width="35"
      style="filter: invert(1); cursor: pointer"
      @click="toIndexPage"
    ></v-img>
    <v-toolbar-title class="pl-3" style="cursor: pointer" @click="toIndexPage">Bookstore</v-toolbar-title>
    <v-spacer></v-spacer>

    <!-- Right button group -->
    <v-text-field
      class="mr-3"
      color="deep-purple accent-4"
      solo-inverted
      dark
      single-line
      flat
      hide-details
      clearable
      label="Search"
      prepend-inner-icon="mdi-magnify"
    ></v-text-field>

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
import { mapGetters } from "vuex";
import { eventBus } from "../event";

export default {
  name: "my-header",
  data: () => ({
    menuItems: [
      { title: "Profile", icon: "mdi-account-circle" },
      { title: "Settings", icon: "mdi-settings-outline" },
      { title: "Logout", icon: "mdi-logout-variant" }
    ]
  }),
  computed: {
    ...mapGetters(["cartItemQuantity", "authUser"]),
    isAuth() {
      return this.authUser && this.authUser.id && true;
    }
  },
  methods: {
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
      console.log(idx);
      switch (idx) {
        case 0: // Profile
          break;
        case 1: // Settings
          break
        case 2: // Logout
          eventBus.logoutModalShown();
          break;
      }
    }
  },
  created() {
    // eventBus.$on("loginUser", () => {
    //   this.menuItems.unshift({
    //     title: this.authUser.display_name,
    //     disabled: true
    //   });
    // });
  }
};
</script>
    