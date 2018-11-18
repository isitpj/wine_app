<template lang="html">
  <button
    type="button"
    class="floating-action-button"
    @click="action"
  >
    <span class="material-icons">{{materialIconTag}}</span>
  </button>
</template>

<script>
export default {
  name: 'FloatingActionButton',
  props: ['materialIconTag'],
  methods: {
    action() {
      this.$emit('action');
    }
  },
}
</script>

<style lang="css">
.floating-action-button {
  height: 6em;
  width: 6em;
  border-radius: 5em;
  position: fixed;
  right: 2em;
  bottom: 2em;
  border-style: none;
  background-color: #ff0083;
  box-shadow: 3px 3px grey;
}

.material-icons {
  color: #ffffff;
  font-size: 4em;
  font-weight: 100;
}
</style>
