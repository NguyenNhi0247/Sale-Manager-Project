<template>
  <v-dialog v-model="dialog" persistent>
    <v-card v-if="summary">
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
        <v-btn color="primary" @click="confirm" :disabled="!summary">Confirm</v-btn>
      </v-card-actions>
    </v-card>

    <p v-else>No order info</p>
  </v-dialog>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";
import { eventBus } from "../../event";

export default {
  name: "order-confirm-modal",
  data: () => ({
    address: null,
    payment: null,
    summary: null,
    dialog: false
  }),
  computed: {
    ...mapGetters(["authUser"])
  },
  methods: {
    ...mapMutations(["cleanUpCart", "resetCheckoutStep", "setOrderSummary"]),
    close() {
      this.dialog = false;
      this.address = null;
      this.payment = null;
      this.summary = null;
    },
    confirm() {
      let order = {
        user_id: this.authUser.id,
        user_payment_id: this.payment.id,
        user_address_id: this.address.id,
        shipping_fee: this.summary.shippingFee,
        discount: this.summary.discount,
        total: this.summary.total
      };

      this.$http
        .post(
          `/api/v1/users/${this.authUser.username}/orders`,
          JSON.stringify(order),
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("ORDER OK", resp.data);
          this.cleanUpCart();
          this.setOrderSummary({
            total: 0,
            subTotal: 0,
            shippingFee: 0,
            discount: 0
          });
          this.resetCheckoutStep();

          eventBus.snackbarShown({
            type: "success",
            msg: `Order success!`
          });

          this.close();
          this.$router.push({ path: "/" });
        })
        .catch(err => {
          this.showError(err, "Cannot process your order.");
          this.close();
        });
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
