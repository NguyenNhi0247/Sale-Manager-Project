<template>
  <v-app-bar color="deep-purple accent-4 white--text" dark>
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
        <v-list-item v-for="(item, idx) in menuItems" :key="idx" @click.native.stop ripple>
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item>
      </v-list>
    </v-menu>

    <v-badge :value="counter > 0" overlap top color="#FFB84A" style="margin-top: 5px !important">
      <template v-slot:badge>
        <span>{{ counter }}</span>
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
  </v-app-bar>
</template>

<script>
import { eventBus } from "../event";

export default {
  name: "my-header",
  data: () => ({
    counter: 0,
    menuItems: [
      { title: "Profile" },
      { title: "Settings" },
      { title: "Logout" }
    ]
  }),
  methods: {
    toIndexPage() {
      this.$router.push({ name: "index" });
    },
    cartClicked() {
      // Tell vue-router to redirect us to the checkout page based on the name/path of the route.
      // Take a look on router.js file.
      this.$router.push({ name: "checkout" });
    }
  },
  created() {
    eventBus.$on("addBookToCart", () => {
      this.counter++;
    });
  }
};
</script>
    