src            = './app/_assets/js'
dest           = './assets'
path           = require 'path'
webpack        = require 'webpack'
mPath = "#{__dirname}/app/_assets/js/modules"

module.exports = ({watch}) ->
  watch: watch
  entry:
    "js/modules/staff/app":   "#{src}/modules/staff/app.coffee"
    "js/modules/staff/admin": "#{src}/modules/staff/admin.coffee"
  output:
    filename: "#{dest}/[name].js"
  resolve:
    extensions: ["", ".js", ".coffee"]
    alias:
      'vue-bootstrap': "#{__dirname}/app/_assets/js/bootstrap/index.coffee"

      'modules::staff.app.models':   "#{mPath}/staff/app/models/index.coffee"
      'modules::staff.admin.models': "#{mPath}/staff/admin/models/index.coffee"
  module:
    loaders: [
      { test: /\.coffee$/, loader: 'coffee-loader' },
      { test: /\.html$/, loader: "html-loader" }
    ]
