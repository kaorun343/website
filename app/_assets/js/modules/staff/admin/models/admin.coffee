class Admin
  @base: "#{$('meta[name="_base"]').attr('content')}admin/staff"

  @headers: ->
    'X-Csrf-Token': fuel_csrf_token()

module.exports = Admin
