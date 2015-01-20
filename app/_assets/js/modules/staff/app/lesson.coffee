module.exports =
  template: '#lesson'
  data: ->
    tab_id: "video"
    length: 0
  methods:
    tab: (tabname) ->
      @tab_id = tabname
      return
  events:
    size: (length) ->
      @length = length
      return
  components:
    video: require './lesson/video'
    answer: require './lesson/answer'
