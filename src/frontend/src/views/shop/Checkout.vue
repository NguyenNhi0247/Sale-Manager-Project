<template>
  <v-container fluid class="pa-0 ma-0">
    <v-layout>
      <v-flex xs12>
        <v-stepper :value="checkoutStep" class="pt-3" color="indigo accent-4">
          <v-stepper-header class="elevation-0" style="padding: 0 200px">
            <v-stepper-step :complete="checkoutStep > 1" step="1">Checkout cart</v-stepper-step>
            <v-divider></v-divider>
            <v-stepper-step :complete="checkoutStep > 2" step="2">Shipping address</v-stepper-step>
            <v-divider></v-divider>
            <v-stepper-step step="3">Payment</v-stepper-step>
          </v-stepper-header>

          <v-stepper-items>
            <v-stepper-content step="1">
              <ShoppingCart></ShoppingCart>
            </v-stepper-content>
            <v-stepper-content step="2">
              <ShoppingDetail></ShoppingDetail>
            </v-stepper-content>
            <v-stepper-content step="3">
              <PaymentOption></PaymentOption>
            </v-stepper-content>
          </v-stepper-items>
        </v-stepper>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import ShoppingCart from "../../components/ShoppingCart";
import ShoppingDetail from "../../components/ShoppingDetail";
import PaymentOption from "../../components/PaymentOption";
import { mapGetters } from "vuex";

export default {
  data() {
    return {};
  },
  components: {
    ShoppingCart: ShoppingCart,
    ShoppingDetail: ShoppingDetail,
    PaymentOption: PaymentOption
  },
  computed: {
    ...mapGetters(["checkoutStep"])
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

<style>
/* .v-text-field--outlined fieldset,.v-input__slot fieldset {
  height: 40px !important;
} */

.quantity-input {
  max-width: 120px;
  padding-left: 10px;
}

.quantity-input,
.quantity-input fieldset {
  height: 40px !important;
}

.quantity-input .v-input__slot {
  margin-top: 10px;
}

.quantity-input .v-text-field__slot input {
  padding-top: 0;
  padding-bottom: 16px;
  padding-left: 10px;
}
</style>
