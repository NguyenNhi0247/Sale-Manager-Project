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
            <v-btn text color="purple">Explore</v-btn>
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

      <v-flex xs10 class="ml-3">
        <h2>Bookshelf</h2>
        <v-container fluid grid-list-md pt-2 px-0 pb-4>
          <v-layout row wrap v-if="purchasedBooks.length > 0">
            <v-flex d-flex xs4 v-for="book in purchasedBooks" :key="book.id">
              <book-card :book="book" isPurchased></book-card>
            </v-flex>
          </v-layout>
          <p v-else>No book purchased</p>
        </v-container>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
import { axiosConfig } from "../../utils";
import { eventBus } from "../../event";
import { mapGetters } from "vuex";

import BookCard from "../../components/BookCard";

export default {
  name: "user",
  components: {
    "book-card": BookCard
  },
  data() {
    return {
      user: null,
      show: false,
      purchasedBooks: [
        {
          id: 2,
          title: "Introduction to a devout life",
          sub_title:
            "from the French of St. Francis de Sales ... to which is prefixed an abstract of his life.",
          thumbnails: [
            "http://covers.openlibrary.org/b/olid/OL16574453M-L.jpg"
          ],
          description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          long_description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec faucibus nunc et maximus maximus. Ut in posuere metus. Donec imperdiet justo ac mauris finibus dapibus. Aenean mattis mattis ligula, non molestie purus sodales id. Integer consectetur aliquam odio id sodales. Cras scelerisque, velit non viverra lobortis, massa nulla semper odio, lacinia placerat neque lorem eu arcu. Nullam gravida, dui et fringilla suscipit, ex nisi lobortis augue, at aliquam nibh ante eleifend augue. In laoreet, leo maximus elementum efficitur, ipsum turpis faucibus leo, id convallis purus urna et sapien. Nulla interdum id ligula id pulvinar. Donec luctus venenatis orci.\n\nDuis vel urna lacus. Curabitur sit amet ante malesuada, aliquet nisl vitae, congue lacus. Donec sagittis neque eu eros fermentum condimentum sagittis porttitor sem. Etiam sit amet velit diam. Curabitur consequat condimentum nisi ut cursus. Nunc viverra neque ut tincidunt fermentum. Sed mi ipsum, tempor sit amet ipsum a, tempor cursus tellus. Mauris vehicula leo nec viverra auctor. Donec in justo eget ipsum rhoncus vestibulum. In finibus sit amet tortor id volutpat. Sed nisi justo, convallis nec ex in, placerat mollis odio. Suspendisse mollis mattis lectus, sed sollicitudin mauris iaculis non. Maecenas efficitur enim id magna commodo, quis posuere enim rhoncus. Mauris pharetra commodo felis, id bibendum odio pellentesque nec. Etiam fermentum, neque vel bibendum tincidunt, nisl augue feugiat erat, in finibus nisi ante eget tortor. Cras vitae egestas leo, a porta turpis.\n\nDonec finibus odio ultricies turpis porttitor, ut elementum felis pellentesque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent viverra volutpat aliquet. Duis sed felis ac turpis lacinia pharetra. Proin pretium risus eget sem feugiat consequat. Morbi tempus, nibh at iaculis viverra, urna nulla scelerisque metus, vel scelerisque turpis purus at ligula. Fusce fringilla sapien sit amet convallis aliquet. Duis nec varius nibh.\n\nUt sodales enim hendrerit, luctus dolor quis, iaculis nulla. Aenean scelerisque libero elementum nibh pretium, eget dictum libero euismod. Vivamus eleifend porta magna, sit amet venenatis tellus finibus consectetur. Proin nec luctus leo, eget elementum ante. Sed aliquam ultricies libero sed efficitur. Nulla ac velit bibendum, placerat ipsum sit amet, tempus nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consequat velit arcu, at cursus quam fermentum a. Maecenas vitae accumsan ipsum. Phasellus mauris lacus, tempus id dapibus vitae, convallis quis ligula. Praesent malesuada justo orci, quis rhoncus ligula fermentum non. Proin quis congue libero.\n\nNunc ullamcorper hendrerit tellus id consequat. Duis nec enim risus. Nam consectetur mauris ut diam viverra egestas. Ut tempor est vitae elit aliquet lobortis. Suspendisse vehicula sem nisl, at aliquam odio semper sed. Vestibulum congue non velit gravida condimentum. Donec placerat lacinia lectus vel posuere.\n\nInteger vehicula, mauris vitae accumsan convallis, elit velit volutpat nisl, at iaculis nisl nulla in ante. Sed sagittis, ipsum sed lobortis vulputate, purus justo egestas massa, et pretium mi tellus vitae enim. Nam efficitur mi vel mollis euismod. Phasellus non nisl auctor, consequat ante nec, dictum massa. Suspendisse vulputate sed diam at placerat. Suspendisse pretium dignissim urna in blandit. Fusce eu finibus ex. Maecenas vitae sollicitudin mi, eget dapibus sapien. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut at lorem ut nulla commodo aliquam in ut justo.",
          price: 181000.0,
          total_rating_point: 178,
          total_rated: 162,
          total_purchased: 0,
          publisher: "F. Pustet & co.",
          published_at: "1900-01-01T00:00:00",
          published_place: "Ratisbon, New York [etc.]",
          pagination: "xxi, 367 p.",
          ebook_formats: [
            {
              type: "txt",
              file_path: "_data/txt/OL16574453M.txt",
              file_size: 577420
            },
            {
              type: "epub",
              file_path: "_data/epub/OL16574453M.epub",
              file_size: 1400070
            },
            {
              type: "pdf",
              file_path: "_data/pdf/OL16574453M.pdf",
              file_size: 23575267
            }
          ],
          authors: ["Francis de Sales"],
          categories: [
            "Accessible book",
            "Bible",
            "Catholic Church",
            "Catholic authors",
            "Christian life",
            "Devotional exercises",
            "Devotional literature",
            "Early works to 1800",
            "God",
            "Love",
            "Maxims",
            "Meditations",
            "Mystics",
            "Méditations",
            "Prayers and devotions",
            "Religious aspects of Love",
            "Spanish",
            "Spiritual life",
            "Worship and love"
          ],
          created_at: "2019-08-09T04:53:48.681679",
          updated_at: "2019-08-09T04:53:48.681679",
          is_deleted: false,
          deleted_at: null
        },
        {
          id: 3,
          title: "The Phaedrus of Plato",
          sub_title: "",
          thumbnails: [
            "http://covers.openlibrary.org/b/olid/OL14034129M-L.jpg"
          ],
          description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          long_description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec faucibus nunc et maximus maximus. Ut in posuere metus. Donec imperdiet justo ac mauris finibus dapibus. Aenean mattis mattis ligula, non molestie purus sodales id. Integer consectetur aliquam odio id sodales. Cras scelerisque, velit non viverra lobortis, massa nulla semper odio, lacinia placerat neque lorem eu arcu. Nullam gravida, dui et fringilla suscipit, ex nisi lobortis augue, at aliquam nibh ante eleifend augue. In laoreet, leo maximus elementum efficitur, ipsum turpis faucibus leo, id convallis purus urna et sapien. Nulla interdum id ligula id pulvinar. Donec luctus venenatis orci.\n\nDuis vel urna lacus. Curabitur sit amet ante malesuada, aliquet nisl vitae, congue lacus. Donec sagittis neque eu eros fermentum condimentum sagittis porttitor sem. Etiam sit amet velit diam. Curabitur consequat condimentum nisi ut cursus. Nunc viverra neque ut tincidunt fermentum. Sed mi ipsum, tempor sit amet ipsum a, tempor cursus tellus. Mauris vehicula leo nec viverra auctor. Donec in justo eget ipsum rhoncus vestibulum. In finibus sit amet tortor id volutpat. Sed nisi justo, convallis nec ex in, placerat mollis odio. Suspendisse mollis mattis lectus, sed sollicitudin mauris iaculis non. Maecenas efficitur enim id magna commodo, quis posuere enim rhoncus. Mauris pharetra commodo felis, id bibendum odio pellentesque nec. Etiam fermentum, neque vel bibendum tincidunt, nisl augue feugiat erat, in finibus nisi ante eget tortor. Cras vitae egestas leo, a porta turpis.\n\nDonec finibus odio ultricies turpis porttitor, ut elementum felis pellentesque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent viverra volutpat aliquet. Duis sed felis ac turpis lacinia pharetra. Proin pretium risus eget sem feugiat consequat. Morbi tempus, nibh at iaculis viverra, urna nulla scelerisque metus, vel scelerisque turpis purus at ligula. Fusce fringilla sapien sit amet convallis aliquet. Duis nec varius nibh.\n\nUt sodales enim hendrerit, luctus dolor quis, iaculis nulla. Aenean scelerisque libero elementum nibh pretium, eget dictum libero euismod. Vivamus eleifend porta magna, sit amet venenatis tellus finibus consectetur. Proin nec luctus leo, eget elementum ante. Sed aliquam ultricies libero sed efficitur. Nulla ac velit bibendum, placerat ipsum sit amet, tempus nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consequat velit arcu, at cursus quam fermentum a. Maecenas vitae accumsan ipsum. Phasellus mauris lacus, tempus id dapibus vitae, convallis quis ligula. Praesent malesuada justo orci, quis rhoncus ligula fermentum non. Proin quis congue libero.\n\nNunc ullamcorper hendrerit tellus id consequat. Duis nec enim risus. Nam consectetur mauris ut diam viverra egestas. Ut tempor est vitae elit aliquet lobortis. Suspendisse vehicula sem nisl, at aliquam odio semper sed. Vestibulum congue non velit gravida condimentum. Donec placerat lacinia lectus vel posuere.\n\nInteger vehicula, mauris vitae accumsan convallis, elit velit volutpat nisl, at iaculis nisl nulla in ante. Sed sagittis, ipsum sed lobortis vulputate, purus justo egestas massa, et pretium mi tellus vitae enim. Nam efficitur mi vel mollis euismod. Phasellus non nisl auctor, consequat ante nec, dictum massa. Suspendisse vulputate sed diam at placerat. Suspendisse pretium dignissim urna in blandit. Fusce eu finibus ex. Maecenas vitae sollicitudin mi, eget dapibus sapien. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut at lorem ut nulla commodo aliquam in ut justo.",
          price: 227000.0,
          total_rating_point: 1134,
          total_rated: 270,
          total_purchased: 0,
          publisher: "Whittaker",
          published_at: "1868-01-01T00:00:00",
          published_place: "London",
          pagination: "xxviii, 203 p.",
          ebook_formats: [
            {
              type: "epub",
              file_path: "_data/epub/OL14034129M.epub",
              file_size: 2852635
            },
            {
              type: "pdf",
              file_path: "_data/pdf/OL14034129M.pdf",
              file_size: 18594118
            },
            {
              type: "txt",
              file_path: "_data/txt/OL14034129M.txt",
              file_size: 881495
            }
          ],
          authors: ["Plato"],
          categories: [
            "Rhetoric",
            "Love",
            "Ancient Philosophy",
            "Accessible book",
            "Love.",
            "Soul",
            "Ancient Rhetoric",
            "Great_books_of_the_western_world",
            "Early works to 1800",
            "Open_syllabus_project",
            "Protected DAISY",
            "Theory of Knowledge",
            "In library",
            "Inspiration",
            "Kommentar"
          ],
          created_at: "2019-08-09T04:53:48.709883",
          updated_at: "2019-08-09T04:53:48.709883",
          is_deleted: false,
          deleted_at: null
        },
        {
          id: 4,
          title: "Meno",
          sub_title: "",
          thumbnails: [
            "http://covers.openlibrary.org/b/olid/OL23319049M-L.jpg"
          ],
          description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          long_description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec faucibus nunc et maximus maximus. Ut in posuere metus. Donec imperdiet justo ac mauris finibus dapibus. Aenean mattis mattis ligula, non molestie purus sodales id. Integer consectetur aliquam odio id sodales. Cras scelerisque, velit non viverra lobortis, massa nulla semper odio, lacinia placerat neque lorem eu arcu. Nullam gravida, dui et fringilla suscipit, ex nisi lobortis augue, at aliquam nibh ante eleifend augue. In laoreet, leo maximus elementum efficitur, ipsum turpis faucibus leo, id convallis purus urna et sapien. Nulla interdum id ligula id pulvinar. Donec luctus venenatis orci.\n\nDuis vel urna lacus. Curabitur sit amet ante malesuada, aliquet nisl vitae, congue lacus. Donec sagittis neque eu eros fermentum condimentum sagittis porttitor sem. Etiam sit amet velit diam. Curabitur consequat condimentum nisi ut cursus. Nunc viverra neque ut tincidunt fermentum. Sed mi ipsum, tempor sit amet ipsum a, tempor cursus tellus. Mauris vehicula leo nec viverra auctor. Donec in justo eget ipsum rhoncus vestibulum. In finibus sit amet tortor id volutpat. Sed nisi justo, convallis nec ex in, placerat mollis odio. Suspendisse mollis mattis lectus, sed sollicitudin mauris iaculis non. Maecenas efficitur enim id magna commodo, quis posuere enim rhoncus. Mauris pharetra commodo felis, id bibendum odio pellentesque nec. Etiam fermentum, neque vel bibendum tincidunt, nisl augue feugiat erat, in finibus nisi ante eget tortor. Cras vitae egestas leo, a porta turpis.\n\nDonec finibus odio ultricies turpis porttitor, ut elementum felis pellentesque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent viverra volutpat aliquet. Duis sed felis ac turpis lacinia pharetra. Proin pretium risus eget sem feugiat consequat. Morbi tempus, nibh at iaculis viverra, urna nulla scelerisque metus, vel scelerisque turpis purus at ligula. Fusce fringilla sapien sit amet convallis aliquet. Duis nec varius nibh.\n\nUt sodales enim hendrerit, luctus dolor quis, iaculis nulla. Aenean scelerisque libero elementum nibh pretium, eget dictum libero euismod. Vivamus eleifend porta magna, sit amet venenatis tellus finibus consectetur. Proin nec luctus leo, eget elementum ante. Sed aliquam ultricies libero sed efficitur. Nulla ac velit bibendum, placerat ipsum sit amet, tempus nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consequat velit arcu, at cursus quam fermentum a. Maecenas vitae accumsan ipsum. Phasellus mauris lacus, tempus id dapibus vitae, convallis quis ligula. Praesent malesuada justo orci, quis rhoncus ligula fermentum non. Proin quis congue libero.\n\nNunc ullamcorper hendrerit tellus id consequat. Duis nec enim risus. Nam consectetur mauris ut diam viverra egestas. Ut tempor est vitae elit aliquet lobortis. Suspendisse vehicula sem nisl, at aliquam odio semper sed. Vestibulum congue non velit gravida condimentum. Donec placerat lacinia lectus vel posuere.\n\nInteger vehicula, mauris vitae accumsan convallis, elit velit volutpat nisl, at iaculis nisl nulla in ante. Sed sagittis, ipsum sed lobortis vulputate, purus justo egestas massa, et pretium mi tellus vitae enim. Nam efficitur mi vel mollis euismod. Phasellus non nisl auctor, consequat ante nec, dictum massa. Suspendisse vulputate sed diam at placerat. Suspendisse pretium dignissim urna in blandit. Fusce eu finibus ex. Maecenas vitae sollicitudin mi, eget dapibus sapien. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut at lorem ut nulla commodo aliquam in ut justo.",
          price: 187000.0,
          total_rating_point: 1155,
          total_rated: 330,
          total_purchased: 0,
          publisher: "Clarendon Press",
          published_at: "1887-01-01T00:00:00",
          published_place: "Oxford",
          pagination: "2 parts in 1 vol.",
          ebook_formats: [
            {
              type: "epub",
              file_path: "_data/epub/OL23319049M.epub",
              file_size: 1737269
            },
            {
              type: "txt",
              file_path: "_data/txt/OL23319049M.txt",
              file_size: 271292
            },
            {
              type: "pdf",
              file_path: "_data/pdf/OL23319049M.pdf",
              file_size: 6220399
            }
          ],
          authors: ["Plato"],
          categories: [
            "Virtue",
            "Early works to 1800",
            "Ancient Philosophy",
            "Philosophy",
            "Idea (Philosophy)",
            "Classic Literature",
            "Fiction",
            "Vertus",
            "Love",
            "Meno (Plato)",
            "Social",
            "PHILOSOPHY",
            "Ethics & Moral Philosophy"
          ],
          created_at: "2019-08-09T04:53:48.711032",
          updated_at: "2019-08-09T04:53:48.711032",
          is_deleted: false,
          deleted_at: null
        },
        {
          id: 5,
          title: "The Parmenides of Plato",
          sub_title: "",
          thumbnails: [
            "http://covers.openlibrary.org/b/olid/OL24180407M-L.jpg"
          ],
          description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          long_description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec faucibus nunc et maximus maximus. Ut in posuere metus. Donec imperdiet justo ac mauris finibus dapibus. Aenean mattis mattis ligula, non molestie purus sodales id. Integer consectetur aliquam odio id sodales. Cras scelerisque, velit non viverra lobortis, massa nulla semper odio, lacinia placerat neque lorem eu arcu. Nullam gravida, dui et fringilla suscipit, ex nisi lobortis augue, at aliquam nibh ante eleifend augue. In laoreet, leo maximus elementum efficitur, ipsum turpis faucibus leo, id convallis purus urna et sapien. Nulla interdum id ligula id pulvinar. Donec luctus venenatis orci.\n\nDuis vel urna lacus. Curabitur sit amet ante malesuada, aliquet nisl vitae, congue lacus. Donec sagittis neque eu eros fermentum condimentum sagittis porttitor sem. Etiam sit amet velit diam. Curabitur consequat condimentum nisi ut cursus. Nunc viverra neque ut tincidunt fermentum. Sed mi ipsum, tempor sit amet ipsum a, tempor cursus tellus. Mauris vehicula leo nec viverra auctor. Donec in justo eget ipsum rhoncus vestibulum. In finibus sit amet tortor id volutpat. Sed nisi justo, convallis nec ex in, placerat mollis odio. Suspendisse mollis mattis lectus, sed sollicitudin mauris iaculis non. Maecenas efficitur enim id magna commodo, quis posuere enim rhoncus. Mauris pharetra commodo felis, id bibendum odio pellentesque nec. Etiam fermentum, neque vel bibendum tincidunt, nisl augue feugiat erat, in finibus nisi ante eget tortor. Cras vitae egestas leo, a porta turpis.\n\nDonec finibus odio ultricies turpis porttitor, ut elementum felis pellentesque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent viverra volutpat aliquet. Duis sed felis ac turpis lacinia pharetra. Proin pretium risus eget sem feugiat consequat. Morbi tempus, nibh at iaculis viverra, urna nulla scelerisque metus, vel scelerisque turpis purus at ligula. Fusce fringilla sapien sit amet convallis aliquet. Duis nec varius nibh.\n\nUt sodales enim hendrerit, luctus dolor quis, iaculis nulla. Aenean scelerisque libero elementum nibh pretium, eget dictum libero euismod. Vivamus eleifend porta magna, sit amet venenatis tellus finibus consectetur. Proin nec luctus leo, eget elementum ante. Sed aliquam ultricies libero sed efficitur. Nulla ac velit bibendum, placerat ipsum sit amet, tempus nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consequat velit arcu, at cursus quam fermentum a. Maecenas vitae accumsan ipsum. Phasellus mauris lacus, tempus id dapibus vitae, convallis quis ligula. Praesent malesuada justo orci, quis rhoncus ligula fermentum non. Proin quis congue libero.\n\nNunc ullamcorper hendrerit tellus id consequat. Duis nec enim risus. Nam consectetur mauris ut diam viverra egestas. Ut tempor est vitae elit aliquet lobortis. Suspendisse vehicula sem nisl, at aliquam odio semper sed. Vestibulum congue non velit gravida condimentum. Donec placerat lacinia lectus vel posuere.\n\nInteger vehicula, mauris vitae accumsan convallis, elit velit volutpat nisl, at iaculis nisl nulla in ante. Sed sagittis, ipsum sed lobortis vulputate, purus justo egestas massa, et pretium mi tellus vitae enim. Nam efficitur mi vel mollis euismod. Phasellus non nisl auctor, consequat ante nec, dictum massa. Suspendisse vulputate sed diam at placerat. Suspendisse pretium dignissim urna in blandit. Fusce eu finibus ex. Maecenas vitae sollicitudin mi, eget dapibus sapien. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut at lorem ut nulla commodo aliquam in ut justo.",
          price: 79000.0,
          total_rating_point: 1122,
          total_rated: 387,
          total_purchased: 0,
          publisher: "J. Maclehose",
          published_at: "1894-01-01T00:00:00",
          published_place: "Glasgow",
          pagination: "1 v. (various paging):",
          ebook_formats: [
            {
              type: "txt",
              file_path: "_data/txt/OL24180407M.txt",
              file_size: 1189897
            },
            {
              type: "epub",
              file_path: "_data/epub/OL24180407M.epub",
              file_size: 2924158
            },
            {
              type: "pdf",
              file_path: "_data/pdf/OL24180407M.pdf",
              file_size: 13874656
            }
          ],
          authors: [
            "Plato",
            "Francis MacDonald Cornford",
            "Arnold Hermann",
            "Sylvana Chrysakopoulou"
          ],
          categories: [
            "Great_books_of_the_western_world",
            "Knowledge",
            "Translating into Latin",
            "Periodicals",
            "Fiction",
            "Voyages and travels",
            "Philosophy",
            "One (The One in philosophy)",
            "Idea (Philosophy)",
            "Classic Literature",
            "Pictorial works",
            "Ancient Philosophy",
            "Open_syllabus_project",
            "Pleasure",
            "Language and languages",
            "Ontology",
            "Greek language",
            "Travelers",
            "Early works to 1800",
            "Theory of Knowledge",
            "Dialectic",
            "Reasoning",
            "Geography",
            "Love",
            "Western philosophy",
            "Ancient Greek & Roman philosophy",
            "History & Surveys - Ancient & Classical",
            "Metaphysics",
            "Philosophy / Western"
          ],
          created_at: "2019-08-09T04:53:48.711922",
          updated_at: "2019-08-09T04:53:48.711922",
          is_deleted: false,
          deleted_at: null
        },
        {
          id: 6,
          title: "The Gorgias of Plato",
          sub_title: "",
          thumbnails: [
            "http://covers.openlibrary.org/b/olid/OL14010062M-L.jpg"
          ],
          description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
          long_description:
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec faucibus nunc et maximus maximus. Ut in posuere metus. Donec imperdiet justo ac mauris finibus dapibus. Aenean mattis mattis ligula, non molestie purus sodales id. Integer consectetur aliquam odio id sodales. Cras scelerisque, velit non viverra lobortis, massa nulla semper odio, lacinia placerat neque lorem eu arcu. Nullam gravida, dui et fringilla suscipit, ex nisi lobortis augue, at aliquam nibh ante eleifend augue. In laoreet, leo maximus elementum efficitur, ipsum turpis faucibus leo, id convallis purus urna et sapien. Nulla interdum id ligula id pulvinar. Donec luctus venenatis orci.\n\nDuis vel urna lacus. Curabitur sit amet ante malesuada, aliquet nisl vitae, congue lacus. Donec sagittis neque eu eros fermentum condimentum sagittis porttitor sem. Etiam sit amet velit diam. Curabitur consequat condimentum nisi ut cursus. Nunc viverra neque ut tincidunt fermentum. Sed mi ipsum, tempor sit amet ipsum a, tempor cursus tellus. Mauris vehicula leo nec viverra auctor. Donec in justo eget ipsum rhoncus vestibulum. In finibus sit amet tortor id volutpat. Sed nisi justo, convallis nec ex in, placerat mollis odio. Suspendisse mollis mattis lectus, sed sollicitudin mauris iaculis non. Maecenas efficitur enim id magna commodo, quis posuere enim rhoncus. Mauris pharetra commodo felis, id bibendum odio pellentesque nec. Etiam fermentum, neque vel bibendum tincidunt, nisl augue feugiat erat, in finibus nisi ante eget tortor. Cras vitae egestas leo, a porta turpis.\n\nDonec finibus odio ultricies turpis porttitor, ut elementum felis pellentesque. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent viverra volutpat aliquet. Duis sed felis ac turpis lacinia pharetra. Proin pretium risus eget sem feugiat consequat. Morbi tempus, nibh at iaculis viverra, urna nulla scelerisque metus, vel scelerisque turpis purus at ligula. Fusce fringilla sapien sit amet convallis aliquet. Duis nec varius nibh.\n\nUt sodales enim hendrerit, luctus dolor quis, iaculis nulla. Aenean scelerisque libero elementum nibh pretium, eget dictum libero euismod. Vivamus eleifend porta magna, sit amet venenatis tellus finibus consectetur. Proin nec luctus leo, eget elementum ante. Sed aliquam ultricies libero sed efficitur. Nulla ac velit bibendum, placerat ipsum sit amet, tempus nunc. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce consequat velit arcu, at cursus quam fermentum a. Maecenas vitae accumsan ipsum. Phasellus mauris lacus, tempus id dapibus vitae, convallis quis ligula. Praesent malesuada justo orci, quis rhoncus ligula fermentum non. Proin quis congue libero.\n\nNunc ullamcorper hendrerit tellus id consequat. Duis nec enim risus. Nam consectetur mauris ut diam viverra egestas. Ut tempor est vitae elit aliquet lobortis. Suspendisse vehicula sem nisl, at aliquam odio semper sed. Vestibulum congue non velit gravida condimentum. Donec placerat lacinia lectus vel posuere.\n\nInteger vehicula, mauris vitae accumsan convallis, elit velit volutpat nisl, at iaculis nisl nulla in ante. Sed sagittis, ipsum sed lobortis vulputate, purus justo egestas massa, et pretium mi tellus vitae enim. Nam efficitur mi vel mollis euismod. Phasellus non nisl auctor, consequat ante nec, dictum massa. Suspendisse vulputate sed diam at placerat. Suspendisse pretium dignissim urna in blandit. Fusce eu finibus ex. Maecenas vitae sollicitudin mi, eget dapibus sapien. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Ut at lorem ut nulla commodo aliquam in ut justo.",
          price: 21000.0,
          total_rating_point: 2038,
          total_rated: 443,
          total_purchased: 0,
          publisher: "J. Munroe",
          published_at: "1856-01-01T00:00:00",
          published_place: "Boston",
          pagination: "lv, 242 p. ;",
          ebook_formats: [
            {
              type: "txt",
              file_path: "_data/txt/OL14010062M.txt",
              file_size: 520946
            },
            {
              type: "pdf",
              file_path: "_data/pdf/OL14010062M.pdf",
              file_size: 13807765
            },
            {
              type: "epub",
              file_path: "_data/epub/OL14010062M.epub",
              file_size: 1521973
            }
          ],
          authors: ["Plato"],
          categories: [
            "In library",
            "Ancient Philosophy",
            "Accessible book",
            "Great_books_of_the_western_world",
            "Early works to 1800",
            "Open_syllabus_project",
            "Political science",
            "Protected DAISY",
            "Ethics",
            "Classic Literature",
            "Love",
            "Greek language materials"
          ],
          created_at: "2019-08-09T04:53:48.712917",
          updated_at: "2019-08-09T04:53:48.712917",
          is_deleted: false,
          deleted_at: null
        }
      ]
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
          console.log(resp.data);
          this.user = resp.data;
        })
        .catch(err => {
          console.log(err);
          let em = err.message;
          if (err.response) {
            em = err.response.data.message;
          }
          eventBus.snackbarShown({
            type: "error",
            msg: `Cannot get user info. ${em}`
          });
        });
    }
  },
  mounted() {
    this.getUserInfo();
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
