Vue = require 'vue'
route = require 'vue-route'
Vue.use route

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
      $.getJSON "#{@base_url()}admin/staff/lesson/#{id}", (json) =>
        @$data.lesson = json
        return
      return
    questions: (id) ->
      $.getJSON "#{@base_url()}api/staff/lesson/#{id}/questions", (json)=>
        @$data.lesson.questions = json
        return
      return

  components:
    'index':
      template: '#index'
      data: ->
        data =
          lessons: {}
      ready: ->
        $.getJSON "#{@$root.base_url()}api/staff/lessons", (json)=>
          @lessons = json
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
          $.ajax
            type: "POST"
            url: "#{@$root.base_url()}admin/staff/lesson"
            dataType: "json"
            data: @$data
          .done (data) =>
            @$root.lessons[data.id] = data
            return
          .fail (xhr) ->
            console.log xhr.responseJSON
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
          console.log @$root.lesson
          $.ajax
            type: "PUT"
            url: "#{@$root.base_url()}admin/staff/lesson/#{id}"
            data: @$root.lesson
            dataType: "json"
          .done (data) ->
            console.log data
            return
          .fail (xhr) ->
            console.log xhr.responseJSON
            return
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
          console.log JSON.stringify @$data
          $.ajax
            type: "PUT"
            url: "#{base}admin/staff/lesson/#{lesson}/question/#{question}"
            dataType: "json"
            data: @$data
          .done (data) ->
            @$data = data
            console.log data
            return
          .fail (xhr) ->
            console.log xhr.responseText
            return
          return
        delete: ->
          lesson = @$root.lesson.id
          question = @id
          base = @$root.base_url()
          $.ajax
            type: "DELETE"
            url: "#{base}admin/staff/lesson/#{lesson}/question/#{question}"
            dataType: "json"
          .done (data) =>
            @$dispatch 'questions', lesson
            # @$dispatch 'lesson', lesson
            return
          .fail (xhr) ->
            console.log xhr
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
        delete: ->
          return
    'file':
      template: '#file'
    'questions':
      template: '#questions'
    'files':
      template: '#files'
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
