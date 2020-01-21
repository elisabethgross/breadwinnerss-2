<template>
  <header>
    <div
      :class="{ inner: true, 'inner-company': hasDefaultSlot }">
      <img
        :src="logo"
        :class="{ smaller: hasDefaultSlot }">
      <div
        v-if="hasDefaultSlot"
        class="page-description">
        <slot />
      </div>
    </div>
  </header>
</template>

<script>
import logo from '../assets/breadwinnerss-logo-fun.png'
export default {
  name: 'Header',
  data () {
    return {
      logo
    }
  },
  computed: {
    hasDefaultSlot () {
      return !!this.$slots.default
    }
  }
}
</script>

<style scoped>
  header {
    padding: 10px 0;
    padding-bottom: 0px;
  }
  .inner {
    display: flex;
    flex-direction: row;
    justify-content: flex-start;
    align-items: center;
    font-size: 20px;
  }
  .inner-company {
    justify-content: flex-start;
  }
  header img {
    width: 175px;
  }
  .smaller {
    width: 175px;
  }
  .page-description {
    width: 60%;
    margin-left: 60px;
    line-height: 1.6;
  }
  .page-description p {
    margin: 0;
  }

  @media (max-width: 745px) {
    .bread {
      font-size: 15px;
    }
  }
</style>
