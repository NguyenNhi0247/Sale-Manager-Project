<template>
  <v-layout row justify-center>
    <v-dialog v-model="dialog" persistent max-width="500px">
      <v-card>
        <v-card-title class="headline">Logout</v-card-title>
        <v-card-text class="subtitle-1">Do you want to logout?</v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="green darken-1" text @click.native="dialog = false">Cancel</v-btn>
          <v-btn color="green darken-1" text @click.native="logout">Yes, I'm out</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-layout>
</template>

<script>
import { eventBus } from "../../event";
import { mapMutations } from "vuex";

export default {
  name: "logout-modal",
  data() {
    return {
      dialog: false,
      cookies: ["beanies_token", "beanies_user"]
    };
  },
  methods: {
    ...mapMutations(["setAuthUser"]),
    logout() {
      this.$http
        .post("/api/v1/logout")
        .then(resp => {
          console.log("LOGOUT", resp.data);
          
          this.setAuthUser(null);
          // Delete all cookies
          for (let cookie of this.cookies) {
            this.deleteCookie(cookie);
            this.deleteCookie(cookie, "." + window.location.host);
          }
          eventBus.snackbarShown({ type: "success", msg: "Bye mate!" });
          eventBus.userLoggedOut();
          this.dialog = false;
        })
        .catch(err => {
          console.log(err);
          if (err && err.response) {
            eventBus.snackbarShown({
              type: "error",
              msg: "Logout failed: " + err.response.data.message
            });
            this.dialog = false;
            return;
          }
          eventBus.snackbarShown({
            type: "error",
            msg: "Logout failed: " + err.message
          });
          this.dialog = false;
        });
    }
  },
  created() {
    eventBus.$on("showLogoutModal", () => {
      this.dialog = true;
    });
  }
};
</script>
