module.exports =
  template: '#file'
  data: ->
    deletable: false
    filename: ""
    filepath: ""
  methods:
    submit: (e) ->
      e.preventDefault()
      @$dispatch 'post', "/file", @$data, (res) =>
        @$dispatch 'lesson'
        @filename = ""
        @filepath = ""
        return
      return
    delete: -> return
