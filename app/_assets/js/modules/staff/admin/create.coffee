{Lesson} = require 'modules::staff.admin.models'

module.exports =
  data: ->
    title: ""
    video_id: ""
    body: ""
  template: require './show/lesson.html'
  ready: ->
    @$dispatch 'markdown', '#mark'
    return
  methods:
    submit: (e) ->
      e.preventDefault()
      Lesson.post(@$data).done ({id}) =>
        @$root.navigate("/lesson/#{id}")
        return
      return
