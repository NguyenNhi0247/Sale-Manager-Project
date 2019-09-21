<template>
  <v-container fluid class="pa-0 ma-0">
    <v-layout class="mb-10 align-start">
      <v-flex 12 md9 class="pr-5">
        <v-container fluid class="pt-0">
          <v-layout row>
            <v-flex xs8 class="pr-3">
              <v-text-field label="Receive name" v-model="userAddress.receiver_name" />
            </v-flex>
            <v-flex xs4 class="pl-3">
              <v-text-field label="Email" v-model="userAddress.email" />
            </v-flex>
            <v-flex xs12>
              <v-text-field label="Address" v-model="userAddress.address" />
            </v-flex>
            <v-flex xs6 class="pr-3">
              <v-text-field label="City" v-model="userAddress.city" />
            </v-flex>
            <v-flex xs6 class="pl-3">
              <v-text-field label="Country" v-model="userAddress.country" />
            </v-flex>
            <v-flex xs6 class="pr-3">
              <v-text-field label="Postal code" v-model="userAddress.zip_code" />
            </v-flex>
            <v-flex xs6 class="pl-3">
              <v-text-field label="Phone number" v-model="userAddress.phone_number" />
            </v-flex>
            <v-flex xs12>
              <v-radio-group v-model="radShippingOpt" color="indigo accent-4">
                <v-radio
                  color="indigo accent-3"
                  label="Free shipping between 2-5 working days"
                  value="freeShip"
                ></v-radio>
                <v-radio
                  color="indigo accent-3"
                  label="Next day delivery - 20,000₫ (24 hours from checkout)"
                  value="nextDay"
                ></v-radio>
              </v-radio-group>
            </v-flex>
            <v-flex xs12>
              <v-btn
                color="indigo accent-4"
                dark
                depressed
                @click="saveUserAddress"
              >Save Shipping Info</v-btn>
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
            @click="backToCartClicked"
          >Back to cart</v-btn>
          <v-btn color="indigo accent-4" dark depressed @click="paymentClicked">Payment</v-btn>
        </div>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { mapGetters, mapMutations } from "vuex";
import { eventBus } from "../../event";

export default {
  data() {
    return {
      userAddress: {
        receiver_name: "",
        address: "",
        city: "",
        country: "",
        zip_code: "",
        phone_number: ""
      },
      radShippingOpt: "freeShip"
    };
  },
  computed: {
    ...mapGetters(["authUser", "orderSummary"])
  },
  watch: {
    radShippingOpt(v) {
      let sum = this.cloneObject(this.orderSummary);
      if (v === "nextDay") {
        sum.shippingFee = 20000;
      } else {
        sum.shippingFee = 0;
      }
      sum.total = sum.subTotal + sum.shippingFee - sum.discount;
      this.setOrderSummary(sum);
    }
  },
  methods: {
    ...mapMutations([
      "backCheckoutStep",
      "nextCheckoutStep",
      "setOrderSummary"
    ]),
    loadUserAddress() {
      this.$http
        .get(
          `/api/v1/users/${this.authUser.username}/addresses`,
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("USER ADDRES", resp.data);
          this.userAddress = resp.data;
        })
        .catch(err => {
          console.log(
            "Cannot get user address. Please insert new address!",
            err
          );
        });
    },
    saveUserAddress() {
      // if (!this.$refs.userAddress.validate()) {
      //   return;
      // }
      let data = this.cloneObject(this.userAddress);
      data["user_id"] = this.authUser.id;

      this.$http
        .put(
          `/api/v1/users/${this.authUser.username}/addresses`,
          JSON.stringify(data),
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("USER ADDRESS SAVED", resp.data);
          eventBus.snackbarShown({
            type: "success",
            msg: `User address saved!`
          });
        })
        .catch(err => {
          this.showError(err, "Cannot save user address.");
        });
    },
    backToCartClicked() {
      this.backCheckoutStep();
    },
    paymentClicked() {
      this.nextCheckoutStep();
    }
  },
  mounted() {
    this.loadUserAddress();
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
