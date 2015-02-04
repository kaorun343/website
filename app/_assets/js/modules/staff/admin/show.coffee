module.exports =
  template: require './show.html'
  data: ->
    active: 'lesson'
    tabs:
      'lesson':    '課題'
      'questions': '設問'
      'files':     'ファイル'
  events:
    'bs:tabbar:clicked': (tabId) ->
      @active = tabId
      false
  components:
    lesson:    require './show/lesson'
    questions: require './show/questions'
    files:     require './show/files'
