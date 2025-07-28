<template>
  <h1>Edytuj swoje konto</h1>
  <div class="bd-example m-0">

    <form @submit.prevent="handleUpdate">
      <div v-if="errors.length" class="alert alert-danger">
        <h5>Liczba błędów: {{ errors.length }}</h5>
        <ul>
          <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
        </ul>
      </div>

      <div class="field">
        <label for="username" class="form-label">Twój nick</label>
        <input v-model="form.username" type="text" id="username" class="form-control" autofocus />
      </div>

      <div class="field mt-3">
        <label for="email" class="form-label">Twój email</label>
        <input v-model="form.email" type="email" id="email" class="form-control" autocomplete="email" />
      </div>

      <div class="field mt-3">
        <label for="password" class="form-label">Nowe hasło</label>
        <i>(pozostaw puste jeśli nie chcesz zmienić)</i>
        <input v-model="form.password" type="password" id="password" class="form-control" autocomplete="new-password" />
      </div>

      <div class="field mt-3">
        <label for="password_confirmation" class="form-label">Potwierdź nowe hasło</label>
        <input v-model="form.password_confirmation" type="password" id="password_confirmation" class="form-control" autocomplete="new-password" />
      </div>

      <div class="field mt-3">
        <label for="current_password" class="form-label">Twoje obecne hasło</label>
        <input v-model="form.current_password" type="password" id="current_password" class="form-control" autocomplete="current-password" />
      </div>

      <div class="actions">
        <button type="submit" class="btn mt-3">Zapisz zmiany</button>
      </div>
    </form>
  </div>

  <h2 class="mt-4">Usuń swoje konto</h2>
    <button @click="handleDelete" class="btn" style="background-color: #FA003F">Usuń konto</button>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// Załaduj dane użytkownika z propsów lub zapytania do API
const form = ref({
  username: '',
  email: '',
  password: '',
  password_confirmation: '',
  current_password: ''
})

const errors = ref([])

const handleUpdate = async () => {
  errors.value = []
  try {
    const res = await fetch('/users', {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')?.content
      },
      body: JSON.stringify({ user: form.value })
    })

    if (!res.ok) {
      const data = await res.json()
      errors.value = data.errors || ['Coś poszło nie tak przy aktualizacji konta.']
      return
    }

    router.push('/panel-admina')
  } catch (err) {
    errors.value = ['Wystąpił błąd połączenia z serwerem.']
  }
}

const handleDelete = async () => {
  if (!confirm('Czy jesteś pewny, że chcesz usunąć konto?')) return

  try {
    const res = await fetch('/users', {
      method: 'DELETE',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')?.content
      }
    })

    if (!res.ok) {
      alert('Nie udało się usunąć konta.')
      return
    }

    window.location.href = '/'
  } catch (err) {
    alert('Wystąpił błąd przy usuwaniu konta.')
  }
}
</script>
