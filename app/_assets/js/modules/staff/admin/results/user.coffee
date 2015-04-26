module.exports =
  template: require './user.html'
  computed:
    size: -> Object.keys(@result.lessons).length
