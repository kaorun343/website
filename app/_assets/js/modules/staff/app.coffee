Vue = require 'vue'
route = require 'vue-route'
Vue.use route

app = new Vue
  el: '#app'
  template: require './app.html'
  data:
    news: {}
    schedules: {}
    lessons: {}
    lesson: {}
    results: {}

  methods:
    navigate: (path) ->
      Vue.navigate("#{path}")
      return
    base_url: -> $('meta[name="_base"]').attr('content')
    get_lessons: ->
      $.getJSON "#{@base_url()}api/staff/lessons", (json) =>
        @lessons = json
        return
    get_results: ->
      $.getJSON "#{@base_url()}api/staff/results", (json) =>
        @results = json
        return

  ready: ->
    @get_lessons()
    @get_results()
    return

  events:
    lesson: (id) ->
      $.getJSON "#{@base_url()}api/staff/lesson/#{id}", (json) =>
        @lesson = json
        @$broadcast 'count', Object.keys(@lesson.questions)
        return
      return

    result: ->
      if @results[@lesson.id]
        return
      else
        $.ajax
          type: "POST"
          dataType: "json"
          url: "#{@base_url()}api/staff/lesson/#{@lesson.id}/result"
          headers:
            'X-Csrf-Token': fuel_csrf_token()
        .done (json) =>
          @results = json
        return

  components:
    news: require './app/news'
    home: require './app/home'
    lesson: require './app/lesson'
    downloads: require './app/downloads'

  routes:
    options:
      hashbang: true
      click: false

    '/index':
      componentId: 'news'
      afterUpdate: (location, oldLocation) ->
        document.title = "スタッフサイト"
        return

    '/list':
      componentId: 'home'
      isDefault: true
      afterUpdate: (location, oldLocation) ->
        document.title = "課題一覧 | スタッフサイト"
        return

    '/lesson/:id':
      componentId: 'lesson'
      afterUpdate: (location, oldLocation) ->
        document.title = "課題#{location.params.id} | スタッフサイト"
        @$emit 'lesson', location.params.id
        return

    '/downloads':
      componentId: 'downloads'
      afterUpdate: (location, oldLocation) ->
        document.title = "資料一覧 | スタッフサイト"
        return
