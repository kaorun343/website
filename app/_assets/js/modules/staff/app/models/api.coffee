class Api
  @base: "#{$('meta[name="_base"]').attr('content')}api/staff"

  @headers: ->
    'X-Csrf-Token': fuel_csrf_token()

  @getAll: -> $.getJSON "#{@base}"

module.exports = Api
