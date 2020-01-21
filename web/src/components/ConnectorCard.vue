<template>
  <div
    class="connector-card"
    :class="computedClasses">
    <template v-if="!loading">
      <img
        :src="imgSrc"
        class="connector-image">
      <slot />
    </template>
    <template v-else>
      Loading...
    </template>
  </div>
</template>

<script>
export default {
  props: {
    imgSrc: {
      type: String,
      required: true,
      default: ''
    },
    loading: {
      type: Boolean,
      default: false
    },
    classes: {
      type: String,
      default: () => ''
    }
  },
  computed: {
    computedClasses () {
      return this.classes + (this.loading ? ' loading' : '')
    }
  }
}
</script>

<style scoped>
  .connector-card {
    background: rgba(255,255,255,0.6);
    padding: 25px;
    padding-top: 60px;
    border-radius: 4px;
    box-shadow: 0 0 8px 0 rgba(0,0,0,0.15);
    width: 40vw;
    position: relative;
    display: flex;
    flex-direction: column;
    align-items: center;
  }
  .connector-card.loading {
    padding-top: 25px;
  }
  .connector-image {
    position: absolute;
    top: -45px;
    border-radius: 50%;
    height: 80px;
    width: 80px;
    left: calc(50% - 40px);
    border: 2px solid rgba(255,255,255,0.8);
    box-shadow: 0 0 8px 0 rgba(0,0,0,0.15);
  }
  @media (max-width: 800px) {
    .connector-card {
      width: 80vw;
    }
  }
</style>