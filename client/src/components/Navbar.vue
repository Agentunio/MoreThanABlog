<script setup>
import logo from "../assets/logo.png"
</script>

<template>
  <nav class="navbar bg-dark navbar-expand-lg" data-bs-theme="dark">
  <div class="container-fluid">
    <RouterLink to="/"><img :src="logo" style="height: 70px;"/></RouterLink>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse  navbar-collapse" id="navbarNav">
      <ul class="ms-auto navbar-nav">
          <li class="nav-item me-3">
              <RouterLink to="/" class="nav-link active">Strona główna</RouterLink>
          </li>
          <li class="nav-item d-flex dropdown">
              <RouterLink to="/o-nas" class="nav-link active">O nas</RouterLink>
          </li>
          <li class="nav-item me-3">
            <RouterLink to="/panel-admina" class="nav-link active">Panel admina</RouterLink>
          </li>
          <li class="nav-item me-3">
            <RouterLink to="/users/edit" class="nav-link active">Edytuj swoje konto</RouterLink>
          </li>
          <li class="nav-item me-3">
            <RouterLink to="/logout" class="nav-link active">Wyloguj się</RouterLink>
          </li>
          <li class="nav-item me-3">
            <RouterLink to="/users/sign-in" class="nav-link active">Zaloguj się</RouterLink>
          </li>
          <li class="nav-item me-3">
            <RouterLink to="/users/sign_up" class="nav-link active">Zarejestruj się</RouterLink>
          </li>
      
      <li class="nav-item me-3">
        <RouterLink to="/kontakt" class="nav-link active">Kontakt</RouterLink>
      </li>

      </ul>
    </div>
  </div>
</nav>
</template>