import axios from 'axios'

const api = axios.create({
  baseURL: 'http://localhost:3001',
  headers: { Accept: 'application/json' }
})

const stored = localStorage.getItem('jwt')  
if (stored) api.defaults.headers.common.Authorization = stored

export default api
