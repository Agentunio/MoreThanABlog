<template>
  <div class="container py-5">
    <h1 class="mb-4 text-center">Skontaktuj się z nami</h1>
    <div class="row justify-content-center">
      <div class="col-md-8 col-lg-6">
        <div v-if="errors.length" class="text-danger">
          <h2>Liczba błędów do poprawy przed publikacją wynosi: {{ errors.length }}</h2>
          <ul>
            <li v-for="(error, index) in errors" :key="index">{{ error }}</li>
          </ul>
        </div>

        <form @submit.prevent="submitForm">
          <div class="mb-3">
            <label for="name" class="form-label">Imię i nazwisko</label>
            <input
              v-model="contact.name"
              type="text"
              id="name"
              class="form-control"
              placeholder="Wpisz swoje imię"
            />
          </div>

          <div class="mb-3">
            <label for="email" class="form-label">Adres e-mail</label>
            <input
              v-model="contact.email"
              type="email"
              id="email"
              class="form-control"
              placeholder="twoj@email.com"
            />
          </div>

          <div class="mb-3">
            <label for="subject" class="form-label">Temat wiadomości</label>
            <input
              v-model="contact.subject"
              type="text"
              id="subject"
              class="form-control"
              placeholder="Temat wiadomości"
            />
          </div>

          <div class="mb-3">
            <label for="message" class="form-label">Wiadomość</label>
            <textarea
              v-model="contact.message"
              id="message"
              class="form-control"
              placeholder="Napisz swoją wiadomość tutaj..."
              rows="5"
            ></textarea>
          </div>

          <button type="submit" class="btn w-100">Wyślij</button>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref } from 'vue'

const contact = reactive({
  name: '',
  email: '',
  subject: '',
  message: '',
})

const errors = ref([])

const submitForm = async () => {
  errors.value = []

  // Podstawowa walidacja klienta (opcjonalna)
  if (!contact.name) errors.value.push('Imię i nazwisko jest wymagane.')
  if (!contact.email || !contact.email.includes('@')) errors.value.push('Podaj poprawny e-mail.')
  if (!contact.subject) errors.value.push('Temat jest wymagany.')
  if (!contact.message) errors.value.push('Wiadomość nie może być pusta.')

  if (errors.value.length > 0) return

  try {
    const response = await fetch('/api/contact', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(contact),
    })

    if (!response.ok) {
      const data = await response.json()
      errors.value = data.errors || ['Wystąpił błąd podczas wysyłania formularza.']
      return
    }

    alert('Wiadomość została wysłana!')
    contact.name = ''
    contact.email = ''
    contact.subject = ''
    contact.message = ''
  } catch (error) {
    errors.value.push('Nie udało się połączyć z serwerem.')
  }
}
</script>

