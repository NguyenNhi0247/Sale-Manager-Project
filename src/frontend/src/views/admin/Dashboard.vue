<template>
  <v-container fluid class="ma-0 pa-0">
    <!-- Statistics cards -->
    <v-layout d-flex justify-space-between class="mx-n1">
      <v-flex xs3 class="ml-1 mr-1" v-for="item in stats" :key="item.id">
        <stats-card :stats="item"></stats-card>
      </v-flex>
    </v-layout>

    <!-- Charts -->
    <v-layout d-flex justify-space-between class="mt-5">
      <v-flex xs8 class="mr-1">
        <v-card outlined>
          <v-container>
            <v-layout>
              <v-flex xs3>
                <p class="caption text-uppercase pt-4" style="color: #818ea3">Revenue over orders</p>
              </v-flex>
              <v-spacer></v-spacer>
              <v-flex xs2>
                <v-menu
                  ref="dpMenuStart"
                  v-model="dpMenuStart"
                  :close-on-content-click="false"
                  :return-value.sync="dpInputStart"
                  transition="scale-transition"
                  offset-y
                >
                  <template v-slot:activator="{ on }">
                    <v-text-field
                      v-model="dpInputStart"
                      label="Start date"
                      readonly
                      flat
                      height="20px"
                      v-on="on"
                      reverse
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="dpInputStart" no-title scrollable>
                    <div class="flex-grow-1"></div>
                    <v-btn text color="primary" @click="dpMenuStart = false">Cancel</v-btn>
                    <v-btn text color="primary" @click="$refs.dpMenuStart.save(dpInputStart)">OK</v-btn>
                  </v-date-picker>
                </v-menu>
              </v-flex>

              <v-flex xs2 class="ml-3">
                <v-menu
                  ref="dpMenuEnd"
                  v-model="dpMenuEnd"
                  :close-on-content-click="false"
                  :return-value.sync="dpInputEnd"
                  transition="scale-transition"
                  offset-y
                >
                  <template v-slot:activator="{ on }">
                    <v-text-field
                      v-model="dpInputEnd"
                      label="End date"
                      readonly
                      flat
                      height="20px"
                      v-on="on"
                      reverse
                    ></v-text-field>
                  </template>
                  <v-date-picker v-model="dpInputEnd" no-title scrollable>
                    <div class="flex-grow-1"></div>
                    <v-btn text color="primary" @click="dpMenuEnd = false">Cancel</v-btn>
                    <v-btn text color="primary" @click="$refs.dpMenuEnd.save(dpInputEnd)">OK</v-btn>
                  </v-date-picker>
                </v-menu>
              </v-flex>
            </v-layout>

            <v-divider></v-divider>

            <v-layout class="mt-3">
              <v-flex xs12>
                <line-chart :chartData="chartData" :options="chartOpts"></line-chart>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card>
      </v-flex>

      <v-flex xs4 class="ml-1">
        <v-card outlined>
          <v-container>
            <p class="caption text-uppercase pt-1 mb-2" style="color: #818ea3">Users by device</p>
            <v-divider class="mt-0 pt-0"></v-divider>

            <v-layout class="mt-3">
              <v-flex xs12>
                <pie-chart :chartData="pieChartData" :options="chartOpts"></pie-chart>
              </v-flex>
            </v-layout>
          </v-container>
        </v-card>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import StatsCard from "../../components/admin/StatsCard";
import LineChart from "../../components/admin/LineChart";
import PieChart from "../../components/admin/PieChart";

export default {
  name: "dashboard",
  components: {
    StatsCard,
    LineChart,
    PieChart
  },
  data: () => ({
    stats: [
      {
        id: 0,
        key: "Revenue 30 days",
        value: "12,540,000₫",
        trend: 12.3,
        to: "#"
      },
      { id: 1, key: "Total requests 24h", value: 15303, trend: -3.6, to: "#" },
      { id: 2, key: "Books published", value: 8420, to: "#" },
      { id: 3, key: "Customers", value: 1203, to: "#" }
    ],
    dpMenuStart: false,
    dpInputStart: "",
    dpMenuEnd: false,
    dpInputEnd: "",
    chartData: {
      labels: ["January", "February", "March", "April", "May", "June", "July"],
      datasets: [
        {
          label: "Last month",
          backgroundColor: ['rgba(255, 99, 132, 0.3)'],
          borderDash: [5, 5],
          data: [12, 22, 67, 34, 58, 22, 29]
        },
        {
          label: "This month",
          backgroundColor: "rgba(54, 162, 235, 0.6)",
          data: [40, 39, 55, 40, 39, 80, 40]
        }
      ]
    },
    pieChartData: {
      labels: ["Desktop", "Tablet", "Mobile"],
      datasets: [
        {
           backgroundColor: [
                'rgba(255, 99, 132, 0.5)',
                'rgba(54, 162, 235, 0.5)',
                'rgba(255, 206, 86, 0.5)',
                'rgba(75, 192, 192, 0.5)',
                'rgba(153, 102, 255, 0.5)',
                'rgba(255, 159, 64, 0.5)'
            ],
          data: [2542, 342, 6312],
        }
      ]
    },
    chartOpts: { responsive: true, maintainAspectRatio: false }
  })
};
</script>
