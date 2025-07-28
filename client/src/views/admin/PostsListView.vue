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
        <tr v-for="post in posts" :key="post.id">
          <td>{{ post.title }}</td>
          <td>
            <RouterLink :to="`/panel-admina/wpisy/${post.id}/edit`" class="btn">Edytuj</RouterLink>
          </td>
          <td>
            <button @click="deletePost(post.id)" class="btn">Usuń</button>
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
import { ref } from 'vue'
import { useRouter } from 'vue-router'

// Zakładamy, że dostajesz posty z API
const posts = ref([
  { id: 1, title: 'Pierwszy wpis' },
  { id: 2, title: 'Drugi wpis' }
  // lub fetchowane z API – tutaj dla przykładu statycznie
])

const router = useRouter()

const deletePost = async (id) => {
  if (!confirm('Czy na pewno chcesz usunąć ten wpis?')) return

  try {
    // Zakładamy, że masz endpoint API
    await fetch(`/api/admin/posts/${id}`, {
      method: 'DELETE'
    })
    posts.value = posts.value.filter(post => post.id !== id)
  } catch (error) {
    console.error('Błąd usuwania:', error)
  }
}
</script>