<template>
  <v-container fluid class="ma-0 pa-0">
    <v-layout>
      <v-flex xs12>

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
          <template v-slot:item.action="{ item }">
            <v-icon @click="publishBook(item)">mdi-telegram</v-icon>
          </template>

          <template
            v-slot:item.sutitle="{ item }"
            style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"
          >
            <p>{{ item.subtitle }}</p>
          </template>
        </v-data-table>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { eventBus } from "../../event";

export default {
  name: "book-management",
  data: () => ({
    tblHeaders: [
      { text: "Publish", value: "action", sortable: false, width: 30 },
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
        .get("/api/v1/books?limit=100&status=deleted", headers)
        .then(resp => {
          console.log("LIST ALL DELETED BOOKS", resp.data);
          this.tblData = resp.data;
        })
        .catch(err => {
          this.showError(err, "Cannot get list of DELETED books.");
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
    publishBook(item) {
      let ret = confirm(
        `Are you sure to re-publish the "${item.title}" book?`
      );
      if (!ret) {
        return;
      }
      this.$http
        .put(`/api/v1/books/${item.id}/publish`, null, this.getAuthHeader())
        .then(resp => {
          console.log("PUBLISH BOOK", resp.data);

          for (let i = 0; i < this.tblData.length; i++) {
            let book = this.tblData[i];
            if (book.id == item.id) {
              this.tblData.splice(i, 1);
            }
          }
          eventBus.snackbarShown({
            type: "success",
            msg: `Book published!`
          });
        })
        .catch(err => {
          this.showError(err, "Cannot publish book.");
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
