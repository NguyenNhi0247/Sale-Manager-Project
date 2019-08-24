<template>
  <div>
    <v-card color="basil">
    <v-card-title class="text-center justify-center py-6">
      <h2 class="font-weight-bold display-3 basil--text">Checkout Page</h2>
    </v-card-title>

    <v-tabs
      v-model="tab"
      background-color="transparent"
      color="basil"
      grow
    >
      <v-tab>
        1. Shopping Cart
      </v-tab>
      <v-tab>
        2. Shopping Details
      </v-tab>
      <v-tab>
        3. Payment Options
      </v-tab>
    </v-tabs>

    <v-tabs-items v-model="tab">
      <v-tab-item>
        <v-card flat color="basil">
          <v-card-text>
            <v-layout
              row
              wrap
              class="ml-5 mb-10 mr-10" v-if="selectedBook.length > 0">
              <v-flex
                md8
                sm12 >
                <h2 class="title font-weight-light mb-4"><b>Shopping Cart</b></h2>
                <hr width="580">
                <v-simple-table v-for="book in selectedBook" :key="book.id">
                  <tr>
                    <td>
                      <v-img height="100" width="100" :src="book.thumbnails[0]" />

                    </td>
                    <td width="250">
                      <h4><p style="color:blue">{{ book.title }}</p></h4>
                      <p>{{ book.description }}</p>
                      <h3><p style="color:red">{{ book.price | toLocaleString }} VND</p></h3>

                    </td>
                    <td>
                      <div class="quantity-toggle">
                        <v-btn @click="decrement()">&mdash;</v-btn>
                        <input style="width: 30px;padding-left: 5px;" type="text" :value="quantity" readonly />
                        <v-btn @click="increment()">&#xff0b;</v-btn>
                      </div>
                    </td>
                  </tr>
                  
              </v-simple-table>
                
              </v-flex>

              <v-flex
                md4
                sm12
                >
                <h2 class="title font-weight-light mb-5"><b>Summary</b></h2>
                <hr width="300" class="mb-2">
                 <v-simple-table>
                  <tr>
                    <td>
                      <h3>SUBTOTAL</h3>
                    </td>
                    <td>
                      600
                    </td>
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
                      <h3><p style='color:red'> TOTAL</p></h3>
                    </td>
                    <td>
                      <h2><p style='color:red'> 613$</p></h2>
                    </td>
                   
                  </tr>
              </v-simple-table>
              </v-flex>
            </v-layout>
              <v-btn color="primary" class='mr-5'>Next</v-btn>
              <v-btn color="red">Cancel</v-btn>
            

          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>

    <v-tabs-items v-model="tab">
      <v-tab-item>
        <v-card flat color="basil">
          <v-card-text>
            <v-layout
              row
              wrap
              class="ml-5 mb-10 mr-10" v-if="selectedBook.length > 0">
              <v-flex
                md8
                sm12 >
                <h2 class="title font-weight-light mb-4"><b>Shopping Cart</b></h2>
                <hr width="580">
                <v-simple-table v-for="book in selectedBook" :key="book.id">
                  <tr>
                    <td>
                      <v-img height="100" width="100" :src="book.thumbnails[0]" />

                    </td>
                    <td width="250">
                      <h4><p style="color:blue">{{ book.title }}</p></h4>
                      <p>{{ book.description }}</p>
                      <h3><p style="color:red">{{ book.price | toLocaleString }} VND</p></h3>

                    </td>
                    <td>
                      <div class="quantity-toggle">
                        <v-btn @click="decrement()">&mdash;</v-btn>
                        <input style="width: 30px;padding-left: 5px;" type="text" :value="quantity" readonly />
                        <v-btn @click="increment()">&#xff0b;</v-btn>
                      </div>
                    </td>
                  </tr>
                  
              </v-simple-table>
                
              </v-flex>

              <v-flex
                md4
                sm12
                >
                <h2 class="title font-weight-light mb-5"><b>Summary</b></h2>
                <hr width="300" class="mb-2">
                 <v-simple-table>
                  <tr>
                    <td>
                      <h3>SUBTOTAL</h3>
                    </td>
                    <td>
                      600
                    </td>
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
                      <h3><p style='color:red'> TOTAL</p></h3>
                    </td>
                    <td>
                      <h2><p style='color:red'> 613$</p></h2>
                    </td>
                   
                  </tr>
              </v-simple-table>
              </v-flex>
            </v-layout>
              <v-btn color="primary" class='mr-5'>Next</v-btn>
              <v-btn color="red">Cancel</v-btn>
            

          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>

    <v-tabs-items v-model="tab">
      <v-tab-item>
        <v-card flat color="basil">
          <v-card-text>
            <v-layout
              row
              wrap
              class="ml-5 mb-10 mr-10">
              <v-flex
                md8
                sm12 >
                <h2 class="title font-weight-light mb-4"><b>Shipping Details</b></h2>
                <hr width="580">
                
                <v-flex
                  xs12
                  md4
                >
                  <v-text-field
                    label="First Name"
                    class="purple-input"/>
                </v-flex>
                <v-flex
                  xs12
                  md6
                >
                  <v-text-field
                    label="Last Name"
                    class="purple-input"/>
                </v-flex>
                <v-flex
                  xs12
                  md12
                >
                  <v-text-field
                    label="Adress"
                    class="purple-input"/>
                </v-flex>
                <v-flex
                  xs12
                  md4>
                  <v-text-field
                    label="City"
                    class="purple-input"/>
                </v-flex>
                <v-flex
                  xs12
                  md4>
                  <v-text-field
                    label="Country"
                    class="purple-input"/>
                </v-flex>
                <v-flex
                  xs12
                  md4>
                  <v-text-field
                    class="purple-input"
                    label="Postal Code"
                    type="number"/>
                </v-flex>
                
                  <v-btn
                    class="mx-0 font-weight-light"
                    color="success"
                  >
                    Update Profile
                  </v-btn>
                </v-flex>
    
                
              </v-flex>

              <v-flex
                md4
                sm12
                >
                <h2 class="title font-weight-light mb-5"><b>Summary</b></h2>
                <hr width="300" class="mb-2">
                 <v-simple-table>
                  <tr>
                    <td>
                      <h3>SUBTOTAL</h3>
                    </td>
                    <td>
                      600
                    </td>
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
                      <h3><p style='color:red'> TOTAL</p></h3>
                    </td>
                    <td>
                      <h2><p style='color:red'> 613$</p></h2>
                    </td>
                   
                  </tr>
              </v-simple-table>
              </v-flex>
            </v-layout>
              <v-btn color="primary" class='mr-5'>Next</v-btn>
              <v-btn color="red">Cancel</v-btn>
            

          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </v-card>
  </div>
</template>

<script>
import { axiosConfig } from "../../utils";

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
    };
  },
  mounted() {
    this.id = this.$route.params.id;
    this.$http
      .get('api/v1/books?limit=5&offset=20', axiosConfig)
      .then(resp => {
        console.log(resp.data);
        this.selectedBook = resp.data;
      })
      .catch(err => {
        console.log(err);
      });
  },
  methods: {

    increment() {
      this.quantity++;
    },
    decrement() {
      if (this.quantity === 1) {
        alert("Quantity not allowed");
      } else {
        this.quantity--;
      }
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
  background-color: #FFFBE6 !important;
  }
  .basil--text {
    color: #356859 !important;
  }
</style>
