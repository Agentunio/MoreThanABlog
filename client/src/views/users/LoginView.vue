<script setup>
import { ref, onMounted } from 'vue'
import { useRouter }     from 'vue-router'
import axios             from 'axios'

const api = axios.create({
  baseURL: 'http://localhost:3001',
  headers: { Accept: 'application/json' }
})

onMounted(() => {
  const stored = localStorage.getItem('jwt')  
  if (stored) api.defaults.headers.common.Authorization = stored
})

const router   = useRouter()
const email    = ref('')
const password = ref('')
const errors   = ref([])

const handleLogin = async () => {
  errors.value = []

  try {
    const resp = await api.post('/users/sign_in', {  
      user: { email: email.value, password: password.value }
    })

    const bearer = resp.headers.authorization 
    if (!bearer?.startsWith('Bearer ')) {
      errors.value.push('Serwer nie zwrócił tokenu.')
      return
    }

    localStorage.setItem('jwt', bearer) 
    api.defaults.headers.common.Authorization = bearer  

    router.push('/')    
  } catch (err) {
    if (err.response?.status === 401) {
      errors.value.push('Nieprawidłowy email lub hasło.')
    } else {
      console.error(err)
      errors.value.push('Błąd połączenia z serwerem.')
    }
  }
}
</script>



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
      <RouterLink to="/users/sign_up">Nie masz konta? Zarejestruj się</RouterLink><br />
      <RouterLink to="/users/password/new">Zapomniałeś hasła?</RouterLink>
    </div>
  </div>
</template>
