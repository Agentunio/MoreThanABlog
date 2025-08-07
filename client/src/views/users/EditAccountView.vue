<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import axios from 'axios'

const router = useRouter()

const form = ref({
  username: '',
  email: '',
  password: '',
  password_confirmation: '',
  current_password: ''
})

const errors = ref([])

const getToken = () => {
  const token = localStorage.getItem('jwt')
  if (!token) {
    router.push('/login')
    return null
  }
  return token
}

const fetchCurrentUser = async () => {
  const token = getToken()
  if (!token) return;

  try {
    const response = await axios.get('http://localhost:3001/api/current_user', {
      headers: { 'Authorization': `Bearer ${token}` }
    });
    
    form.value.email = response.data.email;
    form.value.username = response.data.username;

  } catch (error) {
    console.error("Nie udało się pobrać danych użytkownika:", error);
  }
}

onMounted(() => {
  fetchCurrentUser();
})


const handleUpdate = async () => {
  errors.value = [];
  const token = getToken();
  if (!token) return;

  const payload = {
    user: {
      email: form.value.email,
      username: form.value.username,
      current_password: form.value.current_password
    }
  }

  if (form.value.password) {
    payload.user.password = form.value.password
    payload.user.password_confirmation = form.value.password_confirmation
  }

  try {
    const response = await axios.patch('http://localhost:3001/users', payload, {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Accept': 'application/json'
      }
    })

    if (response.status === 200) {
      alert('Konto zostało zaktualizowane!');
    }
  } catch (error) {
    if (error.response && error.response.status === 422) {
      errors.value = error.response.data.status.errors;
    } else {
      errors.value.push('Wystąpił nieoczekiwany błąd serwera.');
      console.error(error);
    }
  }
}

const handleDelete = async () => {
  if (!confirm('Czy jesteś pewny, że chcesz usunąć konto? Ta operacja jest nieodwracalna.')) return;

  const token = getToken()
  if (!token) return

  try {
    const response = await axios.delete('http://localhost:3001/users', {
      headers: {
        'Authorization': `Bearer ${token}`,
        'Accept': 'application/json'
      }
    })

    if (response.status === 200 || response.status === 204) {
      alert('Konto zostało usunięte.');
      localStorage.removeItem('jwt');
    }
  } catch (error) {
    errors.value.push('Nie udało się usunąć konta. Spróbuj ponownie.');
    console.error(error);
  }
}
</script>


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