Vue = require 'vue'
{File} = require 'modules::staff.admin.models'

module.exports = Vue.extend
  template: require './create.html'
  created: ->
    File.getAll().done (res) =>
      data = res.map (name) -> {text: name, value: name}
      data.unshift text: "選択してください", value: ""
      @$set 'list', data
      return
    return
  data: ->
    list:      []
    deletable: false
    filename:  ""
    filepath:  ""
  methods:
    submit: (e) ->
      e.preventDefault()
      File.post(@lesson_id, @$data).done =>
        @$dispatch 'lesson'
        @filename = ""
        @filepath = ""
        return
      return
    delete: -> return
