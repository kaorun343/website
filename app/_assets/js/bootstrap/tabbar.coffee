module.exports =
  template:        require './tabbar.html'
  paramAttributes: ['active', 'tabs']
  methods:
    activate: (tabId) ->
      @$dispatch 'bs:tabbar:clicked', tabId
      return
