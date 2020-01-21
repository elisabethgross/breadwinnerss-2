<template>
  <div class="container main">
    <p class="form-title">
      Welcome back, {{ name }}! Add a single job posting to your feed.
    </p>
    <form
      class="form"
      @keydown.enter="submitForm">
      <b-field
        label="Company Name"
        type="is-info"
        label-position="on-border">
        <b-input
          v-model="companyName"
          type="text"
          palceholder="ACME Corp" />
      </b-field>
      <b-field
        label="Role Title"
        type="is-info"
        label-position="on-border">
        <b-input
          v-model="jobTitle"
          type="text"
          palceholder="Wine Tester" />
      </b-field>
      <b-field
        label="Listing URL"
        type="is-info"
        label-position="on-border">
        <b-input
          v-model="url"
          type="text"
          palceholder="some.domain" />
      </b-field>
      <b-field
        label="Location"
        type="is-info"
        label-position="on-border">
        <b-input
          v-model="location"
          type="text"
          palceholder="Starship Enterprise" />
      </b-field>
      <b-button
        type="is-link"
        @click="submitForm">
        Submit
      </b-button>
    </form>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'SingleJobPosting',
  inject: ['apiURL'],
  props: {
    connector: {
      type: String,
      required: true
    },
    name: {
      type: String,
      required: true
    }
  },
  data () {
    return {
      companyName: '',
      jobTitle: '',
      location: '',
      url: ''
    }
  },
  methods: {
    async submitForm () {
      // required fields
      if (!(this.jobTitle && this.url && this.companyName)) {
        return
      }
      await axios.post(`${this.apiURL}/connector-modules/${this.connector}`, {
        companyName: this.companyName,
        jobTitle: this.jobTitle,
        url: this.url,
        location: this.location
      })
      this.jobTitle = ''
      this.url = ''
      this.location = ''
      this.companyName = ''
      window.location.reload()
    }
  }
}
</script>

<style scoped>
  .main {
    background: var(--color-tertiary);
    color: rgba(0,0,0,0.8);
    margin-bottom: 30px;
    margin-top: -15px;
    border-radius: 2px;
    padding: 15px;
    box-shadow: 0 0 8px 0 rgba(0,0,0,0.15);
  }
  .form-title {
    font-size: 18px;
  }
  .form {
    display: flex;
    align-items: center;
    margin-top: 15px;
  }
  .form .field {
    margin-right: 15px;
    margin-bottom: 0;
  }
  .form .field >>> .label {
    letter-spacing: 0.5px;
    padding: 0 5px;
  }

  @media (max-width: 1000px) {
    .form {
      /* flex-direction: column; */
      flex-wrap: wrap;
    }
    .form .field {
      margin-bottom: 10px;
    }
    .form .button {
      margin-bottom: 10px;
    }
  }

</style>
