<script setup>
import { ref, onMounted, computed, watch, onBeforeUnmount } from "vue";
import { useDateFormat } from '@vueuse/core'
import axios from 'axios';

const currentpage = ref(1)
const perPage = 12
const posts = ref([]);

function readPageFromUrl() {
  try {
    const params = new URLSearchParams(window.location.search)
    const p = parseInt(params.get('page') || '1', 10)
    return isNaN(p) || p < 1 ? 1 : p
  } catch {
    return 1
  }
}

currentpage.value = readPageFromUrl()

onMounted(async () => {
  try {
    const response = await axios.get('http://localhost:3001/api/posts');
    posts.value = response.data.data;
  } catch (error) {
    console.error(error);
  }

  window.addEventListener('popstate', onPopState)
});

onBeforeUnmount(() => {
  window.removeEventListener('popstate', onPopState)
})

function onPopState() {
  currentpage.value = readPageFromUrl()
}

const paginatedPosts = computed(() => {
  const start = (currentpage.value - 1) * perPage;
  return posts.value.slice(start, start + perPage)
});

const totalPages = computed(() => {
  return Math.max(1, Math.ceil(posts.value.length / perPage))
})

watch(currentpage, (newPage) => {
  const url = new URL(window.location.href)
  url.searchParams.set('page', String(newPage))
  history.pushState({}, '', url.toString())
})

function goToPage(p) {
  if (typeof p !== 'number') return
  const page = Math.min(Math.max(1, Math.floor(p)), totalPages.value)
  currentpage.value = page
}

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
  <div v-if="paginatedPosts.length === 0">Brak postów.</div>
  <div v-for="post in paginatedPosts" :key="post.id">
    <div class="card" style="width: 18rem;">
      <img :src="post.attributes.main_image"  :alt="post.attributes.title" class="card-img-top" loading="lazy"/>
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
     <button
          v-for="i in totalPages"
          :key="i"
          @click="goToPage(i)"
          :class="['pagination-links', { 'active-pagination': i === currentpage }]"
        >
          {{ i }}
        </button>
    </div>
</template>