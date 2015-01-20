module.exports =
  template: '#show'
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
