<template>
  <div id="messages">
    <button
      type="button"
      class="btn"
      @click="showModal"
    >
      Open modal!
    </button>
    <div v-for="(message) in messages" :key="message.id">
      <message :message="message"></message>
    </div>
    <modal
      v-show="isModalVisible"
      @close="closeModal"
    />
  </div>
</template>

<script>
import axios from 'axios'
import message from './Message.vue'
import modal from './../Modal.vue'

export default {
  components: {
    message,
    modal
  },
  methods: {
    showModal() {
      this.isModalVisible = true;
    },
    closeModal() {
      this.isModalVisible = false;
    }
  },
  data() {
    return {
      messages: [],
      errors: [],
      isModalVisible: false,
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
