Admin = require './admin'

class File extends Admin

  @getAll: -> $.getJSON "#{@base}/files.json"

  @post: (lesson_id, data) ->
    $.ajax
      type:     "POST"
      dataType: "json"
      headers:  @headers()
      url:      "#{@base}/lesson/#{lesson_id}/file"
      data:     data

  @put: (lesson_id, id, data) ->
    $.ajax
      type:     "PUT"
      dataType: "json"
      headers:  @headers()
      url:      "#{@base}/lesson/#{lesson_id}/file/#{id}"
      data:     data

  @delete: (lesson_id, id) ->
    $.ajax
      type:     "DELETE"
      dataType: "json"
      headers:  @headers()
      url:      "#{@base}/lesson/#{lesson_id}/file/#{id}"

module.exports = File
