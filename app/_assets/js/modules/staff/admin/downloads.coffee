{Download} = require 'modules::staff.admin.models'

module.exports =
  template: require './downloads.html'
  components:
    file: require './downloads/file'
    'new_file': require './downloads/create'
  data: ->
    files: {}
  computed:
    isArray: -> Array.isArray(@files)
  ready: ->
    @$emit 'files'
    return
  events:
    files: ->
      Download.getAll().then (@files) => return
      return
