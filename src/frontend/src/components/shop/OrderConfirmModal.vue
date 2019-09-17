<template>
  <v-dialog v-if="summary" v-model="dialog" persistent>
    <!-- <template v-slot:activator="{ on }">
                  <v-btn small color="primary" dark class="mb-2" v-on="on">New Book</v-btn>
    </template>-->
    <v-card>
      <v-card-title>
        <span class="headline">Order Summary</span>
      </v-card-title>

      <v-card-text>
        <v-container>
          <v-layout row>
            <v-flex xs12>
              <pre>{{ address }}<br />{{ payment }}<br />{{ summary }}</pre>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>

      <v-card-actions>
        <div class="flex-grow-1"></div>
        <v-btn text @click="close">Cancel</v-btn>
        <v-btn color="primary" @click="confirm">Confirm</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import { eventBus } from "../../event";

export default {
  name: "order-confirm-modal",
  data: () => ({
    address: null,
    payment: null,
    summary: null,
    dialog: true
  }),
  methods: {
    close() {
      this.dialog = false;
      this.address = null;
      this.payment = null;
      this.summary = null;
    },
    confirm() {
      //   this.$http
      //     .put(
      //       `/api/v1/books/${this.book.id}`,
      //       JSON.stringify(this.book),
      //       this.getAuthHeader()
      //     )
      //     .then(resp => {
      //       console.log("BOOK SAVED", resp.data);
      //       eventBus.snackbarShown({
      //         type: "success",
      //         msg: `Book updated!`
      //       });
      //       eventBus.bookUpdated(this.book.id);
      //       this.close();
      //     })
      //     .catch(err => {
      //       this.showError(err, "Cannot update book.");
      //       this.close();
      //     });
    }
  },
  created() {
    eventBus.$on("showOrderConfirmModal", data => {
      this.address = data.address;
      this.payment = data.payment;
      this.summary = data.summary;
      this.dialog = true;
    });
  }
};
</script>
