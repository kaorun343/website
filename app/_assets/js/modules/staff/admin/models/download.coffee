Admin = require './admin'

class Download extends Admin

  @getAll: -> $.getJSON "#{@base}/downloads"

  @post: (data) ->
    $.ajax
      type: "POST"
      dataType: "json"
      headers: @headers()
      url: "#{@base}/download"
      data: data

  @put: (id, data) ->
    $.ajax
      type: "PUT"
      dataType: "json"
      headers: @headers()
      url: "#{@base}/download/#{id}"
      data: data

  @delete: (id) ->
    $.ajax
      type: "DELETE"
      dataType: "json"
      headers: @headers()
      url: "#{@base}/download/#{id}"


module.exports = Download
