<template>
  <div class="bd-example mt-3 m-0">
    <h1>Zarejestruj się</h1>

    <form @submit.prevent="handleRegister">
      <div v-if="errors.length" class="alert alert-danger">
        <h5>Liczba błędów: {{ errors.length }}</h5>
        <ul>
          <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
        </ul>
      </div>

      <div class="field">
        <label for="username" class="form-label d-block">Twój nick</label>
        <input v-model="form.username" type="text" id="username" class="form-control" autofocus />
      </div>

      <div class="field mt-2">
        <label for="email" class="form-label d-block">Email</label>
        <input v-model="form.email" type="email" id="email" class="form-control" autocomplete="email" />
      </div>

      <div class="field mt-2">
        <label for="password" class="form-label d-block">Podaj hasło</label>
        <em v-if="minimumPasswordLength">(minimum {{ minimumPasswordLength }} znaków)</em>
        <input v-model="form.password" type="password" id="password" class="form-control" autocomplete="new-password" />
      </div>

      <div class="field mt-2">
        <label for="password_confirmation" class="form-label d-block">Potwierdź hasło</label>
        <input v-model="form.password_confirmation" type="password" id="password_confirmation" class="form-control" autocomplete="new-password" />
      </div>

      <div class="actions">
        <button type="submit" class="btn mt-2 mb-2">Zarejestruj się</button>
      </div>
    </form>

    <RouterLink to="/users/sign-in" >Masz już konto? Zaloguj się</RouterLink>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const form = ref({
  username: '',
  email: '',
  password: '',
  password_confirmation: ''
})

const minimumPasswordLength = 6 // lub pobierz z meta/config
const errors = ref([])

const handleRegister = async () => {
  errors.value = []

  try {
    const res = await fetch('/users', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')?.content
      },
      body: JSON.stringify({ user: form.value })
    })

    if (!res.ok) {
      const data = await res.json()
      errors.value = data.errors || ['Nie udało się zarejestrować.']
      return
    }

    router.push('/panel-admina') // lub inna strona po rejestracji
  } catch (err) {
    errors.value = ['Wystąpił błąd połączenia z serwerem.']
  }
}
</script>
