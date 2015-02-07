File = require '../show/files/file'
{Download} = require 'modules::staff.admin.models'

module.exports = File.extend
  methods:
    submit: (e) ->
      e.preventDefault()
      Download.put(@id, @$data)
      return
    delete: ->
      Download.delete(@id).done =>
        @$dispatch 'files'
        return
      return
