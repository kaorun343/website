{Question} = require 'modules::staff.admin.models'

module.exports =
  ready: ->
    @$set 'deletable', true
    return
  template: require './question.html'
  mixins: [require './_mixin']
  methods:

    submit: (e) ->
      e.preventDefault()
      Question.put(@lesson_id, @id, @$data)
      return
    delete: ->
      Question.delete(@lesson_id, @id).done (res) =>
        @$dispatch 'lesson'
        return
      return
