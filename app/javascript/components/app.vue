Vue.component('app', {
  props: ['message1', 'message2']
  data: function () {
    message: this.props.message1,
    anotherMessage: this.props.message2
  },
  template: '<template>
    <div id="app">
      <h1>Pages#welcome</h1>
      <p>Find me in app/views/pages/welcome.html.erb</p>
      <p>This is the message: {{ message }}</p>
      <h2>And here is the subtitle element: {{ anotherMessage }}</h2>
    </div>
  </template>',
  style: '<style scoped>
  p {
    font-size: 2em;
    text-align: center;
  }
  </style>'
})
