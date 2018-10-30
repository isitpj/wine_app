<template lang="html">
  <form class="" action="https://localhost:3000/api/message" method="post">
    <input type="text" name="message-name" placeholder="Enter a name for the message">
    <select name="category">
      <option value="fallback">Fallback</option>
    </select>
    <textarea name="message-text" rows="4" cols="80" placeholder="Enter the text for the message here..."></textarea>
    <input type="submit" value="Create message">
  </form>
</template>

<script>
export default {
  name: 'newMessageForm'
}
</script>

<style lang="css">
</style>
