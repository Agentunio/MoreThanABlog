<script setup>
import mainimage from "../assets/1.jpg"
import { ref } from "vue";

const currentpage = ref(1)
</script>

<template>
  <h1>Wpisy o życiu</h1>
  <p>Sint in ea eiusmod qui cupidatat sunt voluptate id nostrud pariatur Lorem enim. SIpsum Lorem adipisicing Lorem cillum ex aliqua elit tempor. In ea consequat exercitation cillum id. Duis do id officia dolore ipsum proident anim consectetur exercitation aliquip do ullamco. Mollit dolor officia incididunt dolore.</p>
  <div class="d-flex flex-wrap gap-5" id="posts">
  <div v-for="_ in 12">
    <div class="card" style="width: 18rem;">
      <img :src="mainimage" class="card-img-top" loading="lazy"/>
      <div class="card-body">
        <h2 class="card-title m-0">TEST</h2>
        <div style="font-size: 16px; color: grey; font-style: italic;"><p class="m-0 p-0">Autor: TEST</p></div>
        <div class="mb-2" style="font-size: 16px; color: grey; font-style: italic;"><p>Data: 28.07.2025</p></div>
        <p class="card-text" style="font-size: 18px;">ale dobry wpis</p>
        <RouterLink to="/odpal-wpis" class="btn">Czytaj więcej -></RouterLink>
      </div>
    </div>
  </div>
  </div>

  <div class="d-flex justify-content-center mt-4 gap-2">
      <a v-for="i in 3" :key="i" :href="'/?page=' + i" :class="'pagination-links text-center align-content-center', {active_class: i == currentpage}">{{ i }}</a>
  </div>
</template>