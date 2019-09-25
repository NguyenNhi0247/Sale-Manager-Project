<template>
  <v-container fluid class="pa-0 ma-0">
    <v-layout class="mb-10 align-start">
      <v-flex 12 md9 class="pr-5">
        <v-container fluid class="pt-0">
          <v-layout row>
            <v-flex xs12>
              <v-text-field label="Card holder name" v-model="payment.card_holder" />
            </v-flex>
            <v-flex xs12>
              <v-text-field label="Card number" v-model="payment.card_number" />
            </v-flex>
            <v-flex xs6 class="pr-3">
              <v-text-field label="MM/YY" v-model="payment.valid_date" />
            </v-flex>
            <v-flex xs6 class="pl-3">
              <v-text-field label="CVV" />
            </v-flex>
            <v-flex xs12>
              <v-tooltip top small>
                <template v-slot:activator="{ on }">
                  <v-btn
                    class="mt-5"
                    color="indigo accent-4"
                    dark
                    depressed
                    @click="saveUserPayment"
                    v-on="on"
                  >Save Payment Info</v-btn>
                </template>
                <span>We won't save your CVV, of course.</span>
              </v-tooltip>
            </v-flex>
          </v-layout>
        </v-container>
      </v-flex>

      <v-divider vertical class="mx-3"></v-divider>
      <v-flex md3 class="pl-5">
        <h2 class="title mb-5">Summary</h2>
        <v-simple-table>
          <tr>
            <td class="body-1">Subtotal</td>
            <td class="body-1">{{ orderSummary.subTotal | toLocaleString }}₫</td>
          </tr>
          <tr>
            <td class="body-1">Shipping fee</td>
            <td class="body-1">+ {{ orderSummary.shippingFee | toShippingFeeText }}</td>
          </tr>
          <tr>
            <td class="body-1">Discount</td>
            <td class="body-1">- {{ orderSummary.discount | toLocaleString }}₫ (5%)</td>
          </tr>

          <v-divider></v-divider>
          <tr class="pt-2">
            <td class="subtitle-1" style="font-weight: 500; color:red">Total</td>
            <td
              class="subtitle-1"
              style="font-weight: 500; color:red"
            >{{ orderSummary.total | toLocaleString }}₫</td>
          </tr>
        </v-simple-table>

        <div class="mt-8">
          <v-btn
            color="grey"
            dark
            depressed
            class="mr-3 text--white"
            @click="backToCheckoutClicked"
          >Back to checkout</v-btn>
          <v-btn color="red" dark depressed @click="paymentClicked">Buy it</v-btn>
        </div>
      </v-flex>
    </v-layout>

    <order-confirm-modal></order-confirm-modal>
  </v-container>
</template>

<script>
import OrderConfirmModal from "../../components/shop/OrderConfirmModal";
import { mapGetters, mapMutations } from "vuex";
import { eventBus } from "../../event";

export default {
  name: "payment-option",
  components: {
    "order-confirm-modal": OrderConfirmModal
  },
  data: () => ({
    payment: {
      type: "card",
      card_number: "",
      card_holder: "",
      valid_date: ""
    }
  }),
  computed: {
    ...mapGetters(["authUser", "orderSummary"])
  },
  methods: {
    ...mapMutations(["backCheckoutStep"]),
    loadUserPayment() {
      this.$http
        .get(
          `/api/v1/users/${this.authUser.username}/payments`,
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("USER PAYMENT", resp.data);
          this.payment = resp.data;
        })
        .catch(err => {
          console.log(
            "Cannot get user payment info. Please create new one first!",
            err
          );
        });
    },
    saveUserPayment() {
      this.payment.user_id = this.authUser.id;
      this.$http
        .put(
          `/api/v1/users/${this.authUser.username}/payments`,
          JSON.stringify(this.payment),
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("USER PAYMENT SAVED", resp.data);
          eventBus.snackbarShown({
            type: "success",
            msg: `User payment saved!`
          });
        })
        .catch(err => {
          this.showError(err, "Cannot save user payment info.");
        });
    },
    backToCheckoutClicked() {
      this.backCheckoutStep();
    },
    paymentClicked() {
      this.$http
        .get(
          `/api/v1/users/${this.authUser.username}/order-info`,
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("USER ORDER INFO", resp.data);
          let order = {
            isReadOnly: false,
            summary: this.cloneObject(this.orderSummary),
            address: resp.data.address,
            payment: resp.data.payment
          };
          eventBus.orderConfirmModalShown(order);
        })
        .catch(err => {
          this.showError(err, "Cannot get user order info.");
        });
    }
  },
  mounted() {
    this.loadUserPayment();
  }
};
</script>

<style scoped>
.basil {
  background-color: #fffbe6 !important;
}
.basil--text {
  color: #356859 !important;
}
.btn-cancel {
  margin-right: 8px;
  /* margin-bottom: 5px; */
  color: white;
}
.btn-next {
  margin-bottom: 0px;
}
</style>
