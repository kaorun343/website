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
      num: 0
      clear: false
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

  directives:
    'youtube':
      isLiteral: true
      bind: ->
        @el.innerHTML = setIframe(@expression)
        return
      update: (value) ->
        @el.innerHTML = setIframe(value)
        return

  components:
    'news':
      template: '#news'
    'home':
      template: '#home'
    'video':
      template: '#lesson'
    'answer':
      template: '#answer'
      filters:
        ja: (value) ->
          if value then '正解' else '不正解'
      methods:
        save: ->
          questions = @$root.current.questions
          count = 0

          Object.keys(questions).forEach (key) ->
            question = questions[key]
            result = question.model is question.answer
            count += 1 if !result
            console.log "#{question.sentence}: #{result}"
            return

          @$root.current.clear = count is 0
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
        @current =
          lesson: {}
          questions: {}
          num: 0
          clear: false
        return

    '/list':
      componentId: 'home'
      orderUpdate: (location, oldLocation, next) ->
        document.title = "課題一覧 | スタッフサイト"
        next()
        return
      afterUpdate: (location, oldLocation) ->
        @current =
          lesson: {}
          questions: {}
          num: 0
          clear: false
        return

    '/lesson/:id/video':
      componentId: 'video'
      beforeUpdate: (location, oldLocation, next) ->
        @current.lesson = @lessons[location.params.id]
        document.title = "課題#{location.params.id} | スタッフサイト"
        next()
        return
      afterUpdate: (location, oldLocation) ->
        @current.questions = require('./_data/questions.coffee')
        return

    '/lesson/:id/answer':
      componentId: 'answer'
      beforeUpdate: (location, oldLocation, next) ->
        document.title = "課題#{location.params.id} | スタッフサイト"
        next()
        return

    options:
      hashbang: true
      click: false

  methods:
    navigate: (path) ->
      Vue.navigate("#{path}")
      return
    show: (object) ->
      console.log object
      return
  ready: ->
    @lessons = require('./_data/lessons.coffee')
    return
