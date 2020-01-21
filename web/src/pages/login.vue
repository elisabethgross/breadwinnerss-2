<template>
  <div class="login">
    <form
      v-if="!showResetForm &&!resetSubmitted"
      class="form">
      <img
        :src="logo"
        class="logo">
      <b-field
        label="email"
        type="is-info"
        label-position="on-border">
        <b-input
          v-model="loginUser.username"
          type="text"
          placeholder="email" />
      </b-field>
      <b-field
        label="password"
        type="is-info"
        label-position="on-border">
        <b-input
          v-model="loginUser.password"
          type="password"
          placeholder="password" />
      </b-field>
      <b-button
        type="is-primary"
        @click="login">
        Login
      </b-button>
      <b-button
        type="is-secondary"
        style="margin-left:7px;"
        @click="toggleResetForm">
        Reset Password
      </b-button>
      <p
        v-if="error">
        {{ error }}
      </p>
    </form>
    <form
      v-if="showResetForm"
      class="form"
      @submit.prevent="">
      <b-field
        label="email"
        type="is-info"
        label-position="on-border">
        <b-input
          v-model="resetUser.email"
          type="text"
          label-position="on-border" />
      </b-field>
      <b-button
        @click="sendResetLink">
        Send reset link
      </b-button>
    </form>
    <p
      v-if="resetSubmitted">
      If an account was found with that email address, an email with a reset link was sent to your inbox!
    </p>
  </div>
</template>

<script>
import axios from 'axios'
import logo from '../assets/breadwinnerss-logo-fun.png'

axios.defaults.withCredentials = true

export default {
  name: 'Login',
  inject: ['apiURL'],
  props: {
    'user': {
      type: Object,
      required: false,
      default: () => {}
    }
  },
  data () {
    return {
      logo,
      loginUser: {
        username: '',
        password: ''
      },
      resetUser: {
        email: ''
      },
      showResetForm: false,
      resetSubmitted: false,
      error: ''
    }
  },
  mounted () {
    if (this.user && this.user.user_id) {
      this.$router.push(`/feed/${this.user.url}?name=${this.user.users_name}&email=${this.user.email}`)
    }
  },
  methods: {
    async login () {
      try {
        await axios.post(`${this.apiURL}/login`, {
          username: this.loginUser.username,
          password: this.loginUser.password
        })
        this.$emit('login')
      } catch(e) {
        this.error = 'Something was wrong with your login credentials.'
      }
    },
    toggleResetForm () {
      this.showResetForm = !this.showResetForm
    },
    async sendResetLink () {
      await axios.post(`${this.apiURL}/forgot`, { email: this.resetUser.email})
      this.resetSubmitted = true
      this.showResetForm = false
    }
  }
}
</script>

<style>
.login {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  width: 100vw;
}
.logo {
  width: 200px;
  margin-bottom: 10px;
}
</style>
