<template>
  <v-dialog v-if="user" v-model="dialog" persistent max-width="700px">
    <!-- <template v-slot:activator="{ on }">
                  <v-btn small color="primary" dark class="mb-2" v-on="on">New User</v-btn>
    </template>-->
    <v-card>
      <v-card-title>
        <span class="headline">{{ formTitle }}</span>
      </v-card-title>

      <v-card-text>
        <v-container>
          <v-row>
              
            <v-col cols="12" xs="12">
              <v-text-field v-model="user.username" label="UserName"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="user.email" label="Email"></v-text-field>
            </v-col>
            <!-- <v-col cols="12" xs="12">
              <v-text-field v-model="user.password" label="Authors"></v-text-field>
            </v-col> -->
            <v-col cols="12" xs="12">
              <v-text-field v-model="user.avatar" label="Avatar"></v-text-field>
            </v-col>
            <v-col cols="6" xs="6">
              <v-text-field v-model="user.role" type="Role" label="Role"></v-text-field>
            </v-col>
            <v-col cols="6" xs="6">
              <v-text-field v-model="user.display_name" label="Display Name"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="user.date_of_birth" label="Date of Birth"></v-text-field>
            </v-col>
          </v-row>
        </v-container>
      </v-card-text>

      <v-card-actions>
        <div class="flex-grow-1"></div>
        <v-btn text @click="close">Cancel</v-btn>
        <v-btn color="primary" @click="save">Save</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import { eventBus } from "../../event";

export default {
  name: "user-edit-modal",
  data: () => ({
    formTitle: "",
    dialog: true,
    user: null
  }),
  methods: {
    close() {
      this.dialog = false;
      this.user = null;
    },
    save() {
      this.$http
        .put(
          `/api/v1/users/${this.user.id}`,
          JSON.stringify(this.user),
          this.getAuthHeader()
        )
        .then(resp => {
          console.log(resp.data);
          eventBus.snackbarShown({
            type: "success",
            msg: `User updated!`
          });
          eventBus.userUpdated(this.user.id);
          this.close();
        })
        .catch(err => {
          this.showError(err, "Cannot update user.");
          this.close();
        });
    }
  },
  created() {
    eventBus.$on("showUserEditModal", data => {
      this.user = data;
      this.formTitle = this.user.username;
      this.dialog = true;
    });
  }
};
</script>
