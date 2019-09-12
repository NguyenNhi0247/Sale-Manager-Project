<template>
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
</template>

<script>
export default {
  name: "payment-option"
}
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