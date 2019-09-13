<template>
  <v-hover v-slot:default="{ hover }">
    <v-card
      class="mx-auto text-center pb-5"
      :elevation="hover ? 3 : 0"
      outlined
      ripple
      @click="cardClicked"
      style="cursor: pointer"
    >
      <v-card-text class="pt-8 caption text-uppercase" style="color: #818ea3">{{ stats.key }}</v-card-text>
      <p class="display-1" style="color: #3d5170">{{ stats.value }}</p>
      <div v-if="stats.trend > 0" class="body-2" style="color: #4CAF50">
        <v-icon color="green" class>mdi-menu-up</v-icon>
        {{ stats.trend }}%
      </div>
      <div v-else-if="stats.trend < 0" class="body-2" style="color: #F44336">
        <v-icon color="red" class>mdi-menu-down</v-icon>
        {{ stats.trend }}%
      </div>
      <div v-else class="body-2" style="color: #818ea3; padding-bottom: 3px">-</div>
    </v-card>
  </v-hover>
</template>

<script>
export default {
  name: "stats-card",
  props: {
    stats: {
      type: Object,
      required: true
    }
  },
  data: () => ({}),
  methods: {
    cardClicked() {
      this.$router.push(this.stats.to);
    }
  }
};
</script>
