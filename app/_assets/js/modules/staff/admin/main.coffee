module.exports =
  template: '#index'
  data: ->
    lessons: {}
  ready: ->
    base = $('meta[name="_base"]').attr('content')
    $.getJSON "#{base}api/staff/lessons.json", (res) =>
      @lessons = res
      return
    return
