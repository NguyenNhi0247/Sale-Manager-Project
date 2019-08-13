<template>
  <v-app-bar color="indigo" dark>
    <v-toolbar-title>Beanies</v-toolbar-title>
    <v-spacer></v-spacer>

    <!-- Right button group -->
    <!-- <v-text-field style="max-width: 200px"></v-text-field> -->
    <v-btn class="mr-3" text icon small>
      <v-icon>mdi-magnify</v-icon>
    </v-btn>
    <v-btn class="ma-2" outlined @click="cartClicked">
      <v-icon left>mdi-cart</v-icon>Your Cart
    </v-btn>
  </v-app-bar>
</template>

<script>
export default {
  name: "my-header",
  data: () => ({}),
  methods: {
    cartClicked() {
      console.log("HIT");
      alert("Cart cliked! Redirect to checkout page...");
      // Tell vue-router to redirect us to the checkout page based on the name/path of the route.
      // Take a look on router.js file.
      this.$router.push({ name: "checkout" });
    }
  }
};
</script>
    
