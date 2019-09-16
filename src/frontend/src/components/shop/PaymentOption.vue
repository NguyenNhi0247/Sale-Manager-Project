<template>
  <v-container fluid class="pa-0 ma-0">
    <v-layout class="mb-10 align-start">
      <v-flex 12 md9 class="pr-5">
        <v-container fluid class="pt-0">
          <v-layout row>
            <v-flex xs12>
               <v-text-field label="Card holder name" />
            </v-flex>
            <v-flex xs12>
               <v-text-field label="Card number" />
            </v-flex>
            <v-flex xs6 class="pr-3">
               <v-text-field label="MM/YY" />
            </v-flex>
            <v-flex xs6 class="pl-3">
               <v-text-field label="CVV" />
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
  </v-container>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";

export default {
  name: "payment-option",
  data: () => ({}),
  computed: {
    ...mapGetters(["orderSummary"])
  },
  methods: {
    ...mapMutations(["backCheckoutStep"]),
    backToCheckoutClicked() {
      this.backCheckoutStep();
    },
    paymentClicked() {
      // TODO
      alert("DONE PAYMENT!")
    }
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
