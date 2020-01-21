<template>
  <div class="main-wrapper">
    <div class="what-is">
      <Header />
      <div class="flex-row">
        <div class="call-to-action-container">
          <h1 class="call-to-action">
            Be a more effective networker with Breadwinnerss
          </h1>
          <h4>Easily make introductions between job seekers and employers by creating a real-time feed of jobs in your network.</h4>
          <div class="email">
            <input
              v-model="email"
              type="text"
              placeholder="Your email...">
            <div
              class="email-button btn"
              @click="submitEmail">
              GET STARTED
            </div>
          </div>
          <div class="feature-container">
            <div class="flip-card">
              <div class="flip-card-inner">
                <div class="flip-card-front">
                  <img :src="feature1">
                  <p>Turn your network <br> into a job board</p>
                </div>
                <div class="flip-card-back">
                  <p>Add companies from your network that <br> you can introduce <br> candidates to.</p>
                </div>
              </div>
            </div>
            <div class="flip-card">
              <div class="flip-card-inner">
                <div class="flip-card-front">
                  <img :src="feature2">
                  <p>Your job board <br> updates in real-time</p>
                </div>
                <div class="flip-card-back">
                  <p>You never have to worry about checking which job listings are still active.</p>
                </div>
              </div>
            </div>
            <div class="flip-card">
              <div class="flip-card-inner">
                <div class="flip-card-front">
                  <img :src="feature3">
                  <p>Make seamless introductions</p>
                </div>
                <div class="flip-card-back">
                  <p>Enable great candidates from your network to connect directly with hiring managers.</p>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="welcome-image-container">
          <img
            class="welcome-image"
            :src="welcome">
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import Header from '../components/Header'
import welcome from '../assets/welcome.svg'
import feature1 from '../assets/feature_1.png'
import feature2 from '../assets/feature_2.png'
import feature3 from '../assets/feature_3.png'

export default {
  name: 'Home',
  inject: ['apiURL'],
  components: {
    Header
  },
  data () {
    return {
      loading: true,
      welcome,
      feature1,
      feature2,
      feature3,
      email: ''
    }
  },
  methods: {
    submitEmail () {
      const email = this.email.trim()
      if (!email) return
      window.open(`https://coderbyte.typeform.com/to/mNXWUr?email=${email}`)
    }
  }
}
</script>

<style>
h1 {
  font-size: 42px;
  line-height: 54px;
}
h2 {
  font-size: 24px;
  line-height: 30px;
}
.color-secondary {
  color: var(--color-secondary);
  font-weight: bold;
}
.btn {
  padding: 8px 18px;
  background-color: #bccf27;
  color: #fff;
  text-decoration: none;
  border-radius: 4px;
  cursor: pointer;
  font-size: 18px;
  font-weight: bold;
  display: flex;
  justify-content: center;
  align-items: center;
}
.btn:hover {
  background-color: var(--color-secondary-darker);
}
a.btn:visited {
  color: #fff;
}
.main-wrapper {
  display: flex;
  flex-direction: column;
  align-items: stretch;
  align-content: space-between;
  flex-wrap: wrap;
  width: 100%;
  max-width: 1220px;
  padding: 0 40px;
  margin: 0 auto;
  padding-top: 40px;
  flex-grow: 1;
}
.flex-row {
  display: flex;
  flex-direction: row;
}
.what-is {
  margin-bottom: 40px;
}
.what-is .flex-row {
  justify-content: space-between;
  align-items: stretch;
}

.call-to-action-container {
  color: #DB5742;
  margin-top: 30px;
  max-width: 750px;
}

.call-to-action-container h4 {
  font-weight: bold;
  margin-top: 20px;
  margin-bottom: 20px;
}

.call-to-action {
  font-weight: bold;
  margin-bottom: 20px;
  margin-top: 20px;
}

.email {
  width: 100%;
  display: flex;
  flex-direction: row;
  margin-bottom: 50px;
}

.email input {
  font-size: 18px;
  line-height: 28px;
  border: 1px solid #DB5742;
  margin-right: 20px;
  border-radius: 4px;
  padding: 10px;
  flex-grow: 1;
}

.email input:focus {
  outline: 0;
  border-color: #bccf27;
}

.feature-container {
  display: flex;
  font-size: 12px;
  flex-wrap: wrap;
  align-items: stretch;
  justify-content: space-between;
}

.flip-card {
  flex: 1;
  margin-right: 20px;
  perspective: 1000px;
  margin-bottom: 20px;
  min-width: 175px;
}
.flip-card:last-child {
  margin-right: 0;
}
.flip-card-inner {
  background: #DB5742;
  color: white;
  height: 170px;
  display: flex;
  flex-direction: column;
  align-items: center;
  font-size: 14px;
  text-align: center;
  flex-grow: 1;
  position: relative;
  transition: transform 0.8s ease;
  transform-style: preserve-3d;
}
.flip-card:hover .flip-card-inner {
  transform: rotateY(180deg);
}
.flip-card-front, .flip-card-back {
  position: absolute;
  width: 170px;
  height: 170px;
  backface-visibility: hidden;
  line-height: 1.5em;
}
.flip-card-front {
  transform: translateZ(1px);
  font-size: 16px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
.flip-card-front img {
  margin-bottom: 15px;
  width: 20%;
}
.flip-card-front p {
  margin-top: 2px;
}
.flip-card-back {
  transform: rotateY(180deg) translateZ(1px);
}
.flip-card-back > p {
  padding-top: 20px;
}
.welcome-image {
  display: block;
  margin: 0 auto;
  object-fit: cover;
  max-width: 100%;
}
.welcome-image-container {
  flex-grow: 0;
  margin-left: 80px;
  margin-top: 58px;
}


@media (max-width: 1180px) {
  .welcome-image-container {
    display: none;
  }
  .what-is {
    width: 100%;
  }
  .call-to-action-container {
    max-width: 800px;
  }
}

@media (max-width: 747px) {
  .feature-container {
    flex-direction: column;
    align-items: center;
  }
  .flip-card {
    margin-right: 0;
    min-width: 212px;
    max-width: 300px;
    flex-grow: 1;
  }
}

@media (max-width: 500px) {
  .email {
    flex-direction: column;
  }

  .email input {
    width: 100%;
    margin-bottom: 15px;
  }

  .email .btn {
    padding-top: 12px;
    padding-bottom: 12px;
  }
}

</style>
