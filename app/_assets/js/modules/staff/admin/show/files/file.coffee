module.exports =
  template: require './file.html'
  ready: ->
    @$set 'deletable', true
    return
  methods:
    submit: (e) ->
      e.preventDefault()
      @$dispatch 'put', "/file/#{@id}", @$data, ->
        return
      return
    delete: ->
      @$dispatch 'del', "/file/#{@id}", =>
        @$dispatch 'lesson'
        return
      return
