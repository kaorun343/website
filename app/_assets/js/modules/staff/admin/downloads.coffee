module.exports =
  template: require './downloads.html'
  components:
    files: require './show/files'
  data: ->
    files: {}
  ready: ->
    @downloads()
    return
  methods:
    base_url: -> $('meta[name="_base"]').attr('content')
    downloads: ->
      $.getJSON "#{@base_url()}api/staff/downloads.json", (@lessons) =>
        return
      return
  events:
    lesson: ->
      @downloads()
      false

    post: (url, data, done) ->
      $.ajax
        type: "POST"
        dataType: "json"
        headers:
          'X-Csrf-Token': fuel_csrf_token()
        url: "#{@base_url()}admin/staff/download"
        data: data
      .done done
      false

    put: (url, data, done) ->
      array = url.split('/')
      id = array[array.length-1]
      $.ajax
        type: "PUT"
        dataType: "json"
        headers:
          'X-Csrf-Token': fuel_csrf_token()
        url: "#{@base_url()}admin/staff/download/#{id}"
        data: data
      .done done
      false

    del: (url, done) ->
      array = url.split('/')
      id = array[array.length-1]
      $.ajax
        type: "DELETE"
        dataType: "json"
        headers:
          'X-Csrf-Token': fuel_csrf_token()
        url: "#{@base_url()}admin/staff/download/#{id}"
      .done done
      false
