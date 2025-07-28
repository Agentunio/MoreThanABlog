<script setup>
import { RouterLink } from 'vue-router';


</script>

<template>
  <h1>Panel administracyjny</h1>
  <div>
  <RouterLink to="/panel-admina/wpisy/new" class="btn me-1">Dodaj nowy wpis</RouterLink>
  <RouterLink to="/panel-admina/wpisy/lista" class="btn me-1">Edytuj lub usuń wpis</RouterLink>

  <RouterLink to="/panel-admina/role/new" class="btn me-1">Dodaj role</RouterLink>
  <RouterLink to="/panel-admina/role/lista" class="btn me-1">Edytuj lub usuń role</RouterLink>
 
  <RouterLink to="/panel-admina/uzytkownicy" class="btn me-1">Zarządzaj użytkownikami</RouterLink>

  <RouterLink to="/panel-admina/strony/new" class="btn me-1">Dodaj nowa stronę</RouterLink>
  <RouterLink to="/panel-admina/strony/lista" class="btn">Edytuj lub usuń stronę</RouterLink>
  </div>
</template>