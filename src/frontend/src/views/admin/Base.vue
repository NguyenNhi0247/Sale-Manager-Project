<template>
  <v-container id="keep">
    <v-app-bar app clipped-left color="deep-purple accent-4" dark class="elevation-2">
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <span class="title ml-3 mr-5">
        Bookstore
        <span class="font-weight-light">{{ " | " + pageTitle }}</span>
      </span>
      <!-- <v-text-field solo-inverted flat hide-details label="Search" prepend-inner-icon="search"></v-text-field> -->
      <!-- <div class="flex-grow-1"></div> -->
    </v-app-bar>

    <v-navigation-drawer v-model="drawer" app clipped class="elevation-5">
      <v-list dense rounded class="grey lighten-4">
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
            <v-divider v-else-if="item.divider" :key="i" dark class="mt-3 mb-2 mx-3"></v-divider>

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
</template>

<script>
export default {
  props: {
    source: String
  },
  data: () => ({
    drawer: null,
    navItems: [
      { id: 0, icon: "mdi-view-dashboard-outline", text: "Dashboard" },
      { id: 1, divider: true },
      { id: 2, heading: "Users" },
      { id: 3, icon: "mdi-account-card-details-outline", text: "Manage users" },
      { id: 4, divider: true },
      { id: 5, heading: "Books" },
      { id: 6, id: 2, icon: "mdi-notebook-outline", text: "Manage books" },
      { id: 7, icon: "mdi-book-play-outline", text: "Archived" },
      { id: 8, icon: "mdi-delete-variant", text: "Deleted" },
      { id: 9, divider: true },
      { id: 10, icon: "mdi-settings-outline", text: "Settings" },
      { id: 11, icon: "mdi-help", text: "Help" }
    ],
    navItemSelected: 0,
    pageTitle: "Dashboard"
  }),
  methods: {
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
