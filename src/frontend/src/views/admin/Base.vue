<template>
  <v-container class="ma-0 pa-0" fluid>
    <v-container v-if="isAuth && isAdmin" class="ma-0 pa-0" fluid>
      <v-app-bar app clipped-left color="indigo accent-4" dark class="elevation-2">
        <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
        <span class="title ml-3 mr-5">
          Bookstore
          <span class="font-weight-light">{{ " | " + pageTitle }}</span>
        </span>

        <v-spacer></v-spacer>
        <!-- <v-text-field solo-inverted flat hide-details label="Search" prepend-inner-icon="search"></v-text-field> -->
        <!-- <div class="flex-grow-1"></div> -->
        <v-btn icon class="mr-3">
          <v-icon>mdi-bell-outline</v-icon>
        </v-btn>
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
              <img src="https://avatars2.githubusercontent.com/u/18606262?s=180" alt="John" />
              <!-- <v-icon>mdi-account-circle</v-icon> -->
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
      </v-app-bar>

      <v-navigation-drawer v-model="drawer" app clipped>
        <v-list dense rounded class="white">
          <v-list-item-group v-model="navItemSelected" color="primary">
            <template v-for="(item, i) in navItems">
              <v-row v-if="item.heading" :key="i" align="center">
                <v-col cols="6">
                  <v-subheader v-if="item.heading">{{ item.heading }}</v-subheader>
                </v-col>
                <v-col cols="6" class="text-right">
                  <v-btn small text class="grey--text">edit</v-btn>
                </v-col>
              </v-row>
              <v-divider v-else-if="item.divider" :key="i" dark class="mt-3 mb-2"></v-divider>

              <v-list-item v-else :key="i" @click="navItemClicked(item.id)" selected>
                <v-list-item-action>
                  <v-icon>{{ item.icon }}</v-icon>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title class="grey--text">{{ item.text }}</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </template>
          </v-list-item-group>
        </v-list>
      </v-navigation-drawer>

      <v-content>
        <v-container fluid class="grey lighten-4 fill-height">
          <transition name="fade" mode="out-in">
            <router-view></router-view>
          </transition>
        </v-container>
      </v-content>
    </v-container>
    <v-container v-else fluid class="text-center mt-12 pt-12">
      <p class="body-1">Sorry, only admin can access this page :(</p>
      <v-btn color="grey mr-3" dark depressed @click="backToShop">Back to shop</v-btn>or
      <v-btn color="indigo accent-4 ml-3" dark depressed @click="login">Login</v-btn>
    </v-container>
  </v-container>
</template>

<script>
import { mapGetters } from "vuex";
import { eventBus } from "../../event";

export default {
  props: {
    source: String
  },
  data: () => ({
    drawer: null,
    menuItems: [
      { title: "Profile", icon: "mdi-account-circle" },
      { title: "Settings", icon: "mdi-settings-outline" },
      { title: "Logout", icon: "mdi-logout-variant" }
    ],
    navItems: [
      { id: 0, icon: "mdi-view-dashboard-outline", text: "Dashboard" },
      { id: 1, divider: true },
      { id: 2, heading: "Users" },
      { id: 3, icon: "mdi-account-card-details-outline", text: "Manage" },
      { id: 4, divider: true },
      { id: 5, heading: "Books" },
      { id: 6, icon: "mdi-notebook-outline", text: "Manage" },
      { id: 7, icon: "mdi-book-play-outline", text: "Archived" },
      { id: 8, icon: "mdi-delete-variant", text: "Deleted" },
      { id: 9, divider: true },
      { id: 10, icon: "mdi-settings-outline", text: "Settings" },
      { id: 11, icon: "mdi-help", text: "Help" },
      { id: 12, icon: "mdi-arrow-left", text: "Back to shop" }
    ],
    navItemSelected: 0,
    pageTitle: "Dashboard"
  }),
  computed: {
    ...mapGetters(["authUser"]),
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
  methods: {
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
    navItemClicked(id) {
      switch (id) {
        case 0: // Dashboard
          this.$router.push({ path: "/admin" });
          this.pageTitle = "Dashboard";
          break;
        case 3: // User management
          this.$router.push({ path: "/admin/users" });
          this.pageTitle = "Users";
          break;
        case 6: // Book management
          this.$router.push({ path: "/admin/books" });
          this.pageTitle = "Books";
          break;
        case 10: // Settings
          this.$router.push({ path: "/admin/settings" });
          this.pageTitle = "Settings";
          break;
        case 11: // Help
          this.$router.push({ path: "/admin/help" });
          this.pageTitle = "Help";
          break;
        case 12: // Back to shop
          this.$router.push({ path: "/" });
          break;
      }
    },
    login() {
      eventBus.loginModalShown();
    },
    backToShop() {
      this.$router.push({ path: "/" });
    }
  },
  created() {
    eventBus.$on("logoutUser", () => {
      this.$router.push({ path: "/" });
    });
  },
  mounted() {
    if (!this.isAuth) {
      eventBus.loginModalShown();
      return;
    }
    if (!this.isAdmin) {
      eventBus.snackbarShown({
        type: "error",
        msg:
          "Only admin can access this page. Please login using admin account!"
      });
    }
  }
};
</script>

<style>
#keep .v-navigation-drawer__border {
  display: none;
}
</style>
