<template>
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
                          <v-text-field 
                          label="Receive Name"
                          v-model="UserAddressForm.receiver_name"
                          @keyup.enter="addUserAddress()" />
                        </td>
                        <!-- <td>
                          <v-text-field 
                          label="Last Name"
                          v-model="UserAddressForm.last_name"
                          @keyup.enter="addUserAddress()" />
                        </td> -->
                      </tr>
                      <tr>
                        <v-text-field class="ml-4 mr-4" label="Address"
                        v-model="UserAddressForm.address"
                        @keyup.enter="addUserAddress()" />
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
                          <v-text-field label="Postal Code"
                          v-model="UserAddressForm.zip_code"
                          @keyup.enter="addUserAddress()"
                           type="number" />
                        </td>
                        <td>
                          <v-text-field label="Phone Number"
                          v-model="UserAddressForm.phone_number"
                          @keyup.enter="addUserAddress()" />
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
                    <v-btn color="primary" class="btn-next" @click.native="addUserAddress()">Pay Now</v-btn>
                  </div>
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
  data() {
    return {
      tab: null,
      UserAddressForm:{
        receiver_name: "",
        address:"",
        zip_code:"",
        phone_number:""
      }
    }   
  },
  methods: {
    addUserAddress() {
      if (!this.$refs.UserAddressForm.validate()) {
        return;
      }
      let data = this.cloneObject(this.UserAddressForm);

      let headers = this.getAuthHeader();
      this.$http
        .post("/api/v1/user_address", data, headers)
        .then(resp => {
          console.log(resp.data);

        })
        .catch(err => {
          console.log("ERR", err.response)
      });
    },
  }
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
