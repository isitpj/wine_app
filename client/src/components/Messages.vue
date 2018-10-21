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
export default {
  data() {
    return {
      messages: [
        {
          "id": 1,
          "name": "Fallback Message",
          "category": "fallback",
          "body": "I'm sorry, I don't understand that yet",
          "quick_replies": null,
          "buttons": null,
          "created_at": "2018-10-03T20:28:31.136Z",
          "updated_at": "2018-10-03T20:28:31.136Z"
        }
      ]
    }
  }
}
</script>

<style lang="css">
</style>


<!-- <template>
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
      name: [],
      relationship: [],
      errors: []
    }
   },
   created() {
    axios.get('http://localhost:3000/api/messages',
    {
      headers: {
        "Access-Control-Allow-Origin": "*",
        responseType: 'json',
      }
      },
    )
    .then(response => {
      this.messages = response.data
    })
    .catch(e => {
      this.error.push(e)
    })
  }
}
</script>

<style lang="css">
</style>
 -->
