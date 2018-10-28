<template lang="html">
  <button
    type="button"
    class="btn"
    @click="action"
  >
  {{ copy }}
  </button>
</template>

<script>
export default {
  name: 'buttonComponent',
  props: ['copy'],
  methods: {
    action() {
      this.$emit('action');
    }
  },
}
</script>

<style lang="css">
</style>
