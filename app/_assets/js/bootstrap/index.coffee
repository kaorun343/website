exports.install = (Vue, option) ->
  Vue.component 'bs-tabbar', require './tabbar'
  return

exports.mixin =
  events:
    'bs:modal': (e, options) ->
      $(e).modal options
      return
