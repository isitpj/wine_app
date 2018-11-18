<template>
  <div id="messages">
    <FloatingActionButton
      v-on:action="showModal"
      materialIconTag="add"
    />

    <div v-for="(message) in messages" :key="message.id">
      <message :message="message"></message>
    </div>
    <modal
      v-show="isModalVisible"
      @close="closeModal"
    >
      <newMessageForm
        slot="body"
        @getMessages="getMessages"
      />
    </modal>
  </div>
</template>

<script>
import axios from 'axios'
import message from './Message.vue'
import modal from './../Modal.vue'
import newMessageForm from './NewMessageForm.vue'
import FloatingActionButton from './../FloatingActionButton.vue'

export default {
  components: {
    message,
    modal,
    newMessageForm,
    FloatingActionButton
  },
  methods: {
    showModal: function() {
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
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
