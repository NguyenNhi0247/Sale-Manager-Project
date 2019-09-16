<template>
  <v-layout rowjustify-center>
    <v-dialog v-model="dialog" persistent max-width="500px">
      <div>
        <v-tabs
          v-model="tabActive"
          fixed-tabs
          color="indigo accent-4"
          slider-color="indigo accent-4"
        >
          <v-tab v-for="(t, i) in tabs" :key="i">{{ t.text }}</v-tab>
          <!-- Login by local account-->
          <v-tab-item class="pt-3">
            <v-form v-model="localValid" ref="localForm" lazy-validation>
              <v-card>
                <v-card-text class="pt-0 pb-0">
                  <v-container grid-list-md>
                    <v-layout wrap>
                      <v-flex class="pb-0" xs12>
                        <v-text-field
                          :rules="accountLoginRules"
                          v-model="loginLocalForm.account"
                          label="Username / Email"
                          hint="Your username or email address"
                          @keyup.enter="login()"
                          required
                          outlined
                          prepend-inner-icon="mdi-account-circle"
                        ></v-text-field>
                      </v-flex>
                      <v-flex class="pt-0 pb-0" xs12>
                        <v-text-field
                          :rules="passwordRules"
                          v-model="loginLocalForm.password"
                          @keyup.enter="login()"
                          required
                          outlined
                          label="Password"
                          hint="Your password"
                          prepend-inner-icon="mdi-fingerprint"
                          :append-icon="showLoginPwd ? 'mdi-eye-off-outline': 'mdi-eye-outline'"
                          :type="showLoginPwd ? 'text' : 'password'"
                          @click:append="showLoginPwd = !showLoginPwd"
                        ></v-text-field>
                      </v-flex>
                      <v-flex class="pt-0" xs-12 text-xs-right>
                        <a href="TODO">Forgot password</a>
                      </v-flex>
                    </v-layout>
                  </v-container>
                </v-card-text>
                <v-card-actions class="mr-4 pr-3 pb-4">
                  <v-spacer></v-spacer>
                  <v-btn text @click.native="dialog = false">Cancel</v-btn>
                  <v-btn
                    color="indigo accent-4"
                    @click.native="login()"
                    :disabled="!localValid"
                    :loading="isLoginLoading"
                    class="px-3 white--text"
                  >Login</v-btn>
                </v-card-actions>
              </v-card>
            </v-form>
          </v-tab-item>

          <!-- Register account-->
          <v-tab-item class="pt-3">
            <v-form v-model="regValid" ref="regForm" lazy-validation>
              <v-card>
                <v-card-text class="pt-0 pb-0">
                  <v-container grid-list-md>
                    <v-layout wrap>
                      <v-flex class="pb-0" xs12>
                        <v-text-field
                          :rules="accountRegRules"
                          v-model="registerForm.account"
                          label="Username"
                          @keyup.enter="register()"
                          required
                          outlined
                          prepend-inner-icon="mdi-account-circle"
                          autocomplete="false"
                        ></v-text-field>
                      </v-flex>
                      <v-flex class="pt-0 pb-0" xs12>
                        <v-text-field
                          :rules="emailRules"
                          v-model="registerForm.email"
                          label="Email"
                          @keyup.enter="register()"
                          required
                          outlined
                          prepend-inner-icon="mdi-at"
                        ></v-text-field>
                      </v-flex>
                      <v-flex class="pt-0" xs6>
                        <v-text-field
                          :rules="passwordRules"
                          v-model="registerForm.password"
                          label="Password"
                          @keyup.enter="register()"
                          required
                          outlined
                          prepend-inner-icon="mdi-fingerprint"
                          :append-icon="showRegPwd ? 'mdi-eye-off-outline': 'mdi-eye-outline'"
                          :type="showRegPwd ? 'text' : 'password'"
                          @click:append="showRegPwd = !showRegPwd"
                        ></v-text-field>
                      </v-flex>
                      <v-flex class="pt-0" xs6>
                        <v-text-field
                          :rules="rePasswordRules"
                          v-model="registerForm.rePassword"
                          label="Re-type password"
                          type="password"
                          @keyup.enter="register()"
                          required
                          outlined
                        ></v-text-field>
                      </v-flex>
                    </v-layout>
                  </v-container>
                </v-card-text>
                <v-card-actions class="mr-4 pr-3 pb-4">
                  <v-spacer></v-spacer>
                  <v-btn text @click.native="dialog = false">Cancel</v-btn>
                  <v-btn
                    color="indigo accent-4"
                    @click.native="register()"
                    :disabled="!regValid"
                    :loading="isRegLoading"
                    class="px-3 white--text"
                  >Register</v-btn>
                </v-card-actions>
              </v-card>
            </v-form>
          </v-tab-item>
        </v-tabs>
      </div>
    </v-dialog>
  </v-layout>
</template>

<script>
import { axiosConfig } from "../../utils";
import { eventBus } from "../../event";
import { mapMutations } from "vuex";

const allowedCharsRegex = /^[a-zA-z0-9]+$/;

export default {
  name: "login-modal",
  data() {
    return {
      dialog: false,
      localValid: false,
      regValid: false,
      showLoginPwd: false,
      showRegPwd: false,
      isRegLoading: false,
      isLoginLoading: false,
      accountRegRules: [
        v => !!v || "Username is required",
        v =>
          !(v.length < 4 || v.length > 32) ||
          "Username length must >= 4 and <= 32 chars",
        v =>
          allowedCharsRegex.test(v) ||
          "Username can contain only alphabets [A-Za-z] and numbers [0-9]"
      ],
      accountLoginRules: [
        v => !!v || "Username/Email is required",
        v =>
          allowedCharsRegex.test(v) ||
          this.isValidEmail(v) ||
          "Username contains invalid character(s) or not a valid email address"
      ],
      emailRules: [
        v => !!v || "Email is required",
        v => this.isValidEmail(v) || "Email is invalid",
        v => !(v.length > 254) || "Email length must less than 254 chars"
      ],
      passwordRules: [
        v => !!v || "Password is required",
        v =>
          !(v.length < 6 || v.length > 32) ||
          "Password length must >= 6 and <= 32 chars"
      ],
      rePasswordRules: [
        v => !!v || "Password is required",
        v =>
          !(v.length < 6 || v.length > 32) ||
          "Password length must >= 6 and <= 32 chars",
        v => !(v !== this.registerForm.password) || "Re-type password not match"
      ],
      loginLocalForm: {
        account: "",
        password: ""
      },
      registerForm: {
        account: "",
        email: "",
        password: "",
        rePassword: ""
      },
      tabActive: 0,
      tabs: [{ name: 0, text: "Login" }, { name: 1, text: "Register" }]
    };
  },
  watch: {
    dialog(val) {
      if (!val) {
        this.clearForms(); // Clear old data before closing dialog
      }
    }
  },
  methods: {
    ...mapMutations(["setAuthUser", "setSettings", "setAvatar", "setAuthUser"]),
    login() {
      if (!this.$refs.localForm.validate()) {
        return;
      }
      let data = this.cloneObject(this.loginLocalForm);

      this.isLoginLoading = true;
      this.$http
        .post("/api/v1/login", data, axiosConfig)
        .then(resp => {
          this.isLoginLoading = false;
          console.log("auth", resp.data);
          this.setCookie("beanies_token", resp.data.token);

          this.whoami(); // Load user detail and store to cookie
        })
        .catch(err => {
          console.log("ERR", err.response);
          this.isLoginLoading = false;
          let em = err.message;
          if (err && err.response) {
            em = err.response.data.message;
          }
          eventBus.snackbarShown({
            type: "error",
            msg: `Login failed. ${em}`
          });
        });
    },
    register() {
      // Local registration with username/email/password
      if (!this.$refs.regForm.validate()) {
        return;
      }
      this.isRegLoading = true;
      let data = {
        username: this.registerForm.account,
        email: this.registerForm.email,
        password: this.registerForm.password
      };

      this.$http
        .post("/api/v1/register", data, axiosConfig)
        .then(res => {
          console.log("REG", res.data);
          this.isRegLoading = false;
          eventBus.snackbarShown({
            // TODO
            type: "success",
            msg: "Account created. Please login!"
          });
          this.tabActive = 0;
        })
        .catch(err => {
          this.isRegLoading = false;
          this.showError(err, "Register failed.");
        });
    },
    whoami() {
      let headers = this.getAuthHeader();
      this.$http
        .get("/api/v1/users/whoami", headers)
        .then(resp => {
          console.log(resp);

          let user = {
            id: resp.data.id,
            username: resp.data.username,
            role: resp.data.role,
            display_name: resp.data.display_name
          };
          this.setAuthUser(user);
          this.setCookie("beanies_user", window.btoa(JSON.stringify(user)));

          eventBus.snackbarShown({
            type: "success",
            msg: `Welcome back, ${user.display_name}!`
          });
          eventBus.userLoggedIn(); // Notify other components to update if necessary
          this.dialog = false;
        })
        .catch(err => {
          this.showError(err, "Cannot load user information.");
        });
    },
    clearForms() {
      this.loginLocalForm = {
        account: "",
        password: ""
      };
      this.registerForm = {
        account: "",
        email: "",
        password: "",
        rePassword: ""
      };
    },
    clearError() {
      console.log(this);
    }
  },
  created() {
    eventBus.$on("showLoginModal", () => {
      this.dialog = true;
    });
  }
};
</script>

<style>
</style>
