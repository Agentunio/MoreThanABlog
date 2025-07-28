import { createRouter, createWebHistory } from 'vue-router';
import HomeView from '../views/HomeView.vue';
import PageView from '../views/PageView.vue';
import DashboardView from '../views/admin/DashboardView.vue';
import PostsAddView from '../views/admin/PostsAddView.vue';
import PostsListView from '../views/admin/PostsListView.vue';
import RoleAddView from '../views/admin/RoleAddView.vue';
import RolesListView from '../views/admin/RolesListView.vue';
import UserDashboardView from '../views/admin/UserDashboardView.vue';
import PagesAddView from '../views/admin/PagesAddView.vue';
import PagesListView from '../views/admin/PagesListView.vue';
import ContactView from '../views/ContactView.vue';
import LoginView from '../views/users/LoginView.vue';
import EditAccountView from '../views/users/EditAccountView.vue';
import RegisterAccountView from '../views/users/RegisterAccountView.vue';
import NewPasswordView from '../views/users/NewPasswordView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'home',
      component: HomeView,
    },
    {
      path: '/o-nas',
      name: 'O nas',
      component: PageView,
    },
    {
      path: '/panel-admina',
      name: 'admin',
      component: DashboardView,
    },
    {
      path: '/panel-admina/wpisy/new',
      name: 'postadd',
      component: PostsAddView,
    },
    {
      path: '/panel-admina/wpisy/lista',
      name: 'postlista',
      component: PostsListView,
    },
    {
      path: '/panel-admina/role/new',
      name: 'roleadd',
      component: RoleAddView
    },
    {
      path: '/panel-admina/role/lista',
      name: 'rolelist',
      component: RolesListView
    },
    {
      path: '/panel-admina/uzytkownicy',
      name: 'usersdashobard',
      component: UserDashboardView
    },
    {
      path: '/panel-admina/strony/new',
      name: 'pagesadd',
      component: PagesAddView
    },
    {
      path: '/panel-admina/strony/lista',
      name: 'pageslist',
      component: PagesListView
    },
    {
      path: '/kontakt',
      name: 'contact',
      component: ContactView
    },
    {
      path: '/users/sign-in',
      name: 'login',
      component: LoginView
    },
    {
      path: '/users/edit',
      name: 'editaccount',
      component: EditAccountView
    },
    {
      path: '/users/sign_up',
      name: 'registeraccount',
      component: RegisterAccountView
    },
    {
      path: '/users/password/new',
      name: 'newpassword',
      component: NewPasswordView
    },
    {
      path: '/logout',
      name: 'logut'
    }
],
});

export default router;