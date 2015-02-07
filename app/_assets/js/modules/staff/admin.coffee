Vue   = require 'vue'
route = require 'vue-route'
Vue.use route

bootstrap = require 'vue-bootstrap'
Vue.use bootstrap

marked        = require 'marked'
window.marked = marked
moment        = require 'moment'

do ($ = jQuery) ->
  $.fn.markdown.messages['ja'] =
    'Bold':           '太字'
    'Italic':         '斜体'
    'Heading':        '見出し'
    'URL/Link':       'リンク'
    'Unordered List': 'リスト'
    'Ordered List':   '順序付きリスト'
    'Preview':        'プレビュー'
  return


{File, Lesson} = require 'modules::staff.admin.models'

app = new Vue
  el: '#app'
  template: require './admin.html'
  data:
    lesson: {}
  methods:
    navigate: (path) ->
      Vue.navigate("#{path}")
      return
  filters:
    timestamp: (value) -> moment.unix(value).format "MM月DD日 HH時mm分" if value
  events:
    lesson: (id) ->
      Lesson.get(id or @lesson.id).done (@lesson) => return
      return

    markdown: (id) ->
      $(id).markdown
        language: 'ja'
        fullscreen:
          enable: false
        hiddenButtons: ["Quote", "Image", "Code"]
      return

  components:
    index:     require './admin/main'
    create:    require './admin/create'
    show:      require './admin/show'
    downloads: require './admin/downloads'
    results:   require './admin/results'
  routes:
    '/index':
      isDefault:   true
      componentId: 'index'
    '/new':
      componentId: 'create'
    '/lesson/:id':
      componentId: 'show'
      afterUpdate: ({params}) ->
        @$emit 'lesson', params.id
        return
    '/downloads':
      componentId: 'downloads'
    '/results':
      componentId: 'results'
    options:
      hashbang: true
      click:    false
