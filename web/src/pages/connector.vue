<template>
  <div class="connector-main">
    <div v-if="!showMain">
      <div
        class="intro-wrap"
        :class="{ 'fading': introSubmitting }">
        <connector-card
          :loading="loading"
          :img-src="rawData.connectorImage">
          <template v-if="!loading">
            Hi and welcome to my feed of {{ roles.length }} roles at {{ rawData.companies.length }} companies!
            <form
              class="form user-info-form"
              @keydown.enter="submitInfo">
              <b-field
                label="Name"
                type="is-info"
                label-position="on-border">
                <b-input
                  v-model="userInfo.name"
                  type="text"
                  placeholder="name" />
              </b-field>
              <b-field
                label="Email"
                type="is-info"
                label-position="on-border">
                <b-input
                  v-model="userInfo.email"
                  type="text"
                  placeholder="email" />
              </b-field>
              <b-button
                :loading="introSubmitting"
                type="is-primary"
                @click="submitInfo">
                Access Feed
              </b-button>
            </form>
          </template>
        </connector-card>
      </div>
    </div>
    <div v-if="showMain && error">
      Error retrieving connector information: {{ error }}
    </div>
    <div
      v-if="showMain && !submitted && !error"
      class="section">
      <div class="container">
        <div
          v-if="isAdmin"
          class="logout-container">
          <b-button
            class="logout"
            @click="logout">
            Logout
          </b-button>
        </div>
        <div class="columns is-multiline">
          <div
            class="column transition-column is-full-tablet"
            :class="{ 'is-four-fifths-desktop': checkedRows.length, 'is-full': !checkedRows.length}">
            <div class="connector-head">
              <div class="connector-img-wrap">
                <img
                  class="connector-img"
                  :src="rawData.connectorImage">
              </div>
              <div class="connector-msg-wrap">
                <div
                  v-if="!loading"
                  class="connector-msg">
                  Hey {{ query.name }}, <br>
                  Below are the {{ rawData.companies.length }} companies in my network that are hiring. Select the roles that you're interested in to request intros.
                  <div class="connector-info">
                    <div class="connector-name">
                      - {{ connectorName }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div
            class="column transition-column is-full-tablet"
            :class="{ 'is-four-fifths-desktop': checkedRows.length, 'is-full': !checkedRows.length}">
            <SingleJobPosting
              v-if="isAdmin && connectorName"
              :connector="connector"
              :name="connectorName" />
            <div class="table-filters">
              <b-field
                v-for="(filter, idx) in filters"
                :key="idx"
                :label="filter.name"
                type="is-info"
                label-position="on-border">
                <b-input
                  v-model="filter.value"
                  type="text"
                  :placeholder="filter.placeholder" />
              </b-field>
            </div>
            <b-table
              class="fancy-scrollbar"
              :data="filteredData"
              :mobile-cards="false"
              :loading="loading">
              <template slot-scope="props">
                <b-table-column
                  field="checked"
                  label=""
                  :sortable="false">
                  <b-checkbox-button
                    v-model="checkedRows"
                    :native-value="props.row">
                    <b-icon
                      pack="fas"
                      :icon="isSelected(props.row) ? 'minus-circle' : 'plus-circle'"
                      type="is-primary" />
                  </b-checkbox-button>
                </b-table-column>
                <b-table-column
                  field="jobTitle"
                  label="Role"
                  :sortable="true">
                  <a
                    :href="props.row.url"
                    target="_blank">
                    {{ props.row.jobTitle }}
                  </a>
                </b-table-column>
                <b-table-column
                  field="location"
                  label="Location"
                  :sortable="true">
                  {{ props.row.location }}
                </b-table-column>
                <b-table-column
                  field="companyName"
                  label="Company"
                  :sortable="true">
                  <a
                    :href="props.row.companyURL"
                    target="_blank">
                    {{ props.row.companyName }}
                  </a>
                </b-table-column>
                <b-table-column
                  v-if="isAdmin"
                  class="admin-actions"
                  field="single_job_postings_id"
                  label="Admin Actions"
                  :sortable="false">
                  <b-icon
                    v-if="props.row.type === 'single'"
                    pack="fas"
                    type="is-danger"
                    icon="times-circle"
                    @click.native="deleteSingleJobPosting(props.row.companyName, props.row.single_job_postings_id)" />
                </b-table-column>
              </template>
              <template slot="empty">
                <section class="section">
                  <div class="content has-text-grey has-text-centered">
                    <p>
                      <b-icon
                        icon="emoticon-sad"
                        size="is-large" />
                    </p>
                    <p>Nothing here.</p>
                  </div>
                </section>
              </template>
            </b-table>
            <div class="total-rows-count">
              Total matching roles: {{ filteredData.length }}
            </div>
          </div>
        </div>
      </div>
    </div>
    <div
      class="connector-checkout is-hidden-touch"
      :class="{ visible: checkedRows.length > 0 }">
      <h1>{{ checkedRows.length }}</h1>
      <h3>job{{ checkedRows.length > 1 ? 's' : '' }} selected</h3>
      <ul class="fancy-scrollbar">
        <li
          v-for="row in checkedRows"
          :key="row.id">
          <div
            class="checkedJobRemove"
            @click="uncheckRow(row.id)">
            &times;
          </div>
          <div class="checkedJobTitle">
            {{ row.jobTitle }}
          </div>
          <div class="checkedCompanyName">
            {{ row.companyName }}
          </div>
        </li>
      </ul>
      <b-field
        label="Give me a quick blurb about yourself to send with your intro."
        type="is-info">
        <b-input
          v-model="userBlurb"
          type="textarea"
          rows="5"
          :placeholder="exampleUserBlurb" />
      </b-field>
      <b-button
        :loading="submitting"
        type="is-large"
        class="is-primary"
        @click="submitRequests">
        Request Intros
      </b-button>
    </div>
    <div
      class="connector-checkout-mobile is-hidden-desktop"
      :class="{ 'visible': checkedRows.length > 0, 'expanded': showCheckout }">
      <div
        class="connector-checkout-mobile-header"
        @click="showCheckout = !showCheckout">
        <h1>{{ checkedRows.length }} job{{ checkedRows.length > 1 ? 's' : '' }} selected</h1>
        <b-icon
          pack="fas"
          size="is-large"
          :icon="showCheckout ? 'angle-down' : 'angle-right'" />
      </div>
      <ul class="fancy-scrollbar">
        <li
          v-for="row in checkedRows"
          :key="row.id">
          <div class="checkedJobTitle">
            {{ row.jobTitle }}
          </div>
          <div class="checkedCompanyName">
            {{ row.companyName }}
          </div>
        </li>
      </ul>
      <b-button
        :loading="submitting"
        type="is-large"
        class="is-primary"
        @click="submitRequests">
        Request Intros
      </b-button>
    </div>
    <canvas
      id="confetti"
      :class="{ 'visible': submitted }" />
    <div
      class="connector-complete-wrap"
      :class="{ 'visible': submitted }">
      <connector-card
        :img-src="rawData.connectorImage"
        classes="connector-complete-inner">
        <h2>Thanks!</h2>
        <div class="connector-complete-msg">
          I've received your requests and will make the respective intros shortly.
        </div>
        <div class="own-feed-cta">
          Want your own Breadwinnerss feed? Contact us via <a href="#">this form</a>.
        </div>
      </connector-card>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import ConfettiGenerator from 'confetti-js'
// import ConnectorHeader from '../components/ConnectorHeader'
// import Company from '../components/Company'
import ConnectorCard from '../components/ConnectorCard'
import SingleJobPosting from '../components/SingleJobPosting'

export default {
  name: 'Connector',
  inject: ['apiURL'],
  components: {
    ConnectorCard,
    SingleJobPosting
  },
  props: {
    'connector': {
      type: String,
      required: true
    },
    'query': {
      type: Object,
      required: false,
      default: () => {}
    },
    'user': {
      type: Object,
      required: false,
      default: () => {}
    }
  },
  data () {
    return {
      loading: true,
      introSubmitting: false,
      error: false,
      rawData: false,
      userInfo: {
        email: '',
        name: ''
      },
      filters: [
        {
          name: 'filter by role',
          field: 'jobTitle',
          value: '',
          placeholder: 'Rocketship Technician'
        },
        {
          name: 'filter by location',
          field: 'location',
          value: '',
          placeholder: 'New York'
        },
        {
          name: 'filter by company',
          field: 'companyName',
          value: '',
          placeholder: 'Alpha'
        }
      ],
      showCheckout: false, // meant for the mobile checkout process only
      submitting: false,
      submitted: false,
      checkedRows: [],
      columns: [
        {
          field: 'companyName',
          label: 'Company',
          sortable: true
        },
        {
          field: 'jobTitle',
          label: 'Role',
          sortable: true
        },
        {
          field: 'location',
          label: 'Location',
          sortable: true
        }
      ],
      userBlurb: ''
    }
  },
  computed: {
    connectorName () {
      return this.rawData.connector
    },
    connectorEmail () {
      return this.rawData.email
    },
    showMain () {
      return this.query.email && this.query.name
    },
    isAdmin () {
      return this.user && this.user.user_id
    },
    roles () {
      if (!this.rawData || !this.rawData.companies) return []
      return this.rawData.companies.reduce((accum, company) => {
        const { companyName, jobs, companyURL } = company
        const rows = jobs.map((job, index) => {
          const { jobTitle, location, url, type, single_job_postings_id } = job
          const id = `${companyName}_${index}`
          return {
            id,
            companyName,
            companyURL,
            jobTitle,
            location,
            type,
            url,
            single_job_postings_id
          }
        })
        return accum.concat(rows)
      }, [])
    },
    filteredData () {
      return this.roles.filter(role => {
        return this.filters.every(filter => {
          const filterValue = filter.value.toLowerCase().trim()
          if (filterValue === '') return true
          if (role[filter.field] === undefined) return false
          return role[filter.field].toLowerCase().includes(filterValue)
        })
      })
    },
    exampleUserBlurb () {
      return `${this.query.name} is a mid-level software engineer with 4+ years of experience. They are looking for complex challenges to collaborate on with a talented and driven team.`
    }
  },
  watch: {
    $route: {
      handler () { this.hitApi() },
      immediate: true // Shorthand, ensures it will be called on created() as well.
    }
  },
  methods: {
    submitInfo () {
      const { name, email } = this.userInfo
      if (!name.trim() || !email.trim()) return
      // artificial
      this.introSubmitting = true
      setTimeout(() => {
        this.$router.push(`/feed/${this.connector}?email=${email}&name=${name}`)
      }, 1000)
    },
    hitApi () {
      const url = this.query.email && this.query.name ?
        `${this.apiURL}/connector/${this.connector}?email=${this.query.email}&name=${this.query.name}` :
        `${this.apiURL}/connector/${this.connector}`
      axios.get(url)
        .then(res => {
          this.loading = false
          this.rawData = res.data
        })
        .catch(e => {
          console.log('error getting connector data', e)
          this.error = e.response.data
          this.loading = false
        })
    },
    uncheckRow (id) {
      this.checkedRows.splice(this.checkedRows.find(row => {
        return row.id === id
      }), 1)
    },
    isSelected (row) {
      return this.checkedRows.some(checked => {
        return checked.id === row.id
      })
    },
    async submitRequests () {
      const confetti = new ConfettiGenerator({
        target: 'confetti',
        max: 150,
        rotate: true
      })
      confetti.render()
      this.submitting = true
      await axios.post(`${this.apiURL}/make-intros`, {
        connectorEmail: this.rawData.email,
        connectorName: this.rawData.firstName,
        userName: this.query.name,
        userEmail: this.query.email,
        userBlurb: this.userBlurb,
        requestedIntros: this.checkedRows
      })
      this.submitting = false
      this.submitted = true
    },
    completeCTA () {
      window.location.href = '/'
    },
    deleteSingleJobPosting (companyName, single_job_postings_id) {
      axios.delete(`${this.apiURL}/connector-modules/${this.connector}`, {
        data: { single_job_postings_id }
      })
      const company = this.rawData.companies.find(company => company.companyName === companyName)
      const jobIndex = company.jobs.findIndex(job => job.single_job_postings_id === single_job_postings_id)
      company.jobs.splice(jobIndex, 1)
    },
    async logout () {
      await axios.get(`${this.apiURL}/logout`)
      window.location.href = '/'
    }
  }
}
</script>

<style scoped>
  .intro-wrap {
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    width: 100vw;
    opacity: 1;
    background-color: var(--color-secondary);
    transition: background-color 1s ease-in-out, opacity 1s ease-in-out;
    transition-delay: 0.2s;
  }
  .intro-wrap.fading {
    background-color: #fff;
    opacity: 0;
  }
  .user-info-form {
    margin-top: 25px;
    width: 100%;
  }
  .user-info-form .field {
    margin-bottom: 25px;
  }
  .connector-head {
    margin-bottom: 30px;
    display: flex;
    flex-direction: row;
    align-items: center;
  }
  .logout-container {
    display: flex;
    flex-direction: row-reverse;
    margin-bottom: 5px;
  }
  .logout {
    background-color: #D98F59;
    color: white;
  }
  .connector-img-wrap {
    margin-right: 30px;
    width: 100px;
    height: 100px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    position: relative;
  }
  .connector-img {
    max-width: 100%;
    object-fit: cover;
    border-radius: 50%;
    border: 4px solid var(--color-tertiary);
    box-shadow: 0 0 16px 1px var(--color-tertiary);
  }
  .connector-info {
    margin-top: 15px;
    text-align: right;
  }
  .connector-msg-wrap {
    background: #fff;
    border-radius: 4px;
    padding: 25px;
    border: 1px solid #fafafa;
    box-shadow: 2px 2px 28px 1px rgba(0,0,0,0.15);
    position: relative;
  }
  .connector-msg-wrap:after {
    content: '';
    position: absolute;
    left: 0;
    top: 50%;
    width: 0;
    height: 0;
    border: 15px solid transparent;
    border-right-color: #fff;
    border-left: 0;
    margin-top: -15px;
    margin-left: -15px;
  }
  .transition-column {
    transition: width 0.3s ease-in;
    will-change: width;
  }
  .table-filters {
    display: flex;
    flex-direction: row;
    align-items: center;
    margin-bottom: 20px;
  }
  .table-filters .field {
    margin-right: 20px;
    margin-bottom: .75rem;
    flex-grow: 1;
  }
  .table-filters .field:last-child {
    margin-right: 0;
  }
  .table-filters .field >>> .label {
    letter-spacing: 0.5px;
    padding: 0 5px;
  }
  .b-table {
    box-shadow: 2px 2px 28px 1px rgba(0,0,0,0.15);
    max-height: calc(100vh - 455px);
    overflow-y: auto;
    position: relative;
  }
  .b-table >>> table {
    border: 0;
  }
  .b-table >>> thead,
  .b-table >>> th {
    top: 0;
    background-color: var(--color-primary);
    position: sticky;
    z-index: 1;
  }
  .b-table >>> thead tr {
    background-color: var(--color-primary);
    border-radius: 4px;
  }
  .b-table >>> thead tr th {
    color: #fff;
  }
  .b-table >>> tbody {
    background-color: hsla(147, 8%, 88%, 0.4);
  }
  .b-table >>> tbody tr td {
    line-height: 24px;
  }
  .b-table >>> .b-checkbox.button {
    background: none;
    border: 0;
    outline: 0;
    height: 100%;
    padding: 0;
    padding-left: 5px;
    box-shadow: none;
  }
  .b-table >>> .b-checkbox.button:focus {
    outline: 0;
  }
  .b-table >>> .admin-actions .icon {
    cursor: pointer;
  }
  .total-rows-count {
    margin-top: 20px;
    font-weight: bold;
  }
  .connector-checkout {
    z-index: 1;
    position: fixed;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    top: 0;
    bottom: 0;
    right: 0;
    width: 19vw;
    background: var(--color-secondary);
    padding: 20px;
    color: rgba(0,0,0,0.8);
    transform: translateX(100%);
    transition: transform 0.3s ease-in;
    will-change: transform;
    box-shadow: -2px 0 28px 1px rgba(0,0,0,0.15);
  }
  .connector-checkout.visible {
    transform: translateX(0%);
  }
  .connector-checkout h1 {
    text-align: center;
    font-size: 65px;
    font-weight: bold;
    margin-top: 50px;
    margin-bottom: 10px;
    flex-grow: 0;
  }
  .connector-checkout h3 {
    font-size: 28px;
    text-align: center;
    font-weight: bold;
    text-transform: uppercase;
    margin-bottom: 10px;
    flex-grow: 0;
  }
  .connector-checkout ul {
    flex-grow: 1;
    margin-top: 25px;
    overflow-y: auto;
    padding-right: 10px;
    margin-right: -20px;
    margin-bottom: 20px;
  }
  .fancy-scrollbar::-webkit-scrollbar {
    width: 3px;
  }
  .fancy-scrollbar::-webkit-scrollbar-track{
    background: rgba(255,255,255,0.2);
  }
  .fancy-scrollbar::-webkit-scrollbar-thumb {
    background: rgba(0,0,0,0.2);
  }
  .connector-checkout ul {
    padding-left: 25px;
    margin-left: -20px;
  }
  .connector-checkout ul li {
    border-bottom: 1px solid rgba(0,0,0,0.1);
    padding: 16px 0;
    position: relative;
  }
  .connector-checkout ul li:last-child {
    border-bottom: 0;
  }
  .checkedJobRemove {
    position: absolute;
    left: -15px;
    top: 10px;
    cursor: pointer;
    z-index: 5;
  }
  .checkedJobRemove:hover {
    color: #d44d2e
  }
  .checkedJobTitle {
    font-weight: bold;
    line-height: 1.05;
    margin-bottom: 2px;
  }
  .checkedCompanyName {
    color: rgba(0,0,0,0.5);
    font-size: 14px;
  }
  .connector-checkout-mobile {
    z-index: 5;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    position: fixed;
    bottom: 0;
    width: 100%;
    height: 100vh;
    padding: 30px;
    padding-top: 0;
    background: var(--color-secondary);
    transform: translateY(100%);
    color: rgba(0,0,0,0.8);
    transition: all 0.3s ease-in;
    box-shadow: -6px 0 12px 0px rgba(0,0,0,0.15);
  }
  .connector-checkout-mobile.visible {
    transform: translateY(calc(100% - 110px));
  }
  .connector-checkout-mobile.expanded {
    transform: translateY(0);
  }
  .connector-checkout-mobile-header {
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    width: 100%;
    user-select: none;
    padding-top: 30px;
  }
  .connector-checkout-mobile-header .icon {
    cursor: pointer;
  }
  .connector-checkout-mobile .connector-checkout-mobile-header {
    border-bottom: 1px solid rgba(0,0,0,0.15);
    padding-bottom: 10px;
  }
  .connector-checkout-mobile ul {
    flex-grow: 1;
    margin-top: 10px;
    align-self: flex-start;
    max-height: calc(100% - 200px);
    overflow-y: auto;
    width: 100%;
  }
  .connector-checkout-mobile ul li {
    margin-bottom: 15px;
  }
  .connector-checkout-mobile ul .checkedJobTitle {
    font-size: 22px;
  }
  .connector-checkout-mobile ul .checkedCompanyName {
    font-size: 18px;
  }
  .connector-checkout-mobile-header h1 {
    margin-right: 20px;
    text-transform: uppercase;
  }
  #confetti,
  .connector-complete-wrap {
    position: fixed;
    top: 0;
    right: 0;
    width: 100%;
    height: 100vh;
    transform: translateX(100%);
    transition: 0.3s ease-in;
    will-change: transform;
  }
  #confetti {
    z-index: 6;
    background: var(--color-secondary);
  }
  .connector-complete-wrap {
    z-index: 7;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  #confetti.visible,
  .connector-complete-wrap.visible {
    transform: translateX(0);
  }
  .connector-complete-inner h2 {
    text-align: center;
    font-weight: bold;
  }
  .connector-complete-msg {
    text-align: center;
    margin-bottom: 25px;
    margin-top: 10px;
  }
  .own-feed-cta {
    position: absolute;
    bottom: -50px;
    font-weight: bold;
    left: 0;
    right: 0;
    text-align: center;
  }
</style>
