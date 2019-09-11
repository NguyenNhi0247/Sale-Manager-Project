<template>
  <v-container fluid class="ma-0 pa-0">
    <v-layout>
      <v-flex xs12>
        <div id="epub-reader">

          <EpubReader
            bookArea="epub-reader"
            :epub-url="url"
            :progress.sync="readingProgress"
            @toc="getContent"
            :contentBookModify="40"
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
            </template>-->
          </EpubReader>
        </div>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { axiosConfig } from "../../utils";
import { eventBus } from "../../event";
import { mapGetters } from "vuex";

import EpubReader from "../../components/EpubReader";

export default {
  name: "reading",
  components: {
    EpubReader
  },
  data() {
    return {
      book: null,
      url: "",
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
    this.id = this.$route.params.id;
    this.$http
      .get(`/api/v1/books/${this.id}`, axiosConfig)
      .then(resp => {
        console.log(resp.data);
        this.book = resp.data;

        let filePath = ""
        for (let i = 0; i < this.book.ebook_formats.length; i++) {
          let format = this.book.ebook_formats[i]
          console.log(format)
          if (format.type === "epub") {
            filePath = format.file_path.replace("_data/", "")
          }
        }
        if (!filePath) {
          return
        }
        this.url = `/api/v1/files/${filePath}`
      })
      .catch(err => {
        console.log(err);
        let em = err.message;
        if (err.response) {
          em = err.response.data.message;
        }
        eventBus.snackbarShown({
          type: "error",
          msg: `Cannot get book details. ${em}`
        });
      });

    // this.$root.$on("toc", toc => {
    //   this.toc = toc;
    // });
  },
  created() {
    // eventBus.$on("loginUser", () => {
    //   this.getUserInfo();
    // });
  }
};
</script>
