<template>
  <div>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">Tytuł</th>
          <th scope="col">Edytuj</th>
          <th scope="col">Usuń</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="page in pages" :key="page.id">
          <td>{{ page.title }}</td>
          <td>
            <RouterLink :to="`/admin/pages/${page.id}/edit`" class="btn">
              Edytuj
            </RouterLink>
          </td>
          <td>
            <button @click="deletePage(page.id)" class="btn">
              Usuń
            </button>
          </td>
        </tr>
      </tbody>
    </table>

    <div>
      <router-link to="/admin" class="btn">Wróć</router-link>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const pages = ref([])

const fetchPages = async () => {
  try {
    const res = await fetch('/api/admin/pages')
    if (!res.ok) throw new Error('Błąd podczas pobierania stron')
    pages.value = await res.json()
  } catch (e) {
    console.error(e)
  }
}

const deletePage = async (id) => {
  if (!confirm('Na pewno chcesz usunąć tę stronę?')) return

  try {
    const res = await fetch(`/api/admin/pages/${id}`, {
      method: 'DELETE',
    })
    if (!res.ok) throw new Error('Nie udało się usunąć strony')

    pages.value = pages.value.filter((p) => p.id !== id)
  } catch (e) {
    console.error('Błąd usuwania strony:', e)
  }
}

onMounted(() => {
  fetchPages()
})
</script>

