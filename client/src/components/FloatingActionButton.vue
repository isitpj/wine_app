<template lang="html">
  <md-button
    class="md-fab md-primary"
    id="floating-action-button"
    @click="action"
  >
    <md-icon class="material-icons">
      {{materialIconTag}}
    </md-icon>
  </md-button>
</template>

<script>
import Vue from 'vue'
import { MdButton, MdIcon } from 'vue-material/dist/components'
import 'vue-material/dist/vue-material.min.css'

Vue.use(MdButton)
Vue.use(MdIcon)

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
#floating-action-button {
  position: fixed;
  right: 2em;
  bottom: 2em;
  background-color: #ff0083;
}

.material-icons {
  color: #ffffff;
  font-size: 4em;
  font-weight: 100;
}
</style>
