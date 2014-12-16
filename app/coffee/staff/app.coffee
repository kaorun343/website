Vue = require 'vue'
route = require 'vue-route'
Vue.use route

setIframe = (videoId) ->
  src = "http://www.youtube.com/embed/#{videoId}?rel=0"
  f1 = "<iframe id='player' src='#{src}' frameborder=0 "
  f2 = "width='640' height='390'></iframe>"
  console.log f1+f2
  f1+f2

Vue.directive 'youtube',
  isLiteral: true
  bind: ->
    @el.innerHTML = setIframe(@expression)
    return
  update: (value)->
    console.log value
    @el.innerHTML = setIframe(value)

app = new Vue
  el: 'body'
  data:
    videoId: 'M7lc1UVf-VE'
    home: []
  components:
    'news':
      template: '#news'
    'home':
      template: '#home'
    'lesson':
      template: '#lesson'
      methods:
        update: ->
          @$dipatch 'videoId'
          return
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
  ready: ->
    @$on 'videoId', ->
      @$data.videoId = '3MteSlpxCpo'
