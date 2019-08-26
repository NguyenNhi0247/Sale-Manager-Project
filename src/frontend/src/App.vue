<template>
  <v-app>
    <!-- Global components -->
    <snackbar></snackbar>
    <login-modal></login-modal>

    <transition name="fade" mode="out-in">
      <router-view />
    </transition>
  </v-app>
</template>

<script>
import LoginModal from "./components/modals/LoginModal";
import Snackbar from "./components/Snackbar";

export default {
  name: "App",
  components: {
    "login-modal": LoginModal,
    snackbar: Snackbar
  },
  data: () => ({}),
};
</script>

<style lang="css">
.fade-enter-active,
.fade-leave-active {
  transition-duration: 0.3s;
  transition-property: opacity;
  transition-timing-function: ease;
}

.fade-enter,
.fade-leave-active {
  opacity: 0;
}
</style>
