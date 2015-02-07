{Lesson} = require 'modules::staff.admin.models'

module.exports =
  template: require './lesson.html'
  ready: ->
    @$dispatch 'markdown', '#mark'
    return
  methods:
    submit: (e) ->
      e.preventDefault()
      {title, video_id, body} = @$data
      Lesson.put(@id, {title, video_id, body})
      return
