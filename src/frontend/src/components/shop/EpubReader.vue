<template>
  <v-container fluid class="pa-0 ma-0">
    <div v-if="book">
      <v-toolbar
        dense
        :color="isReadingMode ? 'grey darken-3' : 'indigo accent-3 white--text'"
        dark
        style="margin-top: -1px"
        height="40"
      >
        <!-- <v-app-bar-nav-icon></v-app-bar-nav-icon> -->
        <v-toolbar-title
          style="font-size: 15px"
          v-if="bookInfo && bookInfo.title"
        >{{ bookInfo.title }}</v-toolbar-title>
        <div class="flex-grow-1"></div>
        <v-spacer></v-spacer>
        <v-select
          v-model="slTheme"
          :items="slThemeItems"
          menu-props="closeOnClick"
          label="Theme"
          hide-details
          single-line
          class="mr-3"
          style="max-width: 90px; font-size: 12px !important"
          height="20"
          dense
        >
          <v-icon slot="prepend" small>mdi-theme-light-dark</v-icon>
        </v-select>

        <v-divider vertical></v-divider>
        <v-btn icon small class="ml-3 mr-1" @click="decreaseFontSize()">
          <v-icon small>mdi-format-font-size-decrease</v-icon>
        </v-btn>
        <v-btn icon small class="ml-1 mr-3" @click="increaseFontSize()">
          <v-icon small>mdi-format-font-size-increase</v-icon>
        </v-btn>
        <v-divider vertical></v-divider>
        <v-btn icon small class="ml-3 mr-1" @click="switchReadingMode()">
          <v-icon small>{{ isReadingMode ? 'mdi-fullscreen-exit' : 'mdi-fullscreen' }}</v-icon>
        </v-btn>

        <v-menu offset-y>
          <template v-slot:activator="{ on }">
            <v-btn icon small class="ml-1" v-on="on" :disabled="!isPurchased">
              <v-icon small>mdi-dots-vertical</v-icon>
            </v-btn>
          </template>
          <v-list>
            <v-list-item
              v-for="(item, index) in bookInfo.ebook_formats"
              :key="index"
              @click="downloadEbook(item)"
            >
              <v-list-item-title>{{ item | toDownloadText }}</v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
      </v-toolbar>

      <div class="epub-container">
        <slot name="prev-btn" :goToPrevPage="goToPrevPage">
          <div id="prev" class="arrow" @click="goToPrevPage">‹</div>
        </slot>
        <slot name="book-content" :ready="ready">
          <div :id="bookArea"></div>
        </slot>
        <slot name="next-btn" :goToNextPage="goToNextPage">
          <div id="next" class="arrow" @click="goToNextPage">›</div>
        </slot>
      </div>
      <!-- <slot name="progress-bar" :onChange="onChange" :ready="ready">
        <div class="epub-reading-progress-bar">
          <input
            size="3"
            type="range"
            max="100"
            min="0"
            step="1"
            @change="onChange($event.target.value)"
            :value="progress"
          /> %
          <input type="text" :value="progress" @change="onChange($event.target.value)" />
        </div>
      </slot>-->
    </div>

    <div v-else style="min-height: 600px" class="text-center">
      <p class="mt-12 pt-12 title">
        Sorry :(
        <br />Online reading for this book is not avalable yet.
      </p>
      <v-btn color="indigo accent-4" depressed dark @click="backToShop">Back to shop</v-btn>
    </div>
  </v-container>
</template>

<script>
import Epub from "epubjs";
import { mapGetters, mapMutations } from "vuex";
import { eventBus } from "../../event";

global.ePub = Epub;
export default {
  name: "BookReader",
  props: {
    bookInfo: {},
    epubUrl: {
      type: String,
      required: true
    },
    fontSize: {
      type: Number,
      default: 100
    },
    theme: {
      type: String,
      default: "Beige"
    },
    progress: {
      type: Number,
      required: true
    },
    bookArea: {
      type: String,
      default: "area"
    },
    contentBookModify: {
      type: Number,
      default: 0
    }
  },
  computed: {
    ...mapGetters(["showHeader", "showFooter", "authUser"])
  },
  data() {
    return {
      isPurchased: false,
      dropdown_download: ["Arial", "Calibri", "Courier", "Verdana"],
      slTheme: this.theme,
      slThemeItems: ["White", "Beige", "Night"],
      themes: {
        white: {
          body: {
            color: "#000000",
            background: "#ffffff"
          },
          name: "White"
        },
        beige: {
          body: {
            color: "#000000",
            background: "#f3e8d2"
          },
          name: "Beige"
        },
        night: {
          body: {
            color: "#ffffff",
            background: "#4a4a4a"
          },
          name: "Night"
        }
      },
      book: null,
      rendition: null,
      section: null,
      toc: [],
      progressValue: 0,
      slide: null,
      cfi: null,
      width: 0,
      height: 0,
      locations: null,
      ready: false,
      internalFontSize: this.fontSize,
      isReadingMode: false
    };
  },
  watch: {
    epubUrl(val) {
      if (val) {
        console.log("EPUB:", val);
        this.initialize();
      }
    },
    slTheme(val) {
      this.setTheme(val);
    },
    fontSize(val) {
      this.setFontSize(val);
    },
    progressValue(val) {
      this.$emit("update:progress", val);
    }
  },
  methods: {
    ...mapMutations(["setShowHeader", "setShowFooter"]),
    initReader() {
      this.rendition = this.book.renderTo(this.bookArea, {
        contained: true,
        height: this.height
      });
      this.registerThemes();
      this.setTheme(this.slTheme);
      this.setFontSize(this.fontSize);
      this.rendition.display();
    },
    registerThemes() {
      this.rendition.themes.register(this.themes);
    },
    goToPrevPage() {
      this.rendition.prev();
    },
    goToNextPage() {
      this.rendition.next();
    },
    setTheme(theme) {
      theme = theme.toLowerCase();
      this.rendition.themes.select(theme);
      if (document && document.body) {
        document.body.style.background = this.themes[theme]["body"].background;
      }
    },
    setFontSize(size) {
      this.rendition.themes.fontSize(size + "%");
    },
    decreaseFontSize() {
      this.internalFontSize -= 10;
      if (this.internalFontSize < 50) {
        this.internalFontSize = 50;
      }
      this.setFontSize(this.internalFontSize);
    },
    increaseFontSize() {
      this.internalFontSize += 10;
      if (this.internalFontSize > 200) {
        this.internalFontSize = 200;
      }
      this.setFontSize(this.internalFontSize);
    },
    switchReadingMode() {
      this.isReadingMode = !this.isReadingMode;
      if (this.isReadingMode) {
        this.openFullscreen();
        this.setShowHeader(false);
        this.setShowFooter(false);
        return;
      }
      this.closeFullscreen();
      this.setShowHeader(true);
      this.setShowFooter(true);
    },
    goToExcerpt(cfi) {
      if (cfi.toLowerCase().indexOf("xhtml") > 0) {
        this.rendition.display(cfi);
      } else {
        this.rendition.display("epubcfi(" + cfi + ")");
        this.rendition.annotations.highlight("epubcfi(" + cfi + ")");
      }
    },
    onChange(value) {
      const percentage = value / 100;
      const target =
        percentage > 0 ? this.book.locations.cfiFromPercentage(percentage) : 0;
      this.rendition.display(target);
      if (percentage === 1) this.goToNextPage();
    },
    updateScreenSizeInfo() {
      this.width = Math.max(
        document.documentElement.clientWidth,
        window.innerWidth || 0
      );
      this.height =
        Math.max(
          document.documentElement.clientHeight,
          window.innerHeight || 0
        ) - this.contentBookModify;
    },
    resizeToScreenSize() {
      this.updateScreenSizeInfo();
      this.rendition.resize(this.width, this.height);
    },
    debounce(func, wait, immediate) {
      let timeout;
      return () => {
        let context = this;
        let args = arguments;
        let later = () => {
          timeout = null;
          if (!immediate) func.apply(context, args);
        };
        let callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
      };
    },
    keyListener(e) {
      if ((e.keyCode || e.which) === 37) {
        this.rendition.prev();
      }
      if ((e.keyCode || e.which) === 39) {
        this.rendition.next();
      }
    },
    openFullscreen() {
      let elem = document.documentElement;
      if (elem.requestFullscreen) {
        elem.requestFullscreen();
      } else if (elem.mozRequestFullScreen) {
        /* Firefox */
        elem.mozRequestFullScreen();
      } else if (elem.webkitRequestFullscreen) {
        /* Chrome, Safari and Opera */
        elem.webkitRequestFullscreen();
      } else if (elem.msRequestFullscreen) {
        /* IE/Edge */
        elem.msRequestFullscreen();
      }
    },
    closeFullscreen() {
      if (document.exitFullscreen) {
        document.exitFullscreen();
      } else if (document.mozCancelFullScreen) {
        /* Firefox */
        document.mozCancelFullScreen();
      } else if (document.webkitExitFullscreen) {
        /* Chrome, Safari and Opera */
        document.webkitExitFullscreen();
      } else if (document.msExitFullscreen) {
        /* IE/Edge */
        document.msExitFullscreen();
      }
    },
    initialize() {
      if (!this.epubUrl) {
        return;
      }

      this.isPurchasedBook();

      console.log("INIT EPUB:", this.epubUrl);
      this.book = new Epub(this.epubUrl, {});
      this.book.loaded.navigation.then(({ toc }) => {
        this.toc = toc;
        this.$emit("toc", this.toc);
        this.initReader();
        this.rendition.on("click", () => {
          this.$emit("click");
        });
      });
      this.book.ready
        .then(() => {
          return this.book.locations.generate();
        })
        .then(() => {
          this.locations = JSON.parse(this.book.locations.save());
          this.ready = true;
          this.$emit("ready");
          this.rendition.on("relocated", location => {
            const percent = this.book.locations.percentageFromCfi(
              location.start.cfi
            );
            const percentage = Math.floor(percent * 100);
            this.progressValue = percentage;
            this.$emit("relocated");
          });
        });
      this.$root.$on("showPage", cfi => {
        this.cfi = cfi;
        this.goToExcerpt(cfi);
      });
      this.$root.$on("clearHighlight", () => {
        this.rendition.annotations.remove("epubcfi(" + this.cfi + ")");
      });
      window.addEventListener(
        "resize",
        this.debounce(() => {
          this.resizeToScreenSize();
        }, 250)
      );
      this.updateScreenSizeInfo();
    },
    backToShop() {
      this.$router.push({ path: "/" });
    },
    isPurchasedBook() {
      this.$http
        .get(
          `/api/v1/users/${this.authUser.username}/books/${this.bookInfo.id}`,
          this.getAuthHeader()
        )
        .then(resp => {
          console.log("IS BOOK PURCHASED", resp.data);
          this.isPurchased = resp.data.is_purchased;
          if (!this.isPurchased) {
            eventBus.snackbarShown({
              type: "warning",
              msg: "Please purchased the book for full reading!"
            });
          }
        })
        .catch(err => {
          this.showError(err, "Cannot check book purchased.");
        });
    },
    downloadEbook(format) {
      let url = `/api/v1/files/${format.file_path.replace("_data/", "")}`;
      window.open(url, "_blank");
    }
  },
  //   mounted() {
  //     this.initialize();
  //   },
  filters: {
    toDownloadText(format) {
      let formatFileSize = size => {
        var sizes = [
          " Bytes",
          " KB",
          " MB",
          " GB",
          " TB",
          " PB",
          " EB",
          " ZB",
          " YB"
        ];
        for (var i = 1; i < sizes.length; i++) {
          if (size < Math.pow(1024, i))
            return (
              Math.round((size / Math.pow(1024, i - 1)) * 100) / 100 +
              sizes[i - 1]
            );
        }
        return size;
      };
      return `${format.type.toUpperCase()} (${formatFileSize(
        format.file_size
      )})`;
    }
  },
  created() {
    window.addEventListener("keyup", this.keyListener);
  },
  beforeDestroy() {
    this.closeFullscreen();
    this.setShowHeader(true);
    this.setShowFooter(true);
    window.removeEventListener("keyup", this.keyListener);
  }
};
</script>

<style scoped>
.buton {
  background-color: #4a4a4a;
  border: none;
  color: white;
  padding: 13px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 22px;
  margin: 26px -115px;
  border-radius: 50%;
  font-family: "Montserrat", sans-serif;
}

.epub-container {
  position: relative;
}

.epub-container:hover > .hover {
  visibility: visible;
}

.hover {
  background-color: #f8f8f8;
  font-family: "Montserrat", sans-serif;
  width: 129px;
  margin-left: 93px;
  padding-top: 5px;
  text-align: center;
  margin-top: -13px;
}

.text {
  color: #8e8989;
  font-size: 7pt;
}

.text-size {
  border-radius: 115px;
  color: #6b6b6b;
}

#little-letter {
  font-size: 11pt;
  padding: 8px 15px 4px;
}

#big-letter {
  font-size: 15pt;
  padding: 3px 14px;
}

#gray-line {
  padding-bottom: 18px;
  border-bottom-width: 2px;
  border-bottom-style: solid;
  border-bottom-color: #efefef;
}

.button-background {
  border-radius: 119px;
  font-family: "Montserrat", sans-serif;
  color: #6b6b6b;
  margin-bottom: 9px;
  font-size: 7pt;
  width: 100px;
  padding: 6px;
}

.button-background.current {
  border: 2px dashed red;
}

#beige {
  background-color: #f3e8d2;
}

#night {
  background-color: #4a4a4a;
  color: #f3f2f2;
}

.arrow {
  position: absolute;
  top: 50%;
  margin-top: 200px;
  font-size: 85px;
  color: #ccc;
  font-family: arial, sans-serif;
  /* font-weight: bold; */
  cursor: pointer;
  -webkit-user-select: none;
  -moz-user-select: none;
  user-select: none;
  z-index: 1;
}

.arrow:hover {
  color: #777;
}

.arrow:active {
  color: #000;
}

#area {
  position: absolute;
  top: 40%;
  left: 50%;
  transform: translate(-50%, -50%);
  width: 65%;
}

#area iframe {
  border: none;
}

#prev {
  left: 10px;
}

#next {
  right: 10px;
}

button {
  outline: none;
}

.highlight {
  background-color: yellow;
}

.epub-reading-progress-bar {
  position: absolute;
  bottom: 30px;
  left: 50%;
}
</style>
