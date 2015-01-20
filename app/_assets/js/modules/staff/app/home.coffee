module.exports =
  template: '#home'
  filters:
    hasCleared: (id) ->
      @$root.results[id]
    hasNotCleared: (id) ->
      if @$root.results[id] then false else true
