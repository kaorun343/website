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
  .pipe filter ['**', '!**/_**']
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
  .pipe gulp.dest './assets/js'

# gulp.task 'js', ->
#   gulp.src './app/js/main/**/*.js'
#   .pipe cached 'js'
#   .pipe plumber {errorHandler: notify.onError('<%= error.message %>')}
#   .pipe transform (filename) ->
#     browserify filename
#     .bundle()
#   .pipe gulp.dest './assets/js'

gulp.task 'build', ['jade', 'coffee']
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
  # gulp.watch './app/js/**/*.js', ['js']
