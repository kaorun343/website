Vue   = require 'vue'
route = require 'vue-route'
Vue.use route

bootstrap = require 'vue-bootstrap'
Vue.use bootstrap

moment = require 'moment'

{Api, Lesson, Result} = require 'modules::staff.app.models'

app = new Vue
  el: '#app'
  template: require './app.html'
  mixins: [bootstrap.mixin]
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

  ready: ->
    Api.getAll().then ({@articles, @downloads, @lessons, @results}) => return
    return

  events:
    'post:result': ->
      unless @results[@lesson.id]
        Result.post(@lesson.id).then (@results) => return
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
      afterUpdate: ->
        document.title = "スタッフサイト"
        return

    '/lessons':
      componentId: 'home'
      afterUpdate: ->
        document.title = "課題一覧 | スタッフサイト"
        return

    '/lessons/:id':
      componentId: 'lesson'
      afterUpdate: ({params}) ->
        document.title = "課題#{params.id} | スタッフサイト"
        Lesson.get(params.id).then (@lesson) => return
        return
