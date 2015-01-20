module.exports =
  template: require './lesson.html'
  ready: ->
    @$dispatch 'markdown', '#mark'
    return
  methods:
    submit: (e) ->
      e.preventDefault()
      data =
        title: @$data.title
        video_id: @$data.video_id
        body: @$data.body
      @$dispatch 'put', "", data, (res)->
        return
      return
