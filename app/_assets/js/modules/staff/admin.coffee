Vue = require 'vue'
route = require 'vue-route'
Vue.use route

marked = require 'marked'
window.marked = marked
moment = require 'moment'

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
  filters:
    timestamp: (value) ->
      if value
        moment.unix(value).format "MM月DD日 HH時mm分"
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
          'X-Csrf-Token': fuel_csrf_token()
        url: "#{@base_url()}admin/staff/lesson/#{@lesson.id}#{url}"
        data: data
      .done done
      return

    put: (url, data, done) ->
      $.ajax
        type: "PUT"
        dataType: "json"
        headers:
          'X-Csrf-Token': fuel_csrf_token()
        url: "#{@base_url()}admin/staff/lesson/#{@lesson.id}#{url}"
        data: data
      .done done
      return

    del: (url, done) ->
      $.ajax
        type: "DELETE"
        dataType: "json"
        headers:
          'X-Csrf-Token': fuel_csrf_token()
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
    index: require './admin/main'
    create: require './admin/create'
    show: require './admin/show'
  routes:
    '/index':
      isDefault: true
      componentId: 'index'
    '/new':
      componentId: 'create'
    '/lesson/:id':
      componentId: 'show'
      afterUpdate: (location, oldLocation) ->
        @$emit 'lesson', location.params.id
        return
    options:
      hashbang: true
      click: false
