Vue = require 'vue'
route = require 'vue-route'
Vue.use route

setIframe = (videoId) ->
  src = "http://www.youtube.com/embed/#{videoId}?rel=0"
  f1 = "<iframe id='player' src='#{src}' frameborder=0 "
  f2 = "width='640' height='390' allowfullscreen></iframe>"
  f1+f2

Vue.directive 'youtube',
  isLiteral: true
  bind: ->
    @el.innerHTML = setIframe(@expression)
    return
  update: (value)->
    @el.innerHTML = setIframe(value)
    return

app = new Vue
  el: 'body'
  data:
    videoId: 'M7lc1UVf-VE'
    current:
      lesson:
        videoId: 'M7lc1UVf-VE'
        questions: {}
    news: {}
    schedules: {}
    lessons: {}
    results: {}
    questions: {}
  components:
    'news':
      template: '#news'
    'home':
      template: '#home'
    'video':
      template: '#lesson'
      methods:
        update: ->
          @$dipatch 'videoId'
          return
    'answer':
      template: '#answer'
      methods:
        save: (e) ->
          e.preventDefault()
          return
    'radio':
      template: '#answerRadio'
    'checkbox':
      template: '#answerCheckbox'
  routes:
    '/news':
      componentId: 'news'
      isDefault: true
    '/list':
      componentId: 'home'
    '/lesson/:id/video':
      componentId: 'video'
    '/lesson/:id/answer':
      componentId: 'answer'
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
