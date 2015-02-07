{Lesson} = require 'modules::staff.admin.models'

module.exports =
  template: require './main.html'
  data: ->
    lessons: {}
  ready: ->
    Lesson.getAll().done (@lessons) => return
    return
