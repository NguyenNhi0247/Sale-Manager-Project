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

            <v-dialog v-model="dialog" max-width="700px">
              <!-- <template v-slot:activator="{ on }">
                  <v-btn small color="primary" dark class="mb-2" v-on="on">New Book</v-btn>
              </template>-->
              <v-card>
                <v-card-title>
                  <span class="headline">{{ formTitle }}</span>
                </v-card-title>

                <v-card-text>
                  <v-container>
                    <v-row>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.title" label="Title"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.sub_title" label="Subtitle"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.authors" label="Authors"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.price" label="Price"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.publisher" label="Publisher"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.published_at" label="Published time"></v-text-field>
                      </v-col>
                      <v-col cols="12" sm="6" md="4">
                        <v-text-field v-model="editedItem.published_place" label="Published at"></v-text-field>
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-text>

                <v-card-actions>
                  <div class="flex-grow-1"></div>
                  <v-btn color="blue darken-1" text @click="close">Cancel</v-btn>
                  <v-btn color="blue darken-1" text @click="save">Save</v-btn>
                </v-card-actions>
              </v-card>
            </v-dialog>
            <!-- </v-toolbar> -->
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
export default {
  name: "book-management",
  data: () => ({
    tblHeaders: [
      { text: "Actions", value: "action", sortable: false, width: 30 },
      { text: "ID", align: "left", value: "id", width: 20},
      { text: "Title", value: "title", width: 250},
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
    tblData: [],
    dialog: false,
    editedIndex: -1,
    editedItem: {
      title: "",
      sub_title: "",
      authors: [],
      price: 0,
      publisher: "",
      published_at: new Date(),
      published_place: ""
    },
    defaultItem: {
      title: "",
      sub_title: "",
      authors: [],
      price: 0,
      publisher: "",
      published_at: new Date(),
      published_place: ""
    }
  }),
  mounted() {
    this.listAllBooks();
  },
  computed: {
    formTitle() {
      return this.editedIndex === -1 ? "New Item" : "Edit Item";
    }
  },

  watch: {
    dialog(val) {
      val || this.close();
    }
  },
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
      this.editedIndex = this.tblData.indexOf(item);
      this.editedItem = Object.assign({}, item);
      this.dialog = true;
    },

    deleteItem(item) {
      const index = this.tblData.indexOf(item);
      confirm("Are you sure you want to delete this item?") &&
        this.tblData.splice(index, 1);
    },

    close() {
      this.dialog = false;
      setTimeout(() => {
        this.editedItem = Object.assign({}, this.defaultItem);
        this.editedIndex = -1;
      }, 300);
    },

    save() {
      if (this.editedIndex > -1) {
        Object.assign(this.tblData[this.editedIndex], this.editedItem);
      } else {
        this.tblData.push(this.editedItem);
      }
      this.close();
    }
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
