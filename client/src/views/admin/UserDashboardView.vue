<template>
  <div>
    <table class="table">
      <thead>
        <tr>
          <th scope="col">Nick użytkownika</th>
          <th scope="col">Mail użytkownika</th>
          <th scope="col">Aktualna rola</th>
          <th scope="col">Przydziel inną rolę</th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="user in users" :key="user.id">
          <td>{{ user.username }}</td>
          <td>{{ user.email }}</td>
          <td>{{ user.role?.name || 'Brak' }}</td>
          <td>
            <form @submit.prevent="updateRole(user)">
              <select
                v-model="user.newRole"
                class="form-select"
                required
              >
                <option disabled value="">Przydziel rolę</option>
                <option
                  v-for="role in roles"
                  :key="role.id"
                  :value="role.name"
                >
                  {{ role.name }}
                </option>
              </select>
              <button type="submit" class="btn mt-2">Zapisz rolę</button>
            </form>
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

// Dane użytkowników i ról
const users = ref([])
const roles = ref([])

onMounted(async () => {
  try {
    const [usersRes, rolesRes] = await Promise.all([
      fetch('/api/admin/users'),
      fetch('/api/admin/roles')
    ])
    const usersData = await usersRes.json()
    const rolesData = await rolesRes.json()

    // Dodaj pole `newRole` do każdego użytkownika
    users.value = usersData.map(user => ({
      ...user,
      newRole: user.role?.name || ''
    }))
    roles.value = rolesData
  } catch (error) {
    console.error('Błąd ładowania danych:', error)
  }
})

const updateRole = async (user) => {
  try {
    await fetch(`/api/admin/users/${user.id}/save`, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ role_name: user.newRole })
    })

    alert(`Rola użytkownika ${user.username} została zaktualizowana.`)
    // Możesz też odświeżyć user.role z backendu, jeśli chcesz
    user.role = { name: user.newRole }
  } catch (error) {
    console.error('Błąd aktualizacji roli:', error)
    alert('Wystąpił błąd przy zapisie roli.')
  }
}
</script>

