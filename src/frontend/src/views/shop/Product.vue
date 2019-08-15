<template>
  <div>
    <h2>Product page: {{ id }}</h2>
    <v-btn @click="getID">ID</v-btn>
  </div>
</template>

<script>

export default {
  data() {
    return {
      id: 0
    }
  },
  methods: {
    getID() {
      this.id = this.$route.params.id
    }  
  }
};
</script>
