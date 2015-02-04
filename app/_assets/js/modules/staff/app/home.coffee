module.exports =
  template: require './home.html'
  data: ->
    base: $('meta[name="_base"]').attr('content')
  filters:
    hasCleared: (id) -> @$root.results[id]
    hasNotCleared: (id) -> !@$root.results[id]
