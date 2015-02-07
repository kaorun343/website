Create = require '../show/files/create'
{Download} = require 'modules::staff.admin.models'

module.exports = Create.extend
  methods:
    submit: (e) ->
      e.preventDefault()
      Download.post(@$data).done =>
        @$dispatch 'files'
        @filename = ""
        @filepath = ""
        return
      return
