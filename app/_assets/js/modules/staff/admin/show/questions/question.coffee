module.exports =
  ready: ->
    @$set 'deletable', true
    return
  template: '#question'
  mixins: [require './_mixin']
  methods:

    submit: (e) ->
      e.preventDefault()
      @$dispatch 'put', "/question/#{@id}", @$data, (res) ->
        return
      return
    delete: ->
      @$dispatch 'del', "/question/#{@id}", (res) =>
        @$dispatch 'lesson'
        return
      return
