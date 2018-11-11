<template lang="html">
  <form class="" action="https://localhost:3000/api/message" method="post">
    <input type="text" name="message-name" placeholder="Enter a name for the message">
    <select name="category">
      <option value="fallback">Fallback</option>
    </select>
    <textarea name="message-text" rows="4" cols="80" placeholder="Enter the text for the message here..."></textarea>
    <!-- <input type="submit" value="Create message"> -->
    <button
      type="submit"
      v-on:click.prevent="createMessage"
    >
      Create
    </button>
  </form>
</template>

<script>
import axios from 'axios'
export default {
  name: 'newMessageForm',
  methods: {
    createMessage: function() {
      axios.post('http://localhost:3000/api/messages', {
        message: {
          name: 'Test message',
          category: 'fallback',
          body: 'Hello, world'
        }
      })
      .then(response => {
        console.log(response);
      })
      .catch(error => {
        console.log(error);
      });
    }
  },
}
</script>

<style lang="css">
</style>
