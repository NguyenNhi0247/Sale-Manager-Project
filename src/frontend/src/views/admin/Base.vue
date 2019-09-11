<template>
  <v-container id="keep">
    <v-app-bar app clipped-left color="deep-purple accent-4" dark class="elevation-2">
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <span class="title ml-3 mr-5">
        Bookstore
        <span class="font-weight-light">Dashboard</span>
      </span>
      <!-- <v-text-field solo-inverted flat hide-details label="Search" prepend-inner-icon="search"></v-text-field> -->
      <!-- <div class="flex-grow-1"></div> -->
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" app clipped class="elevation-5">
      <v-list dense class="grey lighten-4">
        <template v-for="(item, i) in items">
          <v-row v-if="item.heading" :key="i" align="center">
            <v-col cols="6">
              <v-subheader v-if="item.heading">{{ item.heading }}</v-subheader>
            </v-col>
            <v-col cols="6" class="text-right">
              <v-btn small text class="grey--text">edit</v-btn>
            </v-col>
          </v-row>
          <v-divider v-else-if="item.divider" :key="i" dark class="my-4 mx-3"></v-divider>
          <v-list-item v-else :key="i" @click="navItemClicked(item.id)">
            <v-list-item-action>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-action>
            <v-list-item-content>
              <v-list-item-title class="grey--text">{{ item.text }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </template>
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
</template>

<script>
export default {
  props: {
    source: String
  },
  data: () => ({
    drawer: null,
    items: [
      { id: 0, icon: "mdi-view-dashboard-outline", text: "Dashboard" },
      { divider: true },
      { heading: "Users" },
      { id: 1, icon: "mdi-account-card-details-outline", text: "Manage users" },
      { divider: true },
      { heading: "Books" },
      { id: 2, icon: "mdi-notebook-outline", text: "Manage books" },
      { icon: "mdi-book-play-outline", text: "Archived" },
      { icon: "mdi-delete-variant", text: "Deleted" },
      { divider: true },
      { id: 3, icon: "mdi-settings-outline", text: "Settings" },
      { id: 4, icon: "mdi-help", text: "Help" }
    ]
  }),
  methods: {
    navItemClicked(id) {
      switch (id) {
        case 0: // Dashboard
          this.$router.push({ path: "/admin" });
          break
        case 1: // User management
          this.$router.push({ path: "/admin/users" });
          break
        case 2: // Book management
          this.$router.push({ path: "/admin/books" });
          break
        case 3: // Settings
          this.$router.push({ path: "/admin/settings" });
          break
        case 4: // Help
          this.$router.push({ path: "/admin/help" });
          break
      }
    }
  }
};
</script>

<style>
#keep .v-navigation-drawer__border {
  display: none;
}
</style>
