<template>
  <v-container fluid>
    <v-layout>
      <v-flex xs12>
        <div id="epub-reader">
          <!-- <PreferencesDropdown
            :themes="themes"
            :current-theme.sync="currentTheme"
            :font-size.sync="size"
            v-model="serchQuery"
            @searchResults="onSearchResults"
          >
            <template slot="book-content" slot-scope="props">
              <button class="my-find my-content" @click="showContent">
                <img src="../../assets/img/left-alignment.svg" alt />
              </button>
              <div class="search-widget1" v-if="openContent">
                <TreeMenu :subContent="toc" />
              </div>
            </template>
            <template slot="book-search" slot-scope="props">
              <button class="my-find" @click="toggleSearchWidget">
                <img src="../../assets/img/search.svg" alt />
              </button>
              <div class="search-widget1" v-if="openSearch">
                <input
                  type="text"
                  :value="serchQuery"
                  @change="props.findText($event.target.value)"
                />
                <button @click="props.removeHighlight">x</button>
                <ul>
                  <li
                    v-for="(excerpt, i) in searchContent"
                    :key="i"
                    @click="props.showPage(excerpt.cfi)"
                  >
                    <p>{{excerpt.excerpt}}</p>
                  </li>
                </ul>
              </div>
            </template>
          </PreferencesDropdown> -->

          <BookReader
            bookArea="epub-reader"
            :epub-url="url"
            :font-size="size"
            :themes="themes"
            :theme="currentTheme"
            :progress.sync="readingProgress"
            @toc="getContent"
            :contentBookModify="100"
          >
            <!-- <template slot="progress-bar" slot-scope="props">
              <input
                size="3"
                type="range"
                max="100"
                min="0"
                step="1"
                @change="props.onChange($event.target.value)"
                :value="readingProgress"
              /> %
              <input
                type="text"
                :value="readingProgress"
              />
            </template> -->
          </BookReader>
          </div>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { axiosConfig } from "../../utils";
import { eventBus } from "../../event";
import { mapGetters } from "vuex";
import { BookReader, PreferencesDropdown, TreeMenu } from "vue-epub-reader";
import vueSlider from "vue-slider-component";

export default {
  name: "reading",
  components: {
    BookReader,
    PreferencesDropdown,
    TreeMenu,
    vueSlider
  },
  data() {
    return {
      url: "/api/v1/files/alice.epub",
      size: 80,
      currentTheme: "beige",
      themes: {
        white: {
          body: {
            color: "#000000",
            background: "#ffffff"
          },
          name: "WHITE"
        },
        beige: {
          body: {
            color: "#000000",
            background: "#f3e8d2"
          },
          name: "BEIGE"
        },
        night: {
          body: {
            color: "#ffffff",
            background: "#4a4a4a"
          },
          name: "NIGHT"
        }
      },
      serchQuery: "",
      readingProgress: 20,
      openSearch: false,
      openContent: false,
      searchContent: [],
      toc: []
    };
  },
  computed: {
    ...mapGetters(["authUser"]),
    isAuth() {
      return this.authUser && this.authUser.id && true;
    }
  },
  methods: {
    toggleSearchWidget() {
      this.openSearch = !this.openSearch;
    },
    showContent() {
      this.openContent = !this.openContent;
    },
    onSearchResults(value) {
      this.searchContent = value;
    },
    getContent(value) {
      this.toc = value;
    }
  },
  mounted() {
    this.$root.$on("toc", toc => {
      this.toc = toc;
    });
  },
  created() {
    // eventBus.$on("loginUser", () => {
    //   this.getUserInfo();
    // });
  }
};
</script>
