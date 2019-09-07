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
          <v-card flat>
            <v-card-text>
              <v-layout row wrap class="ml-5 mb-10 mr-10" v-if="selectedBook.length > 0">
                <v-flex md8 sm12>
                  <h2 class="title font-weight-light mb-4">
                    <b>Shopping Cart</b>
                  </h2>
                  <!-- <hr width="700" class="mb-5"> -->
                  <v-card class="mt-5" max-width="700" outlined>
                    <v-simple-table v-for="book in selectedBook" :key="book.id">
                      <tr>
                        <td>
                          <v-flex offset-2 xs4>
                            <v-img height="120" width="120" contain :src="book.thumbnails[0]" />
                          </v-flex>
                        </td>
                        <td width="300">
                          <h4>
                            <p style="color:blue">{{ book.title }}</p>
                          </h4>
                          <!-- <p>{{ book.description }}</p> -->
                          <h3>
                            <p style="color:red">{{ book.price | toLocaleString }} VND</p>
                          </h3>
                        </td>
                        <td>
                          <v-flex>
                            <v-text-field
                              class="quantity-input"
                              v-model="quantity"
                              small
                              prepend-icon="mdi-minus"
                              append-outer-icon="mdi-plus"
                              :value="quantity"
                              outlined
                              @click:append-outer="increment"
                              @click:prepend="decrement"
                              :rules="[quantityRules.required, quantityRules.isNumeric, quantityRules.valueRange]"
                            />
                          </v-flex>
                        </td>
                        <td>
                          <v-btn
                            class="mx-2"
                            fab
                            dark
                            small
                            color="red"
                            @click.native.prevent.stop="removefromCart(book)"
                          >
                            <v-icon dark>mdi-window-close</v-icon>
                          </v-btn>
                        </td>
                      </tr>
                    </v-simple-table>
                  </v-card>
                </v-flex>

                <v-flex md4 sm12>
                  <h2 class="title font-weight-light mb-5">
                    <b>Summary</b>
                  </h2>
                  <!-- <hr width="350" class="mb-4"> -->
                  <v-card class max-width="344" outlined>
                    <v-simple-table>
                      <tr>
                        <td>
                          <h3>SUBTOTAL</h3>
                        </td>
                        <td>600</td>
                      </tr>
                      <tr>
                        <td>
                          <h3>SHIPPING</h3>
                        </td>
                        <td>
                          <h3>FREE</h3>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <h3>TAXES</h3>
                        </td>
                        <td>13$</td>
                      </tr>

                      <tr class="pt-2">
                        <td>
                          <h3>
                            <p style="color:red">TOTAL</p>
                          </h3>
                        </td>
                        <td>
                          <h2>
                            <p style="color:red">613$</p>
                          </h2>
                        </td>
                      </tr>
                    </v-simple-table>
                  </v-card>
                </v-flex>
              </v-layout>
              <!-- <hr width="720" class="mb-5"> -->
              <div class="ml-10">
                <v-btn color="red" class="btn-cancel">Cancel</v-btn>
                <v-btn color="primary" class="btn-next">Pay Now</v-btn>
              </div>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <!-- Shipping Details tab -->

        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-layout row wrap class="ml-5 mb-10 mr-10">
                <v-flex md8 sm12>
                  <h2 class="title font-weight-light mb-4">
                    <b>Shipping Details</b>
                  </h2>
                  <!-- <hr width="810" class="mb-3"> -->
                  <v-card class="mt-5" max-width="800" outlined>
                    <v-simple-table>
                      <tr>
                        <td width="500">
                          <v-text-field label="First Name" />
                        </td>
                        <td>
                          <v-text-field label="Last Name" />
                        </td>
                      </tr>
                      <tr>
                        <v-text-field class="ml-4 mr-4" label="Address" />
                      </tr>
                      <tr>
                        <td>
                          <v-text-field label="Country" />
                        </td>
                        <td>
                          <v-text-field label="City" />
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <v-text-field label="Postal Code" type="number" />
                        </td>
                        <td>
                          <v-text-field label="Phone Number" />
                        </td>
                      </tr>
                      <tr>
                        <v-radio-group v-model="row" row>
                          <td>
                            <v-hover>
                              <v-cart>
                                <v-radio
                                  label="Free Shipping Betwwen 2-5 working days"
                                  value="radio-1"
                                ></v-radio>
                              </v-cart>
                            </v-hover>
                          </td>
                          <td>
                            <v-hover>
                              <v-cart>
                                <v-radio
                                  label="NextDay Delivery - 20,000VND 24 hours from checkout"
                                  value="radio-2"
                                ></v-radio>
                              </v-cart>
                            </v-hover>
                          </td>
                        </v-radio-group>
                      </tr>
                    </v-simple-table>
                  </v-card>
                  <div class="ml-5 mt-10">
                    <v-btn color="red" class="btn-cancel">Cancel</v-btn>
                    <v-btn color="primary" class="btn-next">Next</v-btn>
                  </div>
                </v-flex>

                <v-flex md4 sm12>
                  <h2 class="title font-weight-light mb-4">
                    <b>Summary</b>
                  </h2>
                  <!-- <hr width="400" class="mb-4"> -->
                  <v-simple-table v-for="book in selectedBook" :key="book.id">
                    <tr class="mb-0 mt-0">
                      <td class="pb-3" width="100">
                        <v-flex offset-2 xs4>
                          <v-img height="80" width="120" contain :src="book.thumbnails[0]" />
                        </v-flex>
                      </td>
                      <td>
                        <h4>
                          <p style="color:blue">{{ book.title }}</p>
                        </h4>
                        <h3>
                          <p style="color:red">{{ book.price | toLocaleString }} VND</p>
                        </h3>
                      </td>
                    </tr>
                  </v-simple-table>
                  <!-- <hr width="400" class="mb-4"> -->
                  <v-card class="ml-5" max-width="350" outlined>
                    <v-simple-table>
                      <tr>
                        <td>
                          <h3>SUBTOTAL</h3>
                        </td>
                        <td>600</td>
                      </tr>
                      <tr>
                        <td>
                          <h3>SHIPPING</h3>
                        </td>
                        <td>
                          <h3>FREE</h3>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <h3>TAXES</h3>
                        </td>
                        <td>13$</td>
                      </tr>

                      <tr class="pt-2">
                        <td>
                          <h3>
                            <p style="color:red">TOTAL</p>
                          </h3>
                        </td>
                        <td>
                          <h2>
                            <p style="color:red">613$</p>
                          </h2>
                        </td>
                      </tr>
                    </v-simple-table>
                  </v-card>
                </v-flex>
                <!-- <hr width="810" class="mb-0"> -->
              </v-layout>
            </v-card-text>
          </v-card>
        </v-tab-item>

        <!-- Payment Options-->

        <v-tab-item>
          <v-card flat>
            <v-card-text>
              <v-layout row wrap class="ml-5 mb-10 mr-10">
                <v-flex md8 sm12>
                  <h2 class="title font-weight-light mb-4">
                    <b>Payment Method</b>
                  </h2>
                  <!-- <hr width="810" class="mb-4"> -->
                  <!--<v-radio-group >-->
                  <v-card class="mt-5 mr-10">
                    <v-simple-table class="pb-10">
                      <tr width="500">
                        <v-radio label="Credit Cart" value="credit-cart" class="mr-3 mt-6 ml-3"></v-radio>
                        <!-- <p class="ml-10"> Pay with Credit Cart </p> -->
                      </tr>
                      <tr>
                        <td width="500">
                          <v-text-field label="0000  0000  0000  0000" />
                        </td>
                        <td>
                          <v-text-field label="MM/YY" />
                        </td>
                        <td>
                          <v-text-field label="CVV" />
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <v-text-field label="Cart Holder Name" />
                        </td>
                      </tr>
                    </v-simple-table>
                  </v-card>

                  <!-- <hr width="810" class="mt-6"> -->

                  <v-card class="mt-6 mr-10">
                    <v-simple-table>
                      <tr>
                        <td width="600">
                          <v-radio label="Payal" value="payment" class="mr-3 mt-4 ml-3 mb-4"></v-radio>
                          <!-- <p class="ml-10"> Pay by Paypal</p> -->
                        </td>

                        <td>
                          <v-img
                            width="100"
                            height="30"
                            src="https://cdn.pixabay.com/photo/2015/05/26/09/37/paypal-784404_960_720.png"
                          />
                        </td>
                      </tr>
                    </v-simple-table>
                  </v-card>

                  <v-card class="mt-6 mr-10">
                    <v-simple-table>
                      <tr>
                        <td width="600">
                          <v-radio label="Cash" value="cash" class="mr-3 mt-4 ml-3 mb-4"></v-radio>
                          <!-- <p class="ml-10"> Pay by Paypal</p> -->
                        </td>

                        <td>
                          <v-img
                            width="100"
                            height="30"
                            src="https://www.marondahomes.com/blog/wp-content/uploads/2015/10/holding-money.jpg"
                          />
                        </td>
                      </tr>
                    </v-simple-table>
                  </v-card>

                  <div class="ml-5 mt-10">
                    <v-btn color="red" class="btn-cancel">Cancel</v-btn>
                    <v-btn color="primary" class="btn-next">Pay Now</v-btn>
                  </div>
                  <!--</v-radio-group>-->
                </v-flex>

                <v-flex md4 sm12>
                  <h2 class="title font-weight-light mb-4">
                    <b>Summary</b>
                  </h2>
                  <!-- <hr width="400" class="mb-4"> -->
                  <v-simple-table v-for="book in selectedBook" :key="book.id">
                    <tr class="mb-0 mt-0">
                      <td class="pb-3" width="100">
                        <v-flex offset-2 xs4>
                          <v-img height="80" width="120" contain :src="book.thumbnails[0]" />
                        </v-flex>
                      </td>
                      <td>
                        <h4>
                          <p style="color:blue">{{ book.title }}</p>
                        </h4>
                        <h3>
                          <p style="color:red">{{ book.price | toLocaleString }} VND</p>
                        </h3>
                      </td>
                    </tr>
                  </v-simple-table>
                  <!-- <hr width="400" class="mb-4"> -->
                  <v-card class="ml-5" max-width="350" outlined>
                    <v-simple-table>
                      <tr>
                        <td>
                          <h3>SUBTOTAL</h3>
                        </td>
                        <td>600</td>
                      </tr>
                      <tr>
                        <td>
                          <h3>SHIPPING</h3>
                        </td>
                        <td>
                          <h3>FREE</h3>
                        </td>
                      </tr>
                      <tr>
                        <td>
                          <h3>TAXES</h3>
                        </td>
                        <td>13$</td>
                      </tr>

                      <tr class="pt-2">
                        <td>
                          <h3>
                            <p style="color:red">TOTAL</p>
                          </h3>
                        </td>
                        <td>
                          <h2>
                            <p style="color:red">613$</p>
                          </h2>
                        </td>
                      </tr>
                    </v-simple-table>
                  </v-card>
                </v-flex>
                <!-- <hr width="810" class="mb-0"> -->
              </v-layout>
            </v-card-text>
          </v-card>
        </v-tab-item>
      </v-tabs-items>
    </v-card>
  </div>
</template>

<script>
// import { axiosConfig } from "../../utils";

export default {
  data() {
    return {
      selectedBook: {
        thumbnails: [],
        authors: []
      },
      quantity: 1,
      tab: null,
      VtextField: null,
      quantityRules: {
        required: value => !!value || "Required.",
        isNumeric: value => !isNaN(value) || "Number only",
        valueRange: value =>
          (parseInt(value) >= 1 && parseInt(value) <= 100) || "1-100"
      }
    };
  },
  mounted() {
    let headers = this.getAuthHeader();
    this.$http.get("/api/v1/carts", headers).then(resp => {
      this.selectedBook = resp.data;
    });
  },
  methods: {
    increment() {
      if (this.quantity == 100) {
        return;
      }
      this.quantity++;
    },
    decrement() {
      if (this.quantity === 1) {
        return;
      }
      this.quantity--;
    },

    removefromCart(book) {
      // GET, POST, DELETE
      let headers = this.getAuthHeader();
      this.$http
        .delete("/api/v1/carts", JSON.stringify({ book_id: book.id }), headers)
        .then(resp => {
          console.log(resp);
        });
    }
  },
  filters: {
    // Convert v to its location form, return v itself if it's not a number.
    // E.g.: 50000 => 50,000
    toLocaleString(v) {
      if (isNaN(v)) {
        return v;
      }
      return v.toLocaleString();
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
