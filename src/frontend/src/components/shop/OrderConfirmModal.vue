<template>
  <v-dialog v-model="dialog" :persistent="!isReadOnly" max-width="700px">
    <v-card v-if="summary">
      <v-card-title>
        <span class="headline">Order Details</span>
      </v-card-title>

      <v-card-text>
        <v-container>
          <v-layout row>
            <v-flex xs12>
              <p class="title">Summary</p>
              <v-simple-table>
                <tbody>
                  <tr>
                    <td>Subtotal</td>
                    <td>{{ summary.subTotal | toLocaleString }}₫</td>
                  </tr>
                  <tr>
                    <td>Shipping fee</td>
                    <td>+ {{ summary.shippingFee | toLocaleString }}₫</td>
                  </tr>
                  <tr>
                    <td>Discount</td>
                    <td>- {{ summary.discount | toLocaleString }}₫</td>
                  </tr>
                  <tr>
                    <td class="subtitle-2" style="color: red">Total</td>
                    <td class="subtitle-2" style="color: red">{{ summary.total | toLocaleString }}₫</td>
                  </tr>
                </tbody>
              </v-simple-table>

              <p class="title mt-5">Shipping Address</p>
              <v-simple-table>
                <tbody>
                  <tr>
                    <td>Receiver</td>
                    <td>{{ address.receiver_name }}</td>
                  </tr>
                  <tr>
                    <td>Phone number</td>
                    <td>{{ address.phone_number }}</td>
                  </tr>
                  <tr>
                    <td>Email</td>
                    <td>{{ address.email }}</td>
                  </tr>
                  <tr>
                    <td>Address</td>
                    <td>{{ address.address }}, {{ address.city }}, {{ address.country }}</td>
                  </tr>
                  <tr>
                    <td>Postal code</td>
                    <td>{{ address.zip_code }}</td>
                  </tr>
                </tbody>
              </v-simple-table>

              <p class="title mt-5">Payment Info</p>
              <v-simple-table>
                <tbody>
                  <tr>
                    <td>Payment type</td>
                    <td>Credit card</td>
                  </tr>
                  <tr>
                    <td>Card holder name</td>
                    <td>{{ payment.card_holder }}</td>
                  </tr>
                  <tr>
                    <td>Card number</td>
                    <td>{{ payment.card_number }}</td>
                  </tr>
                  <tr>
                    <td>Valid date</td>
                    <td>{{ payment.valid_date }}</td>
                  </tr>
                </tbody>
              </v-simple-table>
            </v-flex>
          </v-layout>
        </v-container>
      </v-card-text>

      <v-card-actions class="pb-5 pr-3" v-if="!isReadOnly">
        <div class="flex-grow-1"></div>
        <v-btn color="grey" dark text depressed @click="close">Cancel</v-btn>
        <v-btn color="red" dark depressed @click="confirm" :disabled="!summary">Confirm</v-btn>
      </v-card-actions>
      <v-card-actions class="pb-5 pr-3" v-else>
        <div class="flex-grow-1"></div>
        <v-btn color="indigo accent-4" depressed dark @click="close()">OK</v-btn>
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
    isReadOnly: true,
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
      this.isReadOnly = data.isReadOnly;
      this.address = data.address;
      this.payment = data.payment;
      this.summary = data.summary;
      this.dialog = true;
    });
  }
};
</script>
