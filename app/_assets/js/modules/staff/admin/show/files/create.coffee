module.exports =
  template: require './create.html'
  created: ->
    @$dispatch 'files', (res) =>
      data = res.map (name) -> {text: name, value: name}
      data.unshift text: "選択してください", value: ""
      @$set 'list', data
      return
    return
  data: ->
    list: []
    deletable: false
    filename: ""
    filepath: ""
  methods:
    submit: (e) ->
      e.preventDefault()
      @$dispatch 'post', "/file", @$data, =>
        @$dispatch 'lesson'
        @filename = ""
        @filepath = ""
        return
      return
    delete: -> return
