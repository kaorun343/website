src = './app/_assets/js'
dest = './assets/js'
path = require 'path'
webpack = require 'webpack'
module.exports = (option)->
  data =
    watch: option.watch
    entry:
      "modules/staff/app": "#{src}/modules/staff/app.coffee"
      "modules/staff/admin": "#{src}/modules/staff/admin.coffee"
    output:
      filename: "#{dest}/[name].js"
    resolve:
      extensions: ["", ".js", ".coffee"]
    module:
      loaders: [
        { test: /\.coffee$/, loader: 'coffee-loader' },
        { test: /\.html$/, loader: "html-loader" }
      ]
