<template>
  <div id="messages">
    <buttonComponent v-on:action="showModal" copy="Button Component"/>

    <div v-for="(message) in messages" :key="message.id">
      <message :message="message"></message>
    </div>
    <modal
      v-show="isModalVisible"
      @close="closeModal"
    >
      <newMessageForm slot="body"/>
    </modal>
  </div>
</template>

<script>
import axios from 'axios'
import message from './Message.vue'
import modal from './../Modal.vue'
import newMessageForm from './NewMessageForm.vue'
import buttonComponent from './../Button.vue'

export default {
  components: {
    message,
    modal,
    newMessageForm,
    buttonComponent
  },
  methods: {
    showModal: function() {
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
      // TODO: this is asynchronous and so the message does not exist at the point that this call is made. Work out how to properly add the message once the modal is closed
      this.getMessages();
    },
    getMessages: function() {
      axios.get(this.indexEndpoint)
        .then(response => {
          this.messages = response.data
        })
        .catch(e => {
          this.errors.push(e)
        })
    }
  },
  data() {
    return {
      messages: [],
      errors: [],
      isModalVisible: false,
      indexEndpoint: 'http://localhost:3000/api/messages',
    }
  },
  created() {
    this.getMessages();
  },
}
</script>

<style lang="css">
</style>
