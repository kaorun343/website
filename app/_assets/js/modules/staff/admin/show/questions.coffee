module.exports =
  template: '#questions'
  computed:
    isArray: -> Array.isArray(@questions)
  components:
    question: require './questions/question'
    'new_question': require './questions/create'
