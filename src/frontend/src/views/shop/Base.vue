// Base contains all components that will be inherited by shop's pages (index, product, checkout...),
likes the header, footer...
<template>
  <div>
    <!-- Header. Link to the components/Header.vue file -->
    <my-header></my-header>

    <!-- Child pages will be rendered here based on the URL path. Take a look on router.js file -->
    <v-content style="margin-top: 65px">
      <v-container fluid class="pa-0 ma-0" style="background-color: #F4F4F4">
        <transition name="fade" mode="out-in">
          <router-view></router-view>
        </transition>
      </v-container>
    </v-content>

    <!-- Footer. Link to the components/Footer.vue file -->
    <my-footer></my-footer>
  </div>
</template>

<script>
import Header from "../../components/Header";
import Footer from "../../components/Footer";

export default {
  components: {
    "my-header": Header,
    "my-footer": Footer
  },
  data() {
    return {
      // Nothing here, yet...
    };
  },
  methods: {
    // Nothing here, yet...
  }
};
</script>
