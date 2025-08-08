<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import Editor from '@tinymce/tinymce-vue'
import api from '@/api' 
console.log('api instance:', api)
const props  = defineProps({ isNew: { type: Boolean, default: true } })
const route  = useRoute()
const router = useRouter()

const form    = ref({
  title: '', content: '', custom_date: '', user_id: '',
  main_image: null, gallery: []
})
const users   = ref([])  
const errors  = ref([])
const loading = ref(false)

onMounted(async () => {
  if (props.isNew) return
  try {
    const { data } = await api.get(`/api/posts/${route.params.slug}`)
    Object.assign(form.value, { gallery: [], ...data.data })
  } catch (e) {
    console.error(e)
    router.push('/panel-admina')
  }
})

function onMainImageChange (e) { form.value.main_image = e.target.files[0] }
function onGalleryChange   (e) { form.value.gallery    = [...e.target.files] }
function removeImage (id)       { form.value.gallery.splice(id, 1) }

async function handleSubmit () {
  errors.value  = []
  loading.value = true
  const fd      = new FormData()

  fd.append('post[title]',   form.value.title)
  fd.append('post[content]', form.value.content)
  if (form.value.custom_date) fd.append('post[custom_date]', form.value.custom_date)
  if (form.value.user_id)     fd.append('post[user_id]',     form.value.user_id)

  if (form.value.main_image)
    fd.append('post[main_image]', form.value.main_image)
  form.value.gallery.forEach(f =>
    fd.append('post[gallery][]', f)
  )

  try {
    if (props.isNew) {
      await api.post('/api/admin/posts', fd)   
    } else {
      await api.patch(`/api/admin/posts/${route.params.slug}`, fd)
    }
    router.push('/panel-admina')
  } catch (e) {
    if (e.response?.status === 422) {
      const apiErrors = e.response.data?.errors
      errors.value = Array.isArray(apiErrors)
        ? apiErrors
        : ['Wystąpił błąd walidacji.']
    } else {
      errors.value = ['Coś poszło nie tak – spróbuj ponownie.']
    }
  } finally { loading.value = false }
}


function tinyImageUpload (blobInfo) {
  const fd = new window.FormData()
  fd.append('file', blobInfo.blob(), blobInfo.filename())

  // Zwracamy PROMISE, który rozwiązuje się na STRING (URL)
  return api
    .post('/api/admin/upload-image-endpoint', fd)
    .then(res => {
      if (typeof res.data?.location === 'string') {
        return res.data.location          // ← tylko URL!
      }
      throw new Error('Brak pola location w odpowiedzi API')
    })
}
</script>




<template>
<h1>Nowy wpis</h1>
<div class="bd-example m-0 mb-3">
    <form @submit.prevent="handleSubmit">
      <div v-if="errors?.length" style="color:rgb(226, 19, 54);">
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
        <Editor
          api-key="omv36n529opjexgf4e04i5dxosf0ldbydjjf8w3td6to1hhc"
          v-model="form.content"
          :init="{
            language: 'pl',
            plugins: 'advlist autolink lists link image charmap preview anchor ' +
                    'searchreplace visualblocks code fullscreen insertdatetime ' +
                    'media table code help wordcount',
            toolbar: 'undo redo | blocks | bold italic underline forecolor backcolor | ' +
                    'alignleft aligncenter alignright alignjustify | bullist numlist ' +
                    'outdent indent | link image media | preview code fullscreen',
            images_upload_handler: tinyImageUpload,
            automatic_uploads: true,
            relative_urls: false,
            remove_script_host: false,
            convert_urls: true
          }"
        />
      </div>

      <div v-if="!props.isNew" class="mt-3">
        <p>Aktualna data wpisu to: {{ currentDate }}</p>
        <label for="custom_date" class="form-label d-block">Zmień datę wpisu na:</label>
        <input type="date" v-model="form.custom_date" class="form-control" />
      </div>

      <div v-if="!props.isNew" class="mt-3">
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
        <button type="submit" class="btn mt-2">{{ props.isNew ? 'Dodaj nowy wpis' : 'Zapisz zmiany' }}</button>
      </div>
    </form>

    <div v-if="!props.isNew && form.gallery?.length" class="mt-3">
      <h2>Aktualna galeria zdjęć</h2>
      <div class="d-flex gap-2 flex-wrap">
        <div v-for="(img, index) in form.gallery" :key="index" class="d-flex flex-column">
          <div class="gallery-img" :style="{ backgroundImage: 'url(' + img.url + ')' }"></div>
          <button @click="removeImage(index)" class="btn mt-2">Usuń to zdjęcie</button>
        </div>
      </div>
    </div>
  </div>
  <RouterLink to="/panel-admina">Wróć</RouterLink>
</template>
