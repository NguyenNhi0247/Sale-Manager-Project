<template>
  <v-dialog v-if="book" v-model="dialog" persistent max-width="700px">
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
            <v-col cols="12" xs="12">
              <v-text-field v-model="book.title" label="Title"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="book.sub_title" label="Subtitle"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="book.authors" label="Authors"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="book.categories" label="Categories"></v-text-field>
            </v-col>
            <v-col cols="6" xs="6">
              <v-text-field v-model="book.price" type="number" label="Price"></v-text-field>
            </v-col>
            <v-col cols="6" xs="6">
              <v-text-field v-model="book.publisher" label="Publisher"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="book.description" label="Description"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="book.long_description" label="Long description"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="book.published_at" label="Published time"></v-text-field>
            </v-col>
            <v-col cols="12" xs="12">
              <v-text-field v-model="book.published_place" label="Published at"></v-text-field>
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
  name: "book-edit-modal",
  data: () => ({
    formTitle: "",
    dialog: true,
    book: null
  }),
  methods: {
    close() {
      this.dialog = false;
      this.book = null;
    },
    save() {
      this.$http
        .put(
          `/api/v1/books/${this.book.id}`,
          JSON.stringify(this.book),
          this.getAuthHeader()
        )
        .then(resp => {
          console.log(resp.data);
          eventBus.snackbarShown({
            type: "success",
            msg: `Book updated!`
          });
          eventBus.bookUpdated(this.book.id);
          this.close();
        })
        .catch(err => {
          this.showError(err, "Cannot update book.");
          this.close();
        });
      alert("Book saved");
    }
  },
  created() {
    eventBus.$on("showBookEditModal", data => {
      this.book = data;
      this.formTitle = this.book.title;
      this.dialog = true;
    });
  }
};
</script>
