module.exports =
  template: require './files.html'
  computed:
    isArray: -> Array.isArray(@files)
  components:
    file: require './files/file'
    'new_file': require './files/create'
