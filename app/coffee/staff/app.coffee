Vue = require 'vue'
route = require 'vue-route'
Vue.use route

setIframe = (videoId) ->
  src = "http://www.youtube.com/embed/#{videoId}?rel=0"
  f1 = "<iframe id='player' src='#{src}' frameborder=0 "
  f2 = "width='640' height='390' allowfullscreen></iframe>"
  f1+f2

app = new Vue
  el: 'body'
  data:
    current:
      lesson: {}
      questions: {}
      #現在解いている問題のID
      num: 0
      #現在解いている問題を全問正解したかどうか
      clear: false
      #問題を解いている状態かどうか
      started: false
    news: {}
    schedules: {}
    lessons: {}
    results: {}
  filters:
    'json': (value) ->
      JSON.stringify value
  computed:
    'current_question': ->
      key = Object.keys(@current.questions)[@current.num]
      @current.questions[key]
    'question_count': ->
      Object.keys(@current.questions).length

  methods:
    navigate: (path) ->
      Vue.navigate("#{path}")
      return
    show: (object) ->
      console.log object
      return
    init: ->
      object =
        lesson: {}
        questions: {}
        num: 0
        clear: false
        started: false
      return object

  ready: ->
    base_url = $('meta[name="_base"]').attr('content')
    $.getJSON "#{base_url}api/staff/lessons.json", (json) =>
      @lessons = json
      return
    return

  components:
    'news':
      template: '#news'
    'home':
      template: '#home'
    'video':
      template: '#lesson'
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
      filters:
        ja: (value) ->
          if value then '正解' else '不正解'
      methods:
        save: ->
          questions = @$root.current.questions
          # 不正解の設問をカウント
          count = 0

          Object.keys(questions).forEach (key) ->
            question = questions[key]
            result = question.model is question.answer
            count += 1 if !result
            return

          # countが0ならクリア
          if count is 0
            @$root.current.clear = true
            #データをサーバーに送信

          $('#myModal').modal
            backdrop: 'static'
            keyboard: false
          return

        previousQuestion: ->
          @$root.current.num--
          return
        nextQuestion: ->
          @$root.current.num++
          return

    'radio':
      template: '#answerRadio'
      methods:
        correct: ->
          @model is @answer
      created: ->
        @$on 'test', (name) ->
          console.log @correct()
          return
    'multiple':
      template: '#answerCheckbox'

  routes:
    '/news':
      componentId: 'news'
      isDefault: true
      beforeUpdate: (location, oldLocation, next) ->
        document.title = "スタッフサイト"
        next()
        return
      afterUpdate: (location, oldLocation) ->
        @current = @init()
        return

    '/list':
      componentId: 'home'
      orderUpdate: (location, oldLocation, next) ->
        document.title = "課題一覧 | スタッフサイト"
        next()
        return
      afterUpdate: (location, oldLocation) ->
        @current = null
        @current = @init()
        return

    '/lessons/:id/video':
      componentId: 'video'
      afterUpdate: (location, oldLocation) ->
        document.title = "課題#{location.params.id} | スタッフサイト"
        #データの初期設定
        if !@current.started
          #問題をサーバーから取得
          #サーバーからは課題の問題だけを取得する
          base_url = $('meta[name="_base"]').attr('content')
          id = location.params.id
          $.getJSON "#{base_url}api/staff/lesson/#{id}.json", (json) =>
            @current.lesson = json
          $.getJSON "#{base_url}api/staff/questions/#{id}.json", (json) =>
            @current.questions = json

          @current.started = true
        return

    '/lessons/:id/answer':
      componentId: 'answer'
      afterUpdate: (location, oldLocation) ->
        document.title = "課題#{location.params.id} | スタッフサイト"
        #データの初期設定
        if !@current.started
          #問題をサーバーから取得
          #サーバーからは課題の問題だけを取得する
          base_url = $('meta[name="_base"]').attr('content')
          id = location.params.id
          $.getJSON "#{base_url}api/staff/lesson/#{id}.json", (json) =>
            @current.lesson = json
          $.getJSON "#{base_url}api/staff/questions/#{id}.json", (json) =>
            @current.questions = json
            return

          @current.started = true
        return

    options:
      hashbang: true
      click: false
