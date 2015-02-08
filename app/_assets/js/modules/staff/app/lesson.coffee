module.exports =
  template: require './lesson.html'
  data: ->
    tabs:
      'video':  '動画'
      'answer': '設問'
    active: "video"
  events:
    'bs:tabbar:clicked': (@active) -> false
  components:
    video:  require './lesson/video'
    answer: require './lesson/answer'
