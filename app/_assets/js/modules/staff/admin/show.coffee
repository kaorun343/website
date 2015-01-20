module.exports =
  template: require './show.html'
  data: ->
    tab_id: 'lesson'
  methods:
    tab: (tabname)->
      @tab_id = tabname
      return
  components:
    lesson: require './show/lesson'
    questions: require './show/questions'
    files: require './show/files'
