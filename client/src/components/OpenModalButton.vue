<template>
  <button
    type="button"
    class="btn"
  >
    {{copy}}
  </button>
</template>

<script>
export default {
  name: 'openModalButton',
  props: {
    copy: String,
  }
}
</script>

<style lang="css">
</style>
