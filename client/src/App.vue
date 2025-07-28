<script setup>
import Navbar from './components/Navbar.vue';
import Footer from './components/Footer.vue';
import Pdf from './components/Pdf.vue';
import { RouterView } from 'vue-router';
import Notice from './components/Notice.vue';
</script>

<template>
<Navbar />
<Notice />
<div class="container mt-4">
  <RouterView />
</div>
<Pdf />
<Footer />
</template>

<style scoped>

</style>
