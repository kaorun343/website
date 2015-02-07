Admin = require './admin'

class Lesson extends Admin

  @get: (id) -> $.getJSON "#{@base}/lesson/#{id}.json"

  @getAll: -> $.getJSON "#{@base}/lessons.json"

  @post: (data) ->
    $.ajax
      type:     "POST"
      dataType: "json"
      headers:  @headers()
      url:      "#{@base}/lesson"
      data:     data

  @put: (id, data) ->
    $.ajax
      type:     "PUT"
      dataType: "json"
      headers:  @headers()
      url:      "#{@base}lesson/id"
      data:     data

module.exports = Lesson
