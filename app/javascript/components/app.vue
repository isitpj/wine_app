<template>
  <div id="app">
    <h1>Pages#welcome</h1>
    <p>Find me in app/views/pages/welcome.html.erb</p>
    <p>This is the message: {{ message }}</p>
    <h2>And here is the subtitle element: {{ anotherMessage }}</h2>
    <h2>And here is the subtitle element: {{ message1 }}</h2>
  </div>
</template>

<script>
  export default {
    name: 'app',
    props: ['message1'],
    data () {
      return {
        message: 'Hello world',
        anotherMessage:'Vincent Wine'
      }
    }
  }
</script>

<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
</style>
