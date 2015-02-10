marked = require 'marked'
moment = require 'moment'

module.exports =
  template: require './video.html'
  filters:
    timestamp: (id) ->
      date = @$root.results[id]
      moment.unix(date).format("MM月DD日 HH時mm分") if date
    marked: (value) -> marked value or "（説明なし）"
  directives:
    'youtube':
      isLiteral: true
      bind: ->
        @el.innerHTML = setIframe(@expression)
        return
      update: (value) ->
        @el.innerHTML = setIframe(value)
        return

setIframe = (videoId) ->
  src = "http://www.youtube.com/embed/#{videoId}?rel=0"
  f1 = "<iframe id='player' src='#{src}' frameborder=0 "
  f2 = "width='640' height='390' allowfullscreen></iframe>"
  f1+f2
