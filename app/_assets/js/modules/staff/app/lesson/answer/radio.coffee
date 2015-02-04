module.exports =
  template: require './radio.html'
  data: ->
    model: ""
  methods:
    validate: -> "#{@model}" is "#{@question.answer}"
    getData: ->
      model:    @question.choices[@model]
      sentence: @question.sentence
      result:   @validate()
