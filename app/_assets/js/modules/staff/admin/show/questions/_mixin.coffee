module.exports =
  methods:
    # 選択肢の編集に関するメソッド
    edit: (index, value) ->
      @choices[index] = value
      return
    add: ->
      @choices.push ""
      return
    splice: (index) ->
      @choices.splice index, 1
      return
