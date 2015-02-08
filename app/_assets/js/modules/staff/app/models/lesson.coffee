Api = require './api'

class Lesson extends Api

  @get: (id) -> $.getJSON "#{@base}/lesson/#{id}"

module.exports = Lesson
