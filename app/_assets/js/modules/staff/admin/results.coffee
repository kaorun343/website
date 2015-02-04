module.exports =
  template: require './results.html'
  components:
    user: require './results/user'
  data: ->
    base: $('meta[name="_base"]').attr('content')
    results: {}
  compiled: ->
    $.getJSON "#{@base}admin/staff/results", (@results) =>
      return
    return
