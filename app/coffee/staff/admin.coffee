Vue = require 'vue'
route = require 'vue-route'
Vue.use route

require 'bootstrap-markdown'
marked = require 'marked'
window.marked = marked

do ($ = jQuery) ->
  $.fn.markdown.messages['ja'] =
    'Bold': '太字'
    'Italic': '斜体'
    'Heading': '見出し'
    'URL/Link': 'リンク'
    'Unordered List': 'リスト'
    'Ordered List': '順序付きリスト'
    'Preview': 'プレビュー'
  return


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
      i = if id then id else @lesson.id
      $.getJSON "#{@base_url()}admin/staff/lesson/#{i}.json", (res) =>
        @lesson = res
        return
      return

    post: (url, data, done) ->
      $.ajax
        type: "POST"
        dataType: "json"
        headers:
          'fuel_csrf_token': fuel_csrf_token()
        url: "#{@base_url()}admin/staff/lesson/#{@lesson.id}#{url}"
        data: data
      .done done
      return

    put: (url, data, done) ->
      $.ajax
        type: "PUT"
        dataType: "json"
        headers:
          'fuel_csrf_token': fuel_csrf_token()
        url: "#{@base_url()}admin/staff/lesson/#{@lesson.id}#{url}"
        data: data
      .done done
      return

    del: (url, done) ->
      $.ajax
        type: "DELETE"
        dataType: "json"
        headers:
          'fuel_csrf_token': fuel_csrf_token()
        url: "#{@base_url()}admin/staff/lesson/#{@lesson.id}#{url}"
      .done done
      return

    markdown: (id) ->
      $(id).markdown
        language: 'ja'
        fullscreen:
          enable: false
        hiddenButtons: ["Quote", "Image", "Code"]
      return

  components:
    'index':
      template: '#index'
      data: ->
        data =
          lessons: {}
      ready: ->
        base = $('meta[name="_base"]').attr('content')
        $.getJSON "#{base}api/staff/lessons.json", (res) =>
          @lessons = res
          return
        return
    'new':
      data: ->
        data =
          title: ""
          video_id: ""
          body: ""
      template: '#new'
      ready: ->
        @$dispatch 'markdown', '#mark'
        return
      methods:
        submit: (e) ->
          e.preventDefault()
          @$dispatch 'post', "admin/staff/lesson", @$data, (res) =>
            @title = ""
            @video_id = ""
            @body = ""
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
      ready: ->
        @$dispatch 'markdown', '#mark'
        return
      methods:
        submit: (e) ->
          e.preventDefault()
          data =
            title: @$data.title
            video_id: @$data.video_id
            body: @$data.body
          @$dispatch 'put', "", data, (res)->
            return
          return
    'questions':
      template: '#questions'
      computed:
        isArray: ->
          Array.isArray(@questions)
      components:
        'question':
          ready: ->
            @$set 'deletable', true
            return
          template: '#question'
          methods:
            # 選択肢の編集に関するメソッド
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
              @$dispatch 'put', "/question/#{@id}", @$data, (res) ->
                return
              return
            delete: ->
              @$dispatch 'del', "/question/#{@id}", (res) =>
                @$dispatch 'lesson'
                return
              return
        'new_question':
          template: '#question'
          data: ->
            data =
              deletable: false
              sentence: ""
              answer: "0"
              choices: [""]
          methods:
            # 選択肢の編集に関するメソッド
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
              @$dispatch 'post', "/question", @$data, (res) =>
                @$dispatch 'lesson'
                @sentence = ""
                @answer = "0"
                @choices = [""]
                return
              return
            delete: -> return
    'files':
      template: '#files'
      computed:
        isArray: ->
          Array.isArray(@files)
      components:
        'file':
          template: '#file'
          ready: ->
            @$set 'deletable', true
            return
          methods:
            submit: (e) ->
              e.preventDefault()
              @$dispatch 'put', "/file/#{@id}", @$data, (res) ->
                return
              return
            delete: ->
              @$dispatch 'del', "/file/#{@id}", (res) =>
                @$dispatch 'lesson'
                return
              return
        'new_file':
          template: '#file'
          data: ->
            data =
              deletable: false
              filename: ""
              filepath: ""
          methods:
            submit: (e) ->
              e.preventDefault()
              @$dispatch 'post', "/file", @$data, (res) =>
                @$dispatch 'lesson'
                @filename = ""
                @filepath = ""
                return
              return
            delete: -> return
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
