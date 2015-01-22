module.exports =
  template: require './answer.html'
  components:
    radio: require './answer/radio'
  data: ->
    #現在解いている問題を全問正解したかどうか
    clear: false
    results: []
  filters:
    ja: (value) -> if value then '正解' else '不正解'
  methods:
    save: ->
      @$set 'results', @$.questions.map (q) -> q.getData()

      if @results.reduce ((t, q) -> if q.result then t else false), true
        @clear = true
        #データをサーバーに送信
        @$dispatch 'result'

      $('#myModal').modal
        backdrop: 'static'
        keyboard: false
      return
    hide: ->
      $('#myModal').modal 'hide'
      @$root.navigate('/list')
      return
