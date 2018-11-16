<template lang="html">
  <form>

    <input
      type="text"
      name="message-name"
      v-model="messageName"
      placeholder="Enter a name for the message"
    >

    <select
      name="category"
      v-model="messageCategory"
    >
      <option
        value="fallback"
      >
        Fallback
      </option>

    </select>

    <textarea
      name="message-text"
      v-model="messageText"
      rows="4"
      cols="80"
      placeholder="Enter the text for the message here...">
    </textarea>

    <button
      type="submit"
      v-on:click.prevent="createMessageAndClose"
    >
      Create
    </button>

  </form>
</template>

<script>
import axios from 'axios'
export default {
  name: 'newMessageForm',
  data() {
    return {
      messageName: '',
      messageCategory: '',
      messageText: '',
      createEndpoint: 'http://localhost:3000/api/messages',
    }
  },
  methods: {
    close: function() {
      this.$emit('close');
    },
    createMessage: function() {
      axios.post(this.createEndpoint, {
        message: {
          name: this.messageName,
          category: this.messageCategory,
          body: this.messageText,
        }
      })
      .then(response => {
        console.log(response);
      })
      .catch(error => {
        console.log(error);
      });
    },
    createMessageAndClose: function() {
      this.createMessage();
      this.$parent.close();
    }
  },
}
</script>

<style lang="css">
</style>
