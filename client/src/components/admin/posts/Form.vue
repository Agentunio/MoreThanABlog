<template>
<h1>Nowy wpis</h1>
<div class="bd-example m-0">
    <form @submit.prevent="handleSubmit">
      <div v-if="errors.length" style="color:rgb(226, 19, 54);">
        <h2>Liczba błędów do poprawy przed publikacją wynosi: {{ errors.length }}</h2>
        <ul>
          <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
        </ul>
      </div>

      <div class="mt-3">
        <label for="title" class="form-label d-block">Tytuł</label>
        <input v-model="form.title" id="title" class="form-control" required />
      </div>

      <div class="mt-3">
        <label for="content" class="form-label d-block mt-2">Treść</label>
        <textarea id="post_content" v-model="form.content" class="form-control"></textarea>
      </div>

      <div v-if="!isNew" class="mt-3">
        <p>Aktualna data wpisu to: {{ currentDate }}</p>
        <label for="custom_date" class="form-label d-block">Zmień datę wpisu na:</label>
        <input type="date" v-model="form.custom_date" class="form-control" />
      </div>

      <div v-if="!isNew" class="mt-3">
        <p>Aktualny autor wpisu to: {{ currentAuthor }}</p>
        <label for="user_id" class="form-label d-block">Zmień autora wpisu na:</label>
        <select v-model="form.user_id" class="form-select">
          <option v-for="user in users" :key="user.id" :value="user.id">{{ user.username }}</option>
        </select>
      </div>

      <div class="mt-3">
        <label class="form-label d-block mt-2">Główne zdjęcie</label>
        <input type="file" @change="onMainImageChange" accept="image/*" class="form-control" />
      </div>

      <div class="mt-3">
        <label class="form-label d-block mt-2">Galeria zdjęć</label>
        <input type="file" multiple @change="onGalleryChange" accept="image/*" class="form-control" />
      </div>

      <div class="mt-3">
        <button type="submit" class="btn mt-2">{{ isNew ? 'Dodaj nowy wpis' : 'Zapisz zmiany' }}</button>
      </div>
    </form>

    <div v-if="!isNew && gallery.length" class="mt-3">
      <h2>Aktualna galeria zdjęć</h2>
      <div class="d-flex gap-2 flex-wrap">
        <div v-for="(img, index) in gallery" :key="index" class="d-flex flex-column">
          <div class="gallery-img" :style="{ backgroundImage: 'url(' + img.url + ')' }"></div>
          <button @click="removeImage(img.id)" class="btn mt-2">Usuń to zdjęcie</button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref } from 'vue'
import tinymce from 'tinymce/tinymce'
import 'tinymce/icons/default'
import 'tinymce/themes/silver'
import 'tinymce/plugins/advlist'
import 'tinymce/plugins/autolink'
import 'tinymce/plugins/lists'
import 'tinymce/plugins/link'
import 'tinymce/plugins/image'
import 'tinymce/plugins/charmap'
import 'tinymce/plugins/preview'
import 'tinymce/plugins/anchor'
import 'tinymce/plugins/searchreplace'
import 'tinymce/plugins/visualblocks'
import 'tinymce/plugins/code'
import 'tinymce/plugins/fullscreen'
import 'tinymce/plugins/insertdatetime'
import 'tinymce/plugins/media'
import 'tinymce/plugins/table'
import 'tinymce/plugins/help'
import 'tinymce/plugins/wordcount'

const form = ref({
  title: '',
  content: '',
  custom_date: '',
  user_id: '',
  main_image: null,
  gallery: []
})

const isNew = ref(false) // set based on context
const errors = ref([])
const users = ref([{ id: 1, username: 'Admin' }, { id: 2, username: 'Redaktor' }])
const currentAuthor = 'Admin' // replace with actual data
const currentDate = '28.07.2025' // replace with actual data
const gallery = ref([
  // replace with actual image data from API
  { id: 1, url: '/uploads/gallery1.jpg' },
  { id: 2, url: '/uploads/gallery2.jpg' }
])

onMounted(() => {
  tinymce.init({
    selector: '#post_content',
    language: 'pl',
    plugins: 'advlist autolink lists link image charmap preview anchor searchreplace visualblocks code fullscreen insertdatetime media table code help wordcount',
    toolbar: 'undo redo | blocks | bold italic underline forecolor backcolor | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media | preview code fullscreen',
    images_file_types: 'jpg,svg,webp,png,jpeg',
    file_picker_types: 'file image media',
    automatic_uploads: true,
    images_upload_url: '/panel-admina/upload-image-endpoint',
    media_live_embeds: true,
    relative_urls: false,
    remove_script_host: false,
    convert_urls: true,
    license_key: '',
    base_url: 'https://cdn.tiny.cloud/1/no-api-key/tinymce/7'

  })
})

function handleSubmit() {
  // Send `form.value` data via API (axios, fetch)
  console.log('Form submitted:', form.value)
}

function onMainImageChange(event) {
  form.value.main_image = event.target.files[0]
}

function onGalleryChange(event) {
  form.value.gallery = Array.from(event.target.files)
}

function removeImage(imageId) {
  // Call delete API, then remove locally
  gallery.value = gallery.value.filter(img => img.id !== imageId)
}
</script>

