module.exports =
  template: require './main.html'
  data: ->
    lessons: {}
  ready: ->
    base = $('meta[name="_base"]').attr('content')
    $.getJSON "#{base}api/staff/lessons.json", (res) =>
      @lessons = res
      return
    return
