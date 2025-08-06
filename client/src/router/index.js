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
import PostView from '../views/PostView.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      component: HomeView,
    },
    {
      path: '/wpisy/:slug',
      component: PostView,
    },
    {
      path: '/:slug',
      component: PageView,
    },
    {
      path: '/panel-admina',
      component: DashboardView,
    },
    {
      path: '/panel-admina/wpisy/new',
      component: PostsAddView,
    },
    {
      path: '/panel-admina/wpisy/lista',
      component: PostsListView,
    },
    {
      path: '/panel-admina/role/new',
      component: RoleAddView
    },
    {
      path: '/panel-admina/role/lista',
      component: RolesListView
    },
    {
      path: '/panel-admina/uzytkownicy',
      component: UserDashboardView
    },
    {
      path: '/panel-admina/strony/new',
      component: PagesAddView
    },
    {
      path: '/panel-admina/strony/lista',
      component: PagesListView
    },
    {
      path: '/kontakt',
      component: ContactView
    },
    {
      path: '/users/sign-in',
      component: LoginView
    },
    {
      path: '/users/edit',
      component: EditAccountView
    },
    {
      path: '/users/sign_up',
      component: RegisterAccountView
    },
    {
      path: '/users/password/new',
      component: NewPasswordView
    },
    {
      path: '/logout'
    }
],
});

export default router;