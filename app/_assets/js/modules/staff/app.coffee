Vue   = require 'vue'
route = require 'vue-route'
Vue.use route

bootstrap = require 'vue-bootstrap'
Vue.use bootstrap

moment = require 'moment'

app = new Vue
  el: '#app'
  template: require './app.html'
  data:
    lessons:   {}
    lesson:    {}
    results:   {}
    articles:  []
    downloads: {}

  filters:
    timestamp: (val) -> moment.unix(val).format "MM月DD日" if val

  methods:
    navigate: (path) ->
      Vue.navigate("#{path}")
      return
    base_url: -> $('meta[name="_base"]').attr('content')

  ready: ->
    $.getJSON "#{@base_url()}api/staff/index", (data) =>
      for key, value of data
        @$set key, value
      return
    return

  events:
    'api:get': (str) ->
      $.getJSON "#{@base_url()}api/staff/#{str}", (json) =>
        @$set str, json
        return
      return

    lesson: (id) ->
      $.getJSON "#{@base_url()}api/staff/lesson/#{id}", (@lesson) =>
        @$broadcast 'count', Object.keys(@lesson.questions)
        return
      return

    result: ->
      unless @results[@lesson.id]
        $.ajax
          type: "POST"
          dataType: "json"
          url: "#{@base_url()}api/staff/lesson/#{@lesson.id}/result"
          headers:
            'X-Csrf-Token': fuel_csrf_token()
        .done (@results) =>
          return
      return

  components:
    news:      require './app/news'
    home:      require './app/home'
    lesson:    require './app/lesson'
    downloads: require './app/downloads'

  routes:
    options:
      hashbang: true
      click:    false

    '/index':
      componentId: 'news'
      isDefault: true
      afterUpdate: (location) ->
        document.title = "スタッフサイト"
        return

    '/lessons':
      componentId: 'home'
      afterUpdate: (location) ->
        document.title = "課題一覧 | スタッフサイト"
        return

    '/lessons/:id':
      componentId: 'lesson'
      afterUpdate: ({params}) ->
        document.title = "課題#{params.id} | スタッフサイト"
        @$emit 'lesson', params.id
