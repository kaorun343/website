module.exports =
  template: require './questions.html'
  computed:
    isArray: -> Array.isArray(@questions)
  components:
    question: require './questions/question'
    'new_question': require './questions/create'
