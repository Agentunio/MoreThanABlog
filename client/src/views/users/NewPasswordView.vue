<template>
  <div class="bd-example m-0 mb-3">
    <h2>Zapomniałeś hasła?</h2>

    <form @submit.prevent="handleReset">
      <div v-if="errors.length" class="alert alert-danger">
        <ul>
          <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
        </ul>
      </div>

      <div class="field">
        <label for="email" class="form-label">Podaj swój email</label>
        <input
          v-model="email"
          type="email"
          id="email"
          class="form-control"
          autocomplete="email"
          autofocus
        />
      </div>

      <div class="actions">
        <button type="submit" class="btn mt-3">
          Wyślij mi instrukcję z resetowania hasła
        </button>
      </div>
    </form>
    <div class="mt-3">
      <RouterLink to="/users/sign_up">Nie masz konta? Zarejestruj się</RouterLink><br/>
      <RouterLink to="/users/sign-in">Wróć do logowania</RouterLink>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const email = ref('')
const errors = ref([])

const handleReset = async () => {
  errors.value = []

  try {
    const response = await fetch('/password', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')?.content
      },
      body: JSON.stringify({
        user: { email: email.value }
      })
    })

    const data = await response.json()

    if (!response.ok) {
      errors.value = data.errors || ['Wystąpił problem z resetem hasła.']
      return
    }

    errors.value = [`Wysłano instrukcje na adres ${email.value}`]
    email.value = ''
  } catch (err) {
    errors.value = ['Błąd połączenia z serwerem.']
  }
}
</script>
