Vue = require 'vue'
route = require 'vue-route'
Vue.use route

moment = require 'moment'
marked = require 'marked'

setIframe = (videoId) ->
  src = "http://www.youtube.com/embed/#{videoId}?rel=0"
  f1 = "<iframe id='player' src='#{src}' frameborder=0 "
  f2 = "width='640' height='390' allowfullscreen></iframe>"
  f1+f2

app = new Vue
  el: 'body'
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


  ready: ->
    @get_lessons()
    $.getJSON "#{@base_url()}api/staff/results", (json) =>
      @results = json
      return
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
            'fuel_csrf_token': fuel_csrf_token()
        .done (res) =>
          @get_lessons()
        return

  components:
    'news':
      template: '#news'
    'home':
      template: '#home'
      filters:
        hasCleared: (id) ->
          @$root.results[id]
        hasNotCleared: (id) ->
          if @$root.results[id] then false else true
    'lesson':
      template: '#lesson'
      data: ->
        data =
          tab_id: "video"
          length: 0
      methods:
        tab: (tabname) ->
          @tab_id = tabname
          return
      events:
        size: (length) ->
          @length = length
          return
    'video':
      template: '#video'
      filters:
        timestamp: (id) ->
          if timestamp = @$root.results[id]
            moment.unix(timestamp).format "MM月DD日 HH時mm分"
          else
            ""
        marked: (value) ->
          if value then marked value else "（説明なし）"
      directives:
        'youtube':
          isLiteral: true
          bind: ->
            @el.innerHTML = setIframe(@expression)
            return
          update: (value) ->
            @el.innerHTML = setIframe(value)
            return
    'answer':
      template: '#answer'
      data: ->
        data =
          #現在解いている問題を全問正解したかどうか
          clear: false
          index: 0
          question_count: 0
          question_keys: {}
      computed:
        'question': ->
          key = @question_keys[@index]
          @questions[key]
      filters:
        ja: (value) ->
          if value then '正解' else '不正解'
      events:
        count: (keys)->
          @question_keys = keys

          length = keys.length
          @question_count = length
          @$dispatch 'size', length
          return
      methods:
        previousQuestion: ->
          @index--
          return
        nextQuestion: ->
          @index++
          return
        save: ->
          # 不正解の設問をカウント
          failed = 0

          Object.keys(@questions).forEach (key) =>
            question = @questions[key]
            result = "#{question.model}" is "#{question.answer}"
            failed += 1 if !result
            return

          # countが0ならクリア
          if failed is 0
            @clear = true
            #データをサーバーに送信
            @$dispatch 'result'

          $('#myModal').modal
            backdrop: 'static'
            keyboard: false
          return
      components:
        'radio':
          template: '#answerRadio'

  routes:
    options:
      hashbang: true
      click: false

    '/index':
      componentId: 'news'
      isDefault: true
      afterUpdate: (location, oldLocation) ->
        document.title = "スタッフサイト"
        return

    '/list':
      componentId: 'home'
      afterUpdate: (location, oldLocation) ->
        document.title = "課題一覧 | スタッフサイト"
        return

    '/lesson/:id':
      componentId: 'lesson'
      afterUpdate: (location, oldLocation) ->
        document.title = "課題#{location.params.id} | スタッフサイト"
        @$emit 'lesson', location.params.id
        return
