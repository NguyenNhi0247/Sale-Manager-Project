<template>
  <v-container fluid pb-4>
    <v-layout v-if="user && user.id">
      <v-flex xs4 class="mt-12 mr-3">
        <v-card class="text-center">
          <v-card-text>
            <v-avatar style="margin-top: -60px" size="100" color="orange">
              <!-- TODO <img :src="user.avatar" alt="avatar" /> -->
              <img src="https://avatars2.githubusercontent.com/u/18606262?s=180" alt="avatar" />
            </v-avatar>

            <p class="title mt-3" style="color: #333">{{ user.display_name }}</p>

            <div class="text-left">
              <v-simple-table>
                <tbody>
                  <tr>
                    <td>ID</td>
                    <td>{{ user.id }}</td>
                  </tr>
                  <tr>
                    <td>Username</td>
                    <td>{{ user.username }}</td>
                  </tr>
                  <tr>
                    <td>Email</td>
                    <td>{{ user.email }}</td>
                  </tr>
                  <tr>
                    <td>Date of birth</td>
                    <td>{{ user.date_of_birth }}</td>
                  </tr>
                  <tr>
                    <td>Role</td>
                    <td>{{ user.role | toTextRole }}</td>
                  </tr>
                </tbody>
              </v-simple-table>
            </div>
          </v-card-text>

          <v-card-actions>
            <v-btn text>Share</v-btn>
            <!-- <v-btn text color="purple">Explore</v-btn> -->
            <div class="flex-grow-1"></div>
            <v-btn icon @click="show = !show">
              <v-icon>{{ show ? 'mdi-chevron-up' : 'mdi-chevron-down' }}</v-icon>
            </v-btn>
          </v-card-actions>
          <v-expand-transition>
            <div v-show="show">
              <v-card-text>I'm a thing. But, like most politicians, he promised more than he could deliver. You won't have time for sleeping, soldier, not with all the bed making you'll be doing. Then we'll go with that data file! Hey, you add a one and two zeros to that or we walk! You're going to do his laundry? I've got to find a way to escape.</v-card-text>
            </div>
          </v-expand-transition>
        </v-card>
      </v-flex>

      <!-- <v-divider vertical class="mt-12"></v-divider> -->

      <v-flex xs10 class="ml-5 pb-5">
        <v-layout row>
          <v-flex xs12>
            <h2>Bookshelf</h2>
            <v-container fluid grid-list-md pt-2 px-0 pb-4>
              <v-layout row wrap v-if="purchasedBooks">
                <v-flex d-flex xs4 v-for="book in purchasedBooks" :key="book.id">
                  <book-card :book="book" isPurchased></book-card>
                </v-flex>
              </v-layout>
              <p v-else>No book purchased</p>
            </v-container>
          </v-flex>

          <v-flex xs12 class="mt-8">
            <h2>Order history</h2>
            <v-simple-table v-if="orderHistory">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Total</th>
                  <th>Ordered at</th>
                </tr>
              </thead>
              <tbody>
                <tr
                  v-for="order in orderHistory"
                  :key="order.id"
                  ripple
                  @click="orderClicked(order)"
                >
                  <td>{{ order.id }}</td>
                  <td>{{ order.total | toLocaleString }}₫</td>
                  <td>{{ order.created_at }}</td>
                </tr>
              </tbody>
            </v-simple-table>
            <p v-else>No order history</p>
          </v-flex>
        </v-layout>
      </v-flex>
    </v-layout>

    <order-confirm-modal></order-confirm-modal>
  </v-container>
</template>

<script>
import OrderConfirmModal from "../../components/shop/OrderConfirmModal";
import { eventBus } from "../../event";
import { mapGetters } from "vuex";

import BookCard from "../../components/shop/BookCard";

export default {
  name: "user",
  components: {
    "book-card": BookCard,
    "order-confirm-modal": OrderConfirmModal
  },
  data() {
    return {
      user: null,
      show: false,
      purchasedBooks: null,
      orderHistory: null
    };
  },
  computed: {
    ...mapGetters(["authUser"]),
    isAuth() {
      return this.authUser && this.authUser.id && true;
    }
  },
  filters: {
    toTextRole(val) {
      switch (val) {
        case 0:
          return "System";
        case 1:
          return "Administrator";
        case 2:
          return "Merchant";
        case 3:
          return "Customer";
        default:
          return "Anonymous";
      }
    }
  },
  methods: {
    getUserInfo() {
      if (!this.isAuth) {
        eventBus.snackbarShown({
          type: "error",
          msg: `Please login first!`
        });
        eventBus.loginModalShown();
        return;
      }

      let headers = this.getAuthHeader();
      this.$http
        .get(`/api/v1/users/${this.authUser.username}`, headers)
        .then(resp => {
          console.log("USER INFO", resp.data);
          this.user = resp.data;
        })
        .catch(err => {
          this.showError(err, "Cannot get user info.");
        });
    },
    getPurchasedBooks() {
      if (!this.isAuth) {
        return;
      }
      this.$http
        .get(
          `/api/v1/users/${this.authUser.username}/books`,
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("PURCHASED BOOKS", resp.data);
          this.purchasedBooks = resp.data;
        })
        .catch(err => {
          this.showError(err, "Cannot get user's purchased books.");
        });
    },
    getOrderHistory() {
      if (!this.isAuth) {
        return;
      }
      this.$http
        .get(
          `/api/v1/users/${this.authUser.username}/orders`,
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("ORDER HISTORY", resp.data);
          this.orderHistory = resp.data;
        })
        .catch(err => {
          this.showError(err, "Cannot get user's order history.");
        });
    },
    orderClicked(orderInfo) {
      this.$http
        .get(
          `/api/v1/users/${this.authUser.username}/order-info`,
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("USER ORDER INFO", resp.data);
          let summary = this.cloneObject(orderInfo);
          summary.shippingFee = summary.shipping_fee;
          summary.subTotal =
            summary.total - summary.shippingFee + summary.discount;
          let order = {
            isReadOnly: true,
            summary: summary,
            address: resp.data.address,
            payment: resp.data.payment
          };
          eventBus.orderConfirmModalShown(order);
        })
        .catch(err => {
          this.showError(err, "Cannot get user order info.");
        });
    }
  },
  mounted() {
    this.getUserInfo();
    this.getPurchasedBooks();
    this.getOrderHistory();
  },
  created() {
    eventBus.$on("loginUser", () => {
      this.getUserInfo();
    });
    eventBus.$on("logoutUser", () => {
      this.$router.push({ path: "/" });
    });
  }
};
</script>

<style scoped>
h2 {
  color: #0078d9;
  font-weight: 300;
  font-size: 1.8rem;
}
</style>
