{Result} = require 'modules::staff.admin.models'

module.exports =
  template: require './results.html'
  components:
    user: require './results/user'
  data: ->
    results: {}
  ready: ->
    Result.getAll().done (@results) => return
    return
