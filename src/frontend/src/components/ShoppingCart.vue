<template>
  <v-container fluid class="pa-0 ma-0">
    <v-layout class="mb-10" v-if="cartBooks.length > 0 && cartBookDetails.length > 0">
      <v-flex md9 sm12 class="pr-5">
        <v-container v-for="(book, i) in cartBookDetails" :key="i">
          <v-layout class="align-center">
            <v-flex xs2 @click.stop="toProductPage(book)" ripple style="cursor: pointer">
              <v-img v-if="book.thumbnails" height="100" contain :src="book.thumbnails[0]" />
            </v-flex>
            <v-flex xs6 @click.stop="toProductPage(book)" ripple style="cursor: pointer">
              <p class="subtitle-1" style="color: blue">{{ book.title }}</p>
              <p class="subtitle-2" style="color: #ff3425">{{ book.price | toLocaleString }}₫</p>
            </v-flex>
            <v-flex xd2>
              <v-text-field
                class="quantity-input"
                v-model="book.quantity"
                small
                prepend-icon="mdi-minus"
                append-outer-icon="mdi-plus"
                :value="book.quantity"
                outlined
                @click:append-outer="increment(i)"
                @click:prepend="decrement(i)"
                :rules="[quantityRules.required, quantityRules.isNumeric, quantityRules.valueRange]"
              />
            </v-flex>
            <v-flex xs2>
              <v-btn
                class="mx-2 mt-3"
                small
                text
                color="red"
                @click.native.prevent.stop="removeBookFromCart(book)"
              >
                <v-icon>mdi-trash-can-outline</v-icon>
              </v-btn>
            </v-flex>
          </v-layout>
          <v-divider class="mt-5 mb-0"></v-divider>
        </v-container>
      </v-flex>

      <v-divider vertical class="mx-3"></v-divider>
      <v-flex xs3 class="pl-5">
        <h2 class="title mb-5">Summary</h2>
        <v-simple-table>
          <tr>
            <td class="body-1">Subtotal</td>
            <td class="body-1">{{ summary.subTotal | toLocaleString }}₫</td>
          </tr>
          <tr>
            <td class="body-1">Shipping fee</td>
            <td class="body-1">+ {{ summary.shippingFee | toShippingFeeText }}</td>
          </tr>
          <tr>
            <td class="body-1">Discount</td>
            <td class="body-1">- {{ summary.discount | toLocaleString }}₫ (5%)</td>
          </tr>

          <v-divider></v-divider>
          <tr class="pt-2">
            <td class="subtitle-1" style="font-weight: 500; color:red">Total</td>
            <td
              class="subtitle-1"
              style="font-weight: 500; color:red"
            >{{ summary.total | toLocaleString }}₫</td>
          </tr>
        </v-simple-table>

        <div class="mt-8">
          <v-btn color="grey" dark class="mr-3 text--white" @click="backToShopClicked">Back to shop</v-btn>
          <v-btn color="indigo accent-4" dark @click="checkoutClicked">Checkout</v-btn>
        </div>
      </v-flex>
    </v-layout>

    <v-layout v-else class="text-center">
      <p>No item in cart yet. Please continue your shopping!</p>
    </v-layout>
  </v-container>
</template>

<script>
import { mapMutations } from "vuex";
import { eventBus } from "../event";

export default {
  name: "shopping-cart",
  data() {
    return {
      cartBooks: [],
      cartBookDetails: [],
      summary: {
        subTotal: 0,
        shippingFee: 0,
        discount: 0,
        total: 0
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
  watch: {
    cartBooks(val) {
      this.calcSubTotal(val);
    },
    "summary.subTotal"(val) {
      this.summary.discount = this.summary.subTotal * 0.05; // Hard-coded discount 5%
      this.summary.total =
        this.summary.subTotal +
        this.summary.shippingFee -
        this.summary.discount;
    }
  },
  methods: {
    ...mapMutations(["removeFromCart", "nextCheckoutStep"]),
    listCartItems() {
      // Get list of book IDs in cart
      this.$http
        .get("/api/v1/carts/list", this.getAuthHeader())
        .then(resp => {
          console.log("CHECKOUT CART", resp.data);
          this.cartBooks = resp.data;
          this.calcSubTotal(this.cartBooks);
          this.listCartDetails();
        })
        .catch(err => {
          this.showError(err, "Cannot load list items in cart.");
        });
    },
    listCartDetails() {
      // Get list of book details
      this.$http
        .get("/api/v1/carts", this.getAuthHeader())
        .then(resp => {
          console.log("CHECKOUT CART DETAILS", resp.data);
          this.cartBookDetails = resp.data;

          // Map book quantity from cart to details
          for (let i = 0; i < this.cartBookDetails.length; i++) {
            for (let j = 0; j < this.cartBooks.length; j++) {
              if (this.cartBookDetails[i].id == this.cartBooks[j].book_id) {
                this.cartBookDetails[i].quantity = this.cartBooks[j].quantity;
              }
            }
          }
        })
        .catch(err => {
          this.showError(err, "Cannot load cart details.");
        });
    },
    calcSubTotal(books) {
      this.summary.subTotal = 0;
      for (let i = 0; i < books.length; i++) {
        this.summary.subTotal += books[i].price * books[i].quantity;
      }
    },
    backToShopClicked() {
      this.$router.push({ path: "/" });
    },
    checkoutClicked() {
      this.nextCheckoutStep();
    },
    increment(i) {
      console.log("HIT", i);
      let book = this.cartBookDetails[i];
      if (book.quantity == 100) {
        return;
      }
      book.quantity++;
    },
    decrement(i) {
      let book = this.cartBookDetails[i];
      if (book.quantity === 1) {
        return;
      }
      book.quantity--;
    },
    removeBookFromCart(book) {
      let ret = confirm(`Confirm remove ${book.title} from cart?`);
      if (!ret) {
        return;
      }
      this.$http
        .delete(`/api/v1/carts/books/${book.id}`, this.getAuthHeader())
        .then(resp => {
          console.log("REMOVE ITEM FROM CART", resp.data);
          // Delete success => Remove book from current cart in store cache
          for (let i = 0; i < this.cartBookDetails.length; i++) {
            if (this.cartBookDetails[i].id == book.id) {
              let b = this.cartBookDetails[i];
              let jsBook = {
                book_id: b.id,
                price: b.price,
                quantity: b.quantity
              };
              this.cartBookDetails.splice(i, 1);
              this.removeFromCart(jsBook);
              eventBus.bookRemovedFromCart(jsBook);
            }

            if (this.cartBooks[i].book_id == book.id) {
              this.cartBooks.splice(i, 1); // Remove book from list
            }
          }
        });
    },
    toProductPage(book) {
      this.$router.push({ path: `/product/${book.id}` });
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
    },
    toShippingFeeText(v) {
      if (!v) {
        return "0₫ (free)";
      }
      return v + "₫";
    }
  },
  mounted() {
    this.listCartItems();
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
