<template>
  <div>
    <h2>This is API page</h2>
    <div>
      <p>Username: {{ user.username }}</p>
      <p>Email: {{ user.email }}</p>
      <p>ID: {{ user.id }}</p>
    </div>

    <v-btn color="primary" @click="callAPI">GET</v-btn>
    <v-btn class="ml-3" color="primary" @click="postAPI">POST</v-btn>
  </div>
</template>

<script>
import { axiosConfig } from "../../utils";

export default {
  name: "api",
  data() {
    return {
      user: {}
    };
  },
  methods: {
    callAPI() {
      // Call Backend API: GET /api/v1/json
      this.$http
        .get("/api/v1/json", axiosConfig)
        .then(resp => {
          console.log(resp);
          this.user = resp.data;
        })
        .catch(err => {
          // TODO: Notification
          console.log(err);
        });
    },
    postAPI() {
      let obj = { msg: "hello", age: 11 }; // => `{ "msg": "hello", "age": 11 }`
      // Pass axiosConfig to set the necessary headers for the request.
      // E.g.: Content-Type: application/json
      this.$http
        .post("/api/v1/post", JSON.stringify(obj), axiosConfig)
        .then(resp => {
          console.log(resp);
        })
        .catch(err => {
          // TODO: Notification
          console.log(err);
        });
    }
  }
};
</script>

<style lang="css">
</style>
