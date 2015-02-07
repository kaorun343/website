Admin = require './admin'

class Result extends Admin
  @getAll: -> $.getJSON "#{@base}/results"


module.exports = Result
