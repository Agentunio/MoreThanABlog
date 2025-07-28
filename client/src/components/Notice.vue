<template>
  <aside>
    <!-- NOTICE -->
    <div
      v-if="notice"
      class="toast position-fixed show"
      role="alert"
      aria-live="assertive"
      aria-atomic="true"
      :style="{ display: 'block', opacity: 1 }"
      data-bs-autohide="true"
    >
      <div class="toast-header" style="border-color: #88c5c2;">
        <img
          :src="logo"
          class="rounded me-2"
          alt="Logo"
          style="width: 30px; height: 30px;"
        />
        <strong class="me-auto">Wpisy o życiu</strong>
        <button type="button" class="btn-close" @click="notice = ''" aria-label="Close"></button>
      </div>
      <div class="toast-body">
        {{ notice }}
      </div>
    </div>

    <!-- ALERT -->
    <div
      v-if="alert"
      class="toast position-fixed show"
      role="alert"
      aria-live="assertive"
      aria-atomic="true"
      :style="{ display: 'block', opacity: 1, borderColor: '#FA003F' }"
      data-bs-autohide="true"
    >
      <div class="toast-header" style="border-color: #FA003F;">
        <img
          :src="logo"
          class="rounded me-2"
          alt="Logo"
          style="width: 30px; height: 30px;"
        />
        <strong class="me-auto">Wpisy o życiu</strong>
        <button type="button" class="btn-close" @click="alert = ''" aria-label="Close"></button>
      </div>
      <div class="toast-body">
        {{ alert }}
      </div>
    </div>
  </aside>
</template>

<script setup>
import { ref } from 'vue'
import logo from '../assets/logo.png'
// Możesz przekazywać wartości jako props lub ustawiać je globalnie
const notice = ref('')
const alert = ref('')

// Przykład: możesz ustawiać notice/alert z zewnątrz przez emit/event, Pinia lub props
// notice.value = 'Udało się zalogować!'
// alert.value = 'Błąd logowania!'
</script>
