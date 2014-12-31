Vue = require 'vue'
route = require 'vue-route'
Vue.use route

req = require 'superagent'

app = new Vue
  el: 'body'
  data:
    lesson: {}
  methods:
    navigate: (path) ->
      Vue.navigate("#{path}")
      return
    base_url: ->
      $('meta[name="_base"]').attr('content')
  events:
    lesson: (id) ->
      req.get "#{@base_url()}admin/staff/lesson/#{id}.json", (res) =>
        @$data.lesson = res.body
        return
      return
    questions: (id) ->
      req.get "#{@base_url()}api/staff/lesson/#{id}/questions.json", (res)=>
        @$data.lesson.questions = res.body
        return
      return

  components:
    'index':
      template: '#index'
      data: ->
        data =
          lessons: {}
      ready: ->
        req.get "#{@$root.base_url()}api/staff/lessons.json", (res)=>
          @lessons = res.body
          return
        return
    'new':
      data: ->
        data =
          title: ""
          video_id: ""
          body: ""
      template: '#new'
      methods:
        submit: (e) ->
          e.preventDefault()
          req.post "#{@$root.base_url()}admin/staff/lesson"
          .type 'json'
          .send @$data
          .end (res) =>
            if res.ok
              @$data =
                title: ""
                video_id: ""
                body: ""
            else
              console.log res.text
            return
          return
    'show':
      template: '#show'
      data: ->
        data =
          tab_id: 'lesson'
      methods:
        tab: (tabname)->
          @tab_id = tabname
          return
    'lesson':
      template: '#lesson'
      methods:
        submit: (e) ->
          e.preventDefault()
          id = @$root.lesson.id
          req.put "#{@$root.base_url()}admin/staff/lesson/#{id}"
          .type 'json'
          .send @$root.lesson
          return
    'question':
      template: '#question'
      methods:
        edit: (index, value) ->
          @choices[index] = value
          return
        add: ->
          @choices.push ""
          return
        splice: (index) ->
          @choices.splice index, 1
          return
        submit: (e) ->
          e.preventDefault()
          lesson = @$root.lesson.id
          question = @id
          base = @$root.base_url()

          req.put "#{base}admin/staff/lesson/#{lesson}/question/#{question}"
          .type 'json'
          .send @$data
          .end (res) =>
            if res.ok
              @$data = data
            return
          return
        delete: ->
          lesson = @$root.lesson.id
          question = @id
          base = @$root.base_url()

          req.del "#{base}admin/staff/lesson/#{lesson}/question/#{question}"
          .type 'json'
          .end (res) =>
            @$dispath 'questions', lesson
            return
          return
    'new_question':
      template: '#question'
      data: ->
        data =
          sentence: ""
          answer: "0"
          choices: [""]
      methods:
        edit: (index, value) ->
          @choices[index] = value
          return
        add: ->
          @choices.push ""
          return
        splice: (index) ->
          @choices.splice index, 1
        submit: (e) ->
          e.preventDefault()
          id = @$root.lesson.id
          $.ajax
            type: "POST"
            url: "#{@$root.base_url()}admin/staff/lesson/#{id}/question"
            dataType: "json"
            data: @$data
          .done (data) =>
            @$dispatch 'lesson', data.lesson_id
            @$data =
              sentence: ""
              answer: "0"
              choices: [""]
            return
          .fail (xhr) ->
            console.log xhr
            return
          return
        delete: ->
          return
    'file':
      template: '#file'
    'new_file':
      template: '#file'
      data: ->
        data =
          filename: ""
          filepath: ""
      methods:
        submit: (e) ->
          e.preventDefault()
          id = @$root.lesson.id

          req.post "#{@$root.base_url()}admin/staff/lesson/#{id}/file"
          .type 'json'
          .send @$data
          .end (res) =>
            if res.ok
              @$dispatch 'lesson', id
              @$data =
                filename: ""
                filepath: ""
            return
          return
    'questions':
      template: '#questions'
      computed:
        isArray: ->
          Array.isArray(@questions)
    'files':
      template: '#files'
      computed:
        isArray: ->
          Array.isArray(@files)
  routes:
    '/index':
      isDefault: true
      componentId: 'index'
    '/new':
      componentId: 'new'
    '/lesson/:id':
      componentId: 'show'
      afterUpdate: (location, oldLocation) ->
        @$emit 'lesson', location.params.id
        return
    options:
      hashbang: true
      click: false
