<template>
  <div>
    <v-card>
      <v-tabs v-model="tab" background-color="transparent" grow class="mt-3">
        <v-tab>1. Shopping Cart</v-tab>
        <v-tab>2. Shopping Details</v-tab>
        <v-tab>3. Payment Options</v-tab>
      </v-tabs>

      <v-tabs-items v-model="tab">
        <!--Shopping Cart tab-->

        <v-tab-item>
          <ShoppingCart></ShoppingCart>
        </v-tab-item>

        <!-- Shipping Details tab -->

        <v-tab-item>
          <ShoppingDetail></ShoppingDetail>
        </v-tab-item>

        <!-- Payment Options-->

        <v-tab-item>
          <PaymentOption></PaymentOption>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
import ShoppingCart from "../../components/ShoppingCart";
import ShoppingDetail from "../../components/ShoppingDetail";
import PaymentOption from "../../components/PaymentOption";

export default {
  data() {
    return {
      tab: null
    };
  },
  components: {
    "ShoppingCart": ShoppingCart,
    "ShoppingDetail": ShoppingDetail,
    "PaymentOption": PaymentOption,
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
