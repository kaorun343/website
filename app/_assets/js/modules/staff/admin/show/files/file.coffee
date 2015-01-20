module.exports =
  template: '#file'
  ready: ->
    @$set 'deletable', true
    return
  methods:
    submit: (e) ->
      e.preventDefault()
      @$dispatch 'put', "/file/#{@id}", @$data, (res) ->
        return
      return
    delete: ->
      @$dispatch 'del', "/file/#{@id}", (res) =>
        @$dispatch 'lesson'
        return
      return
