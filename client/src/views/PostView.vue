<script setup>
import axios from 'axios';
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';

const post = ref(null);
const route = useRoute();

onMounted(async () => {
  const slug = route.params.slug;
  if (!slug) {
    console.error('Slug nie został znaleziony');
    return;
  }
  
  try {
    const response = await axios.get(`http://localhost:3001/api/posts/${slug}`);

    post.value = response.data.data;
  } catch (e) {
    console.error(e);
  }
});
</script>

<template>
  <div>
    <div v-if="post">
      <h1 class="text-center">{{ post.attributes.title }}</h1>
      <div v-html="post.attributes.content"></div>

      <div v-if="post.attributes.gallery_urls?.length" class="d-flex gap-2 flex-wrap">
        <div
          v-for="(url, idx) in post.attributes.gallery_urls"
          :key="idx"
          :style="{ backgroundImage: 'url(' + url + ')' }"
          :alt="`${post.attributes.title}`"
          class="gallery-img"
          loading="lazy"
        ></div>
      </div>

    </div>
    <div v-else>
      <p>Ładowanie wpisu...</p>
    </div>
  </div>
</template>