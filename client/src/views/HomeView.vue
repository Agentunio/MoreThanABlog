<script setup>
import mainimage from "../assets/1.jpg"
import { ref, onMounted } from "vue";
import { useDateFormat } from '@vueuse/core'
import axios from 'axios';

const currentpage = ref(1)

const posts = ref([]);

onMounted(async () => {
  try {
    const response = await axios.get('http://localhost:3001/api/posts');
    posts.value = response.data;
  } catch (error) {
    console.error(error);
  }
});

function formatDate(date) {
  return useDateFormat(date, 'DD.MM.YYYY').value
}

function removeHtmlTags(html) {
  const tempDiv = document.createElement("div");
  tempDiv.innerHTML = html;
  const text = tempDiv.textContent || tempDiv.innerText || "";

  return text.length > 80
    ? text.slice(0, 80).trim() + "..."
    : text;
}

</script>

<template>
  <h1>Wpisy o życiu</h1>
  <p>Sint in ea eiusmod qui cupidatat sunt voluptate id nostrud pariatur Lorem enim. SIpsum Lorem adipisicing Lorem cillum ex aliqua elit tempor. In ea consequat exercitation cillum id. Duis do id officia dolore ipsum proident anim consectetur exercitation aliquip do ullamco. Mollit dolor officia incididunt dolore.</p>
  <div class="d-flex flex-wrap gap-5" id="posts">
  <div v-for="post in posts.data" :key="post.id">
    <div class="card" style="width: 18rem;">
      <img :src="mainimage" class="card-img-top" loading="lazy"/>
      <div class="card-body">
        <h2 class="card-title m-0">{{ post.attributes.title }}</h2>
        <div style="font-size: 16px; color: grey; font-style: italic;"><p class="m-0 p-0">Autor: {{ post.attributes.username }}</p></div>
        <div class="mb-2" style="font-size: 16px; color: grey; font-style: italic;"><p v-if="post.attributes.custom_date">Data: {{ post.attributes.custom_date }}</p><p v-else>Data: {{ formatDate(post.attributes.updated_at) }}</p></div>
        <p class="card-text" style="font-size: 18px;">{{ removeHtmlTags(post.attributes.content) }}</p>
        <RouterLink :to="`/wpisy/${post.attributes.slug}`" class="btn">Czytaj więcej -></RouterLink>
      </div>
    </div>
  </div>
  </div>

  <div class="d-flex justify-content-center mt-4 gap-2">
      <a v-for="i in 3" :key="i" :href="'/?page=' + i" :class="'pagination-links text-center align-content-center', {active_class: i == currentpage}">{{ i }}</a>
  </div>
</template>