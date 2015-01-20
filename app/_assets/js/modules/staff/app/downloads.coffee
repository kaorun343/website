module.exports =
  template: require './downloads.html'
  data: ->
    base: $('meta[name="_base"]').attr('content')
    files: {}
  ready: ->
    $.getJSON "#{@base}api/staff/downloads", (json) =>
      @files = json
      return
    return
