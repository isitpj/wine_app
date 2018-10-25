<template>
  <div>
    <p>{{message.name}}</p>
    <p>Text: {{message.body}}</p>
    <p>Category: {{message.category}}</p>
  </div>
</template>

<script>
export default {
  name: 'message',
  props: ['message']
}
</script>

<style lang="css">
</style>
