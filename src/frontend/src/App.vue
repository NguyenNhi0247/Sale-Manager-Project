<template>
  <v-app>
    <!-- Global components -->
    <snackbar></snackbar>
    <login-modal></login-modal>
    <logout-modal></logout-modal>

    <transition name="fade" mode="out-in">
      <router-view />
    </transition>
  </v-app>
</template>

<script>
import LoginModal from "./components/modals/LoginModal";
import LogoutModal from "./components/modals/LogoutModal";
import Snackbar from "./components/Snackbar";
import {mapGetters, mapMutations} from "vuex"

export default {
  name: "App",
  components: {
    "login-modal": LoginModal,
    "logout-modal": LogoutModal,
    "snackbar": Snackbar
  },
  data: () => ({}),
  methods: {
    ...mapMutations(["setAuthUser"])
  },
  mounted() {
    // Check cookie to detect if user already logged in or not.
    // If already logged in the save current user info to Vuex store.
    let user = this.getCookie("beanies_user")
    let token = this.getCookie("beanies_token")
    console.log(user, token)
    if (token && user) {
      let decoded = JSON.parse(window.atob(user))
      if (decoded.id && true) {
        this.setAuthUser(decoded)
      }
    }
  }
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
