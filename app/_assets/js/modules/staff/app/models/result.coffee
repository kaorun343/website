Api = require './api'

class Result extends Api

  @get: (lesson_id) -> $.getJSON "#{base}/lesson/#{lesson_id}/results"

  @post: (lesson_id) ->
    $.ajax
      type: "POST"
      dataType: "json"
      url: "#{@base}/lesson/#{lesson_id}/result"
      headers: @headers()

module.exports = Result
