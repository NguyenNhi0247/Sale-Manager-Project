// Base contains all components that will be inherited by shop's pages (index, product, checkout...),
likes the header, footer...
<template>
  <div>
    <!-- Header. Link to the components/Header.vue file -->
    <my-header v-if="showHeader"></my-header>

    <!-- Child pages will be rendered here based on the URL path. Take a look on router.js file -->
    <v-content :style='showHeader ? {"margin-top": "65px"} : { "margin-top": "0"}'>
      <v-container fluid class="pa-0 ma-0" style="background-color: #F4F4F4">
        <transition name="fade" mode="out-in">
          <router-view></router-view>
        </transition>
      </v-container>
    </v-content>

    <!-- Footer. Link to the components/Footer.vue file -->
    <my-footer v-show="showFooter"></my-footer>
  </div>
</template>

<script>
import Header from "../../components/shop/Header";
import Footer from "../../components/shop/Footer";
import { mapGetters } from "vuex";

export default {
  components: {
    "my-header": Header,
    "my-footer": Footer,
  },
  computed: {
    ...mapGetters(["showHeader", "showFooter"])
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
