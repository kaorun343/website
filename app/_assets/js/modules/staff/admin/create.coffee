module.exports =
  data: ->
    title: ""
    video_id: ""
    body: ""
  template: require './show/lesson.html'
  ready: ->
    @$dispatch 'markdown', '#mark'
    return
  methods:
    submit: (e) ->
      e.preventDefault()
      base = $('meta[name="_base"]').attr('content')
      $.ajax
        type: "POST"
        dataType: "json"
        headers:
          'X-Csrf-Token': fuel_csrf_token()
        url: "#{base}admin/staff/lesson"
        data: @$data
      .done (json) =>
        console.log json
        @$root.navigate("/lesson/#{json.id}")
        return
      return
