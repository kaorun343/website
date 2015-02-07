{File} = require 'modules::staff.admin.models'

module.exports =
  template: require './file.html'
  ready: ->
    @$set 'deletable', true
    return
  methods:
    submit: (e) ->
      e.preventDefault()
      File.put(@lesson_id, @id, @$data)
      return
    delete: ->
      File.delete(@lesson_id, @id).done =>
        @$dispatch 'lesson'
        return
      return
