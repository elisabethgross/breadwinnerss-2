<template>
  <div class="reset">
    <form
      v-if="validToken"
      class="form"
      @submit.prevent="">
      <b-field
        label="new password"
        type="is-info"
        label-position="on-border">
        <b-input
          v-model="newPassword"
          type="password"
          placeholder="new password" />
      </b-field>
      <b-button
        v-if="!resetSuccess"
        @click="resetThePassword">
        Reset Password
      </b-button>
      <router-link to="/">
        <b-button v-if="resetSuccess">
          Back to login
        </b-button>
      </router-link>
      <p v-if="resetSuccess">
        Password reset was successful!
      </p>
      <p
        v-if="error">
        {{ error }}
      </p>
    </form>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'ResetPassword',
  inject: ['apiURL'],
  props: {
    'token': {
      type: String,
      required: true
    }
  },
  data () {
    return {
      error: false,
      newPassword: '',
      resetSuccess: false
    }
  },
  methods: {
    async validToken () {
      try {
        await axios.post(`${this.apiURL}/reset/${this.token}`)
        this.validToken = true
      } catch (e) {
        this.error = 'Bad token.'
      }
    },
    async resetThePassword () {
      if (!this.newPassword)
        return
      try {
        await axios.post(`${this.apiURL}/register`, {
          password: this.newPassword,
          token: this.token
        })
        this.resetSuccess = true
      } catch (e) {
        this.error = 'Something was wrong with your reset attempt.'
      }
    }
  }
}


</script>

<style>
.reset {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  width: 100vw;
}
</style>
