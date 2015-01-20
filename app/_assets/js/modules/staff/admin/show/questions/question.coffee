module.exports =
  ready: ->
    @$set 'deletable', true
    return
  template: require './question.html'
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
