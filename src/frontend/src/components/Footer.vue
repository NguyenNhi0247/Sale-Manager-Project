<template>
  <v-footer dark padless>
    <v-container fluid class="ma-0 pa-0">
      <v-layout wrap class="ma-0 pa-0">
        <v-flex xs12>
          <v-card flat tile class="deep-purple accent-4 white--text text-center">
            <v-card-text>
              <v-btn v-for="icon in icons" :key="icon" class="mx-4 white--text" icon>
                <v-icon size="24px">{{ icon }}</v-icon>
              </v-btn>
            </v-card-text>

            <div class="white--text pt-0">
              <h4>CUSTOMER SUPPORT</h4>
              <span style="color:red;">Order hotline:</span> 1800-6963
              <p>(Free, 8-21h including T7, CN)</p>
            </div>

            <v-divider></v-divider>

            <v-card-text class="white--text">
              {{ new Date().getFullYear() }} —
              <strong>Beanies Authors</strong>
            </v-card-text>
          </v-card>
        </v-flex>
      </v-layout>
    </v-container>
  </v-footer>
</template>

<script>
export default {
  name: "my-footer",
  data: () => ({
    icons: [
      "mdi-facebook",
      "mdi-twitter",
      "mdi-google-plus",
      "mdi-linkedin",
      "mdi-instagram"
    ]
  })
};
</script>
