<template>
  <div id="messages">
    <div v-for="(message) in messages" :key="message.id">
      <p>{{message.name}}</p>
      <p>Text: {{message.body}}</p>
      <p>Category: {{message.category}}</p>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
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
  }
}
</script>

<style lang="css">
</style>
