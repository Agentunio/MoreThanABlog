<script setup>
import { ref } from 'vue';
import { useRouter } from 'vue-router';
import axios from 'axios';

const router = useRouter();

const form = ref({
  username: '',
  email: '',
  password: '',
  password_confirmation: ''
})

const errors = ref([]);

const handleRegister = async () => {
  errors.value = [];

  const password = form.value.password;
  const passwordConfirmation = form.value.password_confirmation;

  if (password !== passwordConfirmation) {
    errors.value.push('Hasła nie pasują do siebie.');
    return;
  }
  
  if (!password || password.length < 6) {
    errors.value.push('Hasło jest za krótkie (minimum 6 znaków).');
    return;
  }

  try {
    const response = await axios.post('http://localhost:3001/users', {
      user: {
        username: form.value.username,
        email: form.value.email,
        password: form.value.password,
        password_confirmation: form.value.password_confirmation
      }
    });

    if (response == 200 || response.status === 201){
      router.push('/users/sign-in');
    }
  } catch (err) {
    errors.value = ['Wystąpił błąd połączenia z serwerem.']
  }
}
</script>


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
        <em>(minimum 6 znaków)</em>
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
