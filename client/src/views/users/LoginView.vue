<template>
  <div class="bd-example mt-3 m-0">
    <h1>Zaloguj się</h1>

    <form @submit.prevent="handleLogin">
      <div class="field mt-2">
        <label for="email" class="form-label d-block">Email</label>
        <input
          type="email"
          id="email"
          v-model="email"
          class="form-control"
          autocomplete="email"
          autofocus
          required
        />
      </div>

      <div class="field mt-2">
        <label for="password" class="form-label d-block">Hasło</label>
        <input
          type="password"
          id="password"
          v-model="password"
          class="form-control"
          autocomplete="current-password"
          required
        />
      </div>

      <div class="actions">
        <button type="submit" class="btn mt-2 mb-2">Zaloguj się</button>
      </div>
    </form>

    <div class="mt-2">
      <!-- Możesz użyć <router-link> jeśli korzystasz z Vue Router -->
      <RouterLink to="/users/sign_up">Nie masz konta? Zarejestruj się</RouterLink><br />
      <RouterLink to="/users/password/new">Zapomniałeś hasła?</RouterLink>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'

const email = ref('')
const password = ref('')

const handleLogin = async () => {
  try {
    const response = await fetch('/users/sign_in', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]')?.content
      },
      body: JSON.stringify({
        user: { email: email.value, password: password.value }
      })
    })

    if (!response.ok) throw new Error('Błąd logowania')

    // Możesz przekierować lub wyświetlić powiadomienie
    window.location.href = '/panel-admina'
  } catch (error) {
    alert('Nieprawidłowe dane logowania.')
  }
}
</script>
