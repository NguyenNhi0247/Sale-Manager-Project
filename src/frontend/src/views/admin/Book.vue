<template>
  <v-container fluid class="ma-0 pa-0">
    <v-layout>
      <v-flex xs12>
        <v-data-table
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
        </v-data-table>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  name: "book-management",
  data: () => ({
    tblHeaders: [
      { text: "ID", align: "left", value: "id" },
      { text: "Title", value: "title" },
      { text: "Subtitle", value: "sub_title", sortable: false },
      { text: "Authors", value: "authors" },
      { text: "Price (₫)", value: "price" },
      { text: "Publisher", value: "publisher" },
      { text: "Published time", value: "published_at" },
      { text: "Published at", value: "published_place", sortable: false },
      // { text: "Ebook formats", value: "ebook_formats", sortable: false },
      { text: "Rating", value: "total_rating_point" },
      { text: "Purchased", value: "total_purchased" }
    ],
    tblData: null
  }),
  methods: {
    listAllBooks() {
      let headers = this.getAuthHeader();
      this.$http
        .get("/api/v1/books?limit=100", headers)
        .then(resp => {
          console.log(resp.data);
          this.tblData = resp.data;
        })
        .catch(err => {
          this.showError(err, "Cannot get book list.");
        });
    },
    calcTableHeight() {
      let body = document.body;
      let html = document.documentElement;

      return Math.max(
        body.scrollHeight,
        body.offsetHeight,
        html.clientHeight,
        html.scrollHeight,
        html.offsetHeight
      ) - 150
    }
  },
  mounted() {
    this.listAllBooks();
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
   background-color: rgba(0, 0, 0, .05);
 }

 /* tbody > tr:active,
 tbody > tr:focus,
 tbody > tr:hover {
   background-color: #E3F2FD
 } */
</style>
