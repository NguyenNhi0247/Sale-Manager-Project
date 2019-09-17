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
          no-data-text="No book found"
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
          no-data-text="No book found"
          :height="calcTableHeight()"
        >
          <template v-slot:top>
            <!-- <v-toolbar flat color="white"> -->
            <!-- <v-toolbar-title class="caption">My CRUD</v-toolbar-title> -->
            <!-- <v-divider class="mx-4" inset vertical></v-divider> -->
            <!-- <div class="flex-grow-1"></div> -->

            <!-- </v-toolbar> -->
            <book-edit-modal></book-edit-modal>
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
            <p>No book found</p>
          </template>-->
        </v-data-table>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { eventBus } from "../../event";
import BooKEditModal from "../../components/admin/BookEditModal";

export default {
  name: "book-management",
  components: {
    "book-edit-modal": BooKEditModal
  },
  data: () => ({
    tblHeaders: [
      { text: "Actions", value: "action", sortable: false, width: 30 },
      { text: "ID", align: "left", value: "id", width: 20 },
      { text: "Title", value: "title", width: 250 },
      { text: "Subtitle", value: "sub_title", sortable: false, width: 200 },
      { text: "Authors", value: "authors" },
      { text: "Price (₫)", value: "price" },
      { text: "Publisher", value: "publisher" },
      { text: "Published time", value: "published_at" },
      { text: "Published at", value: "published_place", sortable: false },
      // { text: "Ebook formats", value: "ebook_formats", sortable: false },
      // { text: "Rating", value: "total_rating_point" },
      { text: "Purchased", value: "total_purchased" }
    ],
    tblData: []
  }),
  mounted() {
    this.listAllBooks();
  },
  methods: {
    listAllBooks() {
      let headers = this.getAuthHeader();
      this.$http
        .get("/api/v1/books?limit=100", headers)
        .then(resp => {
          console.log("LIST ALl BOOKS", resp.data);
          this.tblData = resp.data;
        })
        .catch(err => {
          this.showError(err, "Cannot get book list.");
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
      eventBus.bookEditModalShown(item);
    },
    deleteItem(item) {
      let ret = confirm(
        `Are you sure you want to delete "${item.title}" book?`
      );
      if (!ret) {
        return;
      }
      this.$http
        .delete(`/api/v1/books/${item.id}`, this.getAuthHeader())
        .then(resp => {
          console.log("DELETE BOOK", resp, data);

          for (let i = 0; i < this.tblData.length; i++) {
            let book = this.tblData[i];
            if (book.id == item.id) {
              this.tblData.splice(i, 1);
            }
          }
          eventBus.snackbarShown({
            type: "success",
            msg: `Book deleted!`
          });
        })
        .catch(err => {
          this.showError(err, "Cannot delete book.");
        });
    }
  },
  created() {
    eventBus.$on("updateBook", id => {
      this.$http
        .get(`/api/v1/books/${id}`, this.getAuthHeader())
        .then(resp => {
          console.log(resp.data);
          for (let i = 0; i < this.tblData.length; i++) {
            let book = this.tblData[i];
            if (book.id == id) {
              this.tblData.splice(i, 1); // Delete old item from list
              this.tblData.splice(i, 0, resp.data); // Push new updated book to list
            }
          }
        })
        .catch(err => {
          this.showError(err, "Cannot get info of updated book.");
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
