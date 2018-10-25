<template>
  <div id="messages">
    <div v-for="(message) in messages" :key="message.id">
      <message :message="message"></message>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import message from './Message.vue'
export default {
  components: {
    message
  },
  data() {
    return {
      messages: [],
      errors: [],
    }
  },
  created() {
    axios.get('http://localhost:3000/api/messages')
      .then(response => {
        this.messages = response.data
      })
      .catch(e => {
        this.errors.push(e)
      }
    )
  },
}
</script>

<style lang="css">
</style>
