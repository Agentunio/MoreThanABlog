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
        <tr v-for="role in roles" :key="role.id">
          <td>{{ role.name }}</td>
          <td>
            <RouterLink :to="`/admin/roles/${role.id}/edit`" class="btn">Edytuj</RouterLink>
          </td>
          <td>
            <button @click="deleteRole(role.id)" class="btn">Usuń</button>
          </td>
        </tr>
      </tbody>
    </table>

    <div class="mt-3">
      <RouterLink to="/panel-admina" class="btn">Wróć</RouterLink>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

// Zakładamy, że role będą pobierane z API
const roles = ref([])

onMounted(async () => {
  try {
    const response = await fetch('/api/admin/roles') // przykładowy endpoint
    const data = await response.json()
    roles.value = data
  } catch (error) {
    console.error('Błąd ładowania ról:', error)
  }
})

const deleteRole = async (id) => {
  if (!confirm('Czy na pewno chcesz usunąć tę rolę?')) return

  try {
    await fetch(`/api/admin/roles/${id}`, {
      method: 'DELETE'
    })

    // Usuń rolę z lokalnej listy
    roles.value = roles.value.filter(role => role.id !== id)
  } catch (error) {
    console.error('Błąd podczas usuwania roli:', error)
  }
}
</script>
