<template>
  <v-container fluid class="ma-0 pa-0">
    <v-layout>
      <v-flex xs12>
        <!-- <v-data-table
          class="elevation-1"
          :headers="tblHeaders"
          :items="tblData"
          :items-per-page="50"
          fixed-header
          fixed-footer
          no-data-text="No user found"
          :height="calcTableHeight()"
          v-if="tblData"
        >
        </v-data-table>-->

        <v-data-table
          v-if="tblData"
          :headers="tblHeaders"
          :items="tblData"
          sort-by="id"
          class="elevation-1"
          fixed-header
          :items-per-page="50"
          no-data-text="user found"
          :height="calcTableHeight()"
        >
          <template v-slot:top>
            <!-- <v-toolbar flat color="white"> -->
            <!-- <v-toolbar-title class="caption">My CRUD</v-toolbar-title> -->
            <!-- <v-divider class="mx-4" inset vertical></v-divider> -->
            <!-- <div class="flex-grow-1"></div> -->

            <!-- </v-toolbar> -->
            <user-edit-modal></user-edit-modal>
          </template>

          <template v-slot:item.action="{ item }">
            <v-icon small class="mr-2" @click="editItem(item)">mdi-pencil</v-icon>
            <v-icon small @click="deleteItem(item)">mdi-delete</v-icon>
          </template>

          <template
            v-slot:item.sutitle="{ item }"
            style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
          >
            <p>{{ item.subtitle }}</p>
          </template>

          <!-- <template v-slot:no-data>
            <p>No user found</p>
          </template>-->
        </v-data-table>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { eventBus } from "../../event";
import UserEditModal from "../../components/admin/UserEditModal";

export default {
  name: "user-management",
  components: {
    "user-edit-modal": UserEditModal
  },
  data: () => ({
    tblHeaders: [
      { text: "Actions", value: "action", sortable: false, width: 30 },
      { text: "ID", align: "left", value: "id", width: 20 },
      { text: "UserName", value: "username", width: 250 },
      { text: "Avatar", value: "avatar", width: 200 },
      { text: "Role", value: "role" },
      { text: "Display Name", value: "display_name" },
      { text: "Date of Birth", value: "date_of_birth" }
    ],
    tblData: []
  }),
  mounted() {
    this.listAllUsers();
  },
  methods: {
    listAllUsers() {
      let headers = this.getAuthHeader();
      this.$http
        .get("/api/v1/users", headers)
        .then(resp => {
          console.log(resp.data);
          this.tblData = resp.data;
        })
        .catch(err => {
          this.showError(err, "Cannot get user list.");
        });
    },
    calcTableHeight() {
      let body = document.body;
      let html = document.documentElement;

      return (
        Math.max(
          body.scrollHeight,
          body.offsetHeight,
          html.clientHeight,
          html.scrollHeight,
          html.offsetHeight
        ) - 147
      );
    },
    editItem(item) {
      eventBus.userEditModalShown(item);
    },
    deleteItem(item) {
      let ret = confirm(`Are you sure to delete the "${item.username}" user?`);
      if (!ret) {
        return;
      }
      this.$http
        .delete(`/api/v1/users/${item.username}`, this.getAuthHeader())
        .then(resp => {
          console.log("DELETE USER", resp.data);

          for (let i = 0; i < this.tblData.length; i++) {
            let user = this.tblData[i];
            if (user.id == item.id) {
              this.tblData.splice(i, 1);
            }
          }
          eventBus.snackbarShown({
            type: "success",
            msg: `User deleted!`
          });
        })
        .catch(err => {
          this.showError(err, "Cannot delete user.");
        });
    }
  },
  created() {
    eventBus.$on("updateUser", id => {
      this.$http
        .get(`/api/v1/users/${id}`, this.getAuthHeader())
        .then(resp => {
          console.log(resp.data);
          for (let i = 0; i < this.tblData.length; i++) {
            let user = this.tblData[i];
            if (user.id == id) {
              this.tblData.splice(i, 1); // Delete old item from list
              this.tblData.splice(i, 0, resp.data); // Push new updated user to list
            }
          }
        })
        .catch(err => {
          this.showError(err, "Cannot get info of updated user.");
        });
    });
  }
};
</script>

<style>
/* .theme--light.v-datatable .v-datatable__actions {
  position: fixed;
  bottom: 0;
  width: 100%;
} */
tbody tr:nth-of-type(odd) {
  background-color: rgba(0, 0, 0, 0.05);
}

/* tbody > tr:active,
 tbody > tr:focus,
 tbody > tr:hover {
   background-color: #E3F2FD
 } */
</style>
