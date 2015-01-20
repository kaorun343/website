module.exports =
  template: require './home.html'
  data: ->
    base: $('meta[name="_base"]').attr('content')
  filters:
    hasCleared: (id) ->
      @$root.results[id]
    hasNotCleared: (id) ->
      if @$root.results[id] then false else true
