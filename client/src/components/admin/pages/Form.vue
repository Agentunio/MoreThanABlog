<template>
  <div class="bd-example m-0">
    <form @submit.prevent="submitForm">
      <div v-if="errors.length" style="color:rgb(226, 19, 54);">
        <h2>Liczba błędów do poprawy przed publikacją wynosi: {{ errors.length }}</h2>
        <ul>
          <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
        </ul>
      </div>

      <div>
        <label class="form-label d-block">Tytuł strony</label>
        <input
          v-model="page.title"
          type="text"
          class="form-control"
          required
        />
      </div>

      <div class="mt-3">
        <label class="form-label d-block">Zawartość strony</label>
        <textarea id="page_content" v-model="page.content" class="form-control" />
      </div>

      <div class="mt-3">
        <label class="form-label d-block">Wybierz stronę nadrzędną</label>
        <select
          v-model="page.parent_id"
          class="form-select"
        >
          <option value="">Brak rodzica</option>
          <option v-for="parent in pages" :key="parent.id" :value="parent.id">
            {{ parent.title }}
          </option>
        </select>
      </div>

      <div class="form-check mt-3">
        <input
          v-model="page.in_nav"
          type="checkbox"
          class="form-check-input"
          id="in_nav"
        />
        <label for="in_nav" class="form-check-label">Strona ma być dodana do nav</label>
      </div>

      <div>
        <button type="submit" class="btn mt-3">
          {{ isEditMode ? 'Zapisz zmiany' : 'Dodaj nową stronę' }}
        </button>
      </div>
    </form>
  </div>
  
</template>

<script setup>
import { ref, onMounted } from 'vue'


const page = ref({
  title: '',
  content: '',
  parent_id: '',
  in_nav: false
})

const errors = ref([])
const pages = ref([])
const isEditMode = ref(false) // można też ustawić z route param

onMounted(async () => {



  // Załaduj strony nadrzędne (jeśli są)
  try {
    const res = await fetch('/api/admin/pages')
    const data = await res.json()
    pages.value = data
  } catch (e) {
    console.error('Błąd ładowania stron nadrzędnych:', e)
  }
})

const submitForm = async () => {
  errors.value = []

  if (!page.value.title.trim()) {
    errors.value.push('Tytuł nie może być pusty.')
  }

  if (!page.value.content.trim()) {
    errors.value.push('Treść strony nie może być pusta.')
  }

  if (errors.value.length) return

  try {
    const response = await fetch(isEditMode.value
      ? `/api/admin/pages/${page.value.id}`
      : '/api/admin/pages',
      {
        method: isEditMode.value ? 'PATCH' : 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(page.value)
      }
    )

    if (!response.ok) throw new Error('Błąd serwera')

    alert('Strona została zapisana!')
    // Redirect or reset form as needed
  } catch (e) {
    console.error(e)
    errors.value.push('Nie udało się zapisać strony.')
  }
}
</script>