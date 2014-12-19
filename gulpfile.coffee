gulp = require 'gulp'
browserify = require 'browserify'
transform = require 'vinyl-transform'
source = require 'vinyl-source-stream'
cached = require 'gulp-cached'
remember = require 'gulp-remember'
rename = require 'gulp-rename'
jade = require 'gulp-jade-php'
filter = require 'gulp-filter'
plumber = require 'gulp-plumber'
notify = require 'gulp-notify'
uglify = require 'gulp-uglify'
less = require 'gulp-less'
minify = require 'gulp-minify-css'
coffee = require 'coffee-script'
through = require 'through'
del = require 'del'

gulp.task 'jade', ->
  gulp.src './app/jade/**/*.jade'
  .pipe filter ['**', '!**/_*/**']
  .pipe plumber {errorHandler: notify.onError('<%= error.message %>')}
  .pipe jade {pretty: true}
  .pipe rename (path) ->
    path.dirname += '/views'
    return
  .pipe gulp.dest './fuel/app'

gulp.task 'coffee', ->
  gulp.src './app/coffee/**/*.coffee'
  .pipe filter ['**', '!**/_*/**']
  .pipe cached 'coffee'
  .pipe plumber {errorHandler: notify.onError('<%= error.message %>')}
  .pipe transform (filename) ->
    browserify filename
    .transform (file) ->
      data = ''

      write = (buf) ->
        data += buf
        return
      end = ->
        @queue coffee.compile data
        @queue null
        return

      through write, end

    .bundle()
  .pipe rename {extname: '.js'}
  .pipe uglify()
  .pipe gulp.dest './assets/js'

gulp.task 'less', ->
  gulp.src './app/less/**/*.less'
  .pipe cached 'less'
  .pipe less
    paths: ['./app/bower_components/']
  .pipe minify()
  .pipe gulp.dest './assets/css'


gulp.task 'build', ['jade', 'coffee', 'less']
gulp.task 'clean', (cb) ->
  del [
    './fuel/app/**/views/*.php'
    './assets/js/**/*.js'
    './assets/css/**/*.css'
    ],
    cb
  return

gulp.task 'watch', ['build'], ->
  gulp.watch './app/jade/**/*.jade', ['jade']
  gulp.watch './app/coffee/**/*.coffee', ['coffee']
  gulp.watch './app/less/**/*.js', ['less']
