<template>
  <div class="bd-example m-0">
    <form @submit.prevent="handleSubmit">
      <div v-if="errors.length" style="color:rgb(226, 19, 54);">
        <h2>Liczba błędów do poprawy wynosi: {{ errors.length }}</h2>
        <ul>
          <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
        </ul>
      </div>

      <div>
        <label for="name" class="form-label d-block">Nazwa roli</label>
        <input
          type="text"
          id="name"
          v-model="form.name"
          class="form-control"
          required
        />
      </div>

      <h4 class="mt-2 mb-2">Rola ma mieć uprawienia do:</h4>

      <div class="form-check" v-for="permission in permissions" :key="permission.key">
        <input
          type="checkbox"
          class="form-check-input"
          :id="permission.key"
          v-model="form[permission.key]"
        />
        <label :for="permission.key" class="form-check-label">{{ permission.label }}</label>
      </div>

      <div>
        <button type="submit" class="btn mt-2">
          {{ isEditMode ? 'Zapisz zmiany' : 'Dodaj użytkownika' }}
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const isEditMode = ref(false) // ustaw true jeśli edytujesz, false jeśli dodajesz

const form = ref({
  name: '',
  panelpriv: false,
  postspriv: false,
  rolespriv: false,
  userspriv: false,
  pagespriv: false
})

const errors = ref([])

const permissions = [
  { key: 'panelpriv', label: 'Panel admina' },
  { key: 'postspriv', label: 'Zarządzanie wpisami' },
  { key: 'rolespriv', label: 'Zarządzanie rolami' },
  { key: 'userspriv', label: 'Zarządzanie użytkownikami' },
  { key: 'pagespriv', label: 'Zarządzanie stronami' }
]

const handleSubmit = async () => {
  errors.value = []

  // Walidacja lokalna
  if (!form.value.name) {
    errors.value.push('Nazwa roli jest wymagana')
    return
  }

  try {
    // Tu wpisz zapytanie POST lub PUT do API
    const url = isEditMode.value
      ? `/api/admin/roles/${form.value.id}`
      : `/api/admin/roles`
    const method = isEditMode.value ? 'PUT' : 'POST'

    await fetch(url, {
      method,
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify(form.value)
    })

    // Przekierowanie lub komunikat sukcesu
    alert('Zapisano rolę!')
  } catch (err) {
    console.error(err)
    errors.value.push('Wystąpił błąd przy zapisie')
  }
}
</script>

<style scoped>
.form-check {
  margin-bottom: 0.5rem;
}
</style>
