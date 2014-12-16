Vue = require 'vue'
route = require 'vue-route'
Vue.use(route)

app = new Vue
  el: 'body'
  data:
    home: []
  components:
    'news':
      template: '#news'
    'home':
      template: '#home'
    'lesson':
      template: '#lesson'
  routes:
    '/news':
      componentId: 'news'
      isDefault: true
    '/list':
      componentId: 'home'
    '/lesson/:id':
      componentId: 'lesson'
    options:
      hashbang: true
      click: false
  methods:
    navigate: (path) ->
      Vue.navigate("#{path}")
      return
