Admin = require './admin'

class Question extends Admin

  @post: (lesson_id, data) ->
    $.ajax
      type:     "POST"
      dataType: "json"
      headers:  @headers()
      url:      "#{@base}/lesson/#{lesson_id}/question"
      data:     data

  @put: (lesson_id, id, data) ->
    $.ajax
      type:     "PUT"
      dataType: "json"
      headers:  @headers()
      url:      "#{@base}/lesson/#{lesson_id}/question/#{id}"
      data:     data

  @delete: (lesson_id, id) ->
    $.ajax
      type:     "DELETE"
      dataType: "json"
      headers:  @headers()
      url:      "#{@base}/lesson/#{lesson_id}/question/#{id}"


module.exports = Question
