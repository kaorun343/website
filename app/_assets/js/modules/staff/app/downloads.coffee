module.exports =
  template: require './downloads.html'
  data: ->
    base: $('meta[name="_base"]').attr('content')
  computed:
    url: -> "#{@base}staff/download/"
