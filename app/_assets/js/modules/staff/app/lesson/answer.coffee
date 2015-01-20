module.exports =
  template: require './answer.html'
  components:
    radio: require './answer/radio'
  data: ->
    #現在解いている問題を全問正解したかどうか
    clear: false
    index: 0
    question_count: 0
    question_keys: {}
  computed:
    'question': ->
      key = @question_keys[@index]
      @questions[key]
  filters:
    ja: (value) ->
      if value then '正解' else '不正解'
  events:
    count: (keys)->
      @question_keys = keys

      length = keys.length
      @question_count = length
      @$dispatch 'size', length
      return
  methods:
    previousQuestion: ->
      @index--
      return
    nextQuestion: ->
      @index++
      return
    save: ->
      # 不正解の設問をカウント
      failed = 0

      Object.keys(@questions).forEach (key) =>
        question = @questions[key]
        result = "#{question.model}" is "#{question.answer}"
        failed += 1 if !result
        return

      # countが0ならクリア
      if failed is 0
        @clear = true
        #データをサーバーに送信
        @$dispatch 'result'

      $('#myModal').modal
        backdrop: 'static'
        keyboard: false
      return
