<template>
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
                        <td>{{ Order.total_price }}</td>
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
                          <h3>DISCOUNT</h3>
                        </td>
                        <td>{{ Order.discount }}</td>
                      </tr>

                      <tr class="pt-2">
                        <td>
                          <h3>
                            <p style="color:red">TOTAL</p>
                          </h3>
                        </td>
                        <td>
                          <h2>
                            <p style="color:red">{{ Order.final_price }}</p>
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
                <v-btn color="primary" class="btn-next">Next</v-btn>
              </div>
            </v-card-text>
          </v-card>
</template>

<script>


export default {
    name: "shopping-cart",
  data() {
    return {
      selectedBook: {
        thumbnails: [],
        authors: []
      },
      Order:{
        total_price :0,
        discount: 0,
        final_price: 0
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
      console.log("+++")
      console.log(quantity)
      total_price = 0

      for (let i = 0; i < this.selectedBook.length; i++) {
            total_price = total_price + this.selectedBook[i].price*quantity
          }
    });

    // this.$http.get("/api/v1/carts/get-order", headers).then(resp => {
    //   this.Order = resp.data;
    // });
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
        .delete(`/api/v1/carts?book_id=${book.id}`, headers)
        .then(resp => {
          console.log(resp);
          // Delete success => Remove book from current cart in store cache
          for (let i = 0; i < this.selectedBook.length; i++) {
            if (this.selectedBook[i].id == book.id) {
              this.selectedBook.splice(i, 1); // Remove book from list
            }
          }
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