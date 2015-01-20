module.exports =
  template: require './question.html'
  mixins: [require './_mixin']
  data: ->
    deletable: false
    sentence: ""
    answer: "0"
    choices: [""]
  methods:

    submit: (e) ->
      e.preventDefault()
      @$dispatch 'post', "/question", @$data, (res) =>
        @$dispatch 'lesson'
        @sentence = ""
        @answer = "0"
        @choices = [""]
        return
      return
    delete: -> return
