<template>
  <div class="app">
    <router-view
      :user="user"
      @login="loggedInUser" />
  </div>
</template>

<script>
import axios from 'axios'

export default {
  name: 'App',
  components: {},
  data () {
    return {
      apiURL: process.env.NODE_ENV === 'production' ? '' : 'http://localhost:3000',
      user: {}
    }
  },
  provide () {
    return {
      apiURL: this.apiURL
    }
  },
  mounted () {
    this.loggedInUser()
  },
  methods: {
    async loggedInUser () {
      try {
        const res = await axios.get(`${this.apiURL}/user`)
        this.user = res.data
        this.$router.push(`/feed/${this.user.url}?name=${this.user.users_name}&email=${this.user.email}`)
      } catch (e) {
        console.log('e', e)
      }
    }
  }
}
</script>

<style lang="scss">
@import "~bulma/sass/utilities/_all";
$primary: #3C5246;
$primary-invert: findColorInvert($primary);
$success: #D6F8D6;
$success-invert: findColorInvert($success);
$info: #729EA1;
$info-invert: findColorInvert($info);

$colors: (
  "white": ($white, $black),
  "black": ($black, $white),
  "light": ($light, $light-invert),
  "dark": ($dark, $dark-invert),
  "primary": ($primary, $primary-invert),
  "info": ($info, $info-invert),
  "success": ($success, $success-invert),
  "warning": ($warning, $warning-invert),
  "danger": ($danger, $danger-invert)
);

@import "~bulma";
@import "~buefy/src/scss/buefy";
@import "~@fortawesome/fontawesome-free/css/all.css";
* {
  box-sizing: border-box;
  --color-primary: #3C5246;
  --color-secondary:hsl(120, 32%, 89%);
  --color-tertiary: #FDD692;
  --color-secondary-darker: hsla(67, 85%, 40%, 1);
}
*::selection {
  background-color: rgba(228, 189, 158, 0.2);
}
html {
  overflow-y: auto;
}
html,
body {
  padding: 0;
  margin: 0;
  font-family: 'Open Sans', sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}
.app {
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  min-height: 100vh;
  background: linear-gradient(to bottom, #f6f6f6 60%, #fff 100%);
}
a {
  color: #D98F59;
}
a:visited {
  color: #D98F59;;
}
@media (max-width: 1000px) {
  .main {
    width: calc(100% - 60px);
    padding: 0;
  }
}
</style>
