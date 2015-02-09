bodyParser = require 'body-parser'
consolidate = require 'consolidate'
cookieParser = require 'cookie-parser'
express = require 'express'
favicon = require 'serve-favicon'
logger = require 'morgan'
path = require 'path'

routes = require './routes/index'
docs = require './routes/docs'

{standardRender} = require './lib/render-helper'

app = express()

# View engine setup
app.engine('hamlc', consolidate['haml-coffee'])

app.set('views', path.join(__dirname, 'views'))
app.set('view engine', 'jade')

# uncomment after placing your favicon in /public
# app.use(favicon(__dirname + '/public/favicon.ico'));
app.use(logger('dev'))
app.use(bodyParser.json())
app.use(bodyParser.urlencoded(extended: false))
app.use(cookieParser())
app.use(express.static(path.join(__dirname, 'public')))

app.use('/', routes)
app.use('/docs', docs)

# catch 404 and forward to error handler
app.use (req, res, next) ->
  err = new Error('Not Found')
  err.status = 404
  next(err)

# error handler

showStackTrace = undefined
showStackTrace = true if app.get('env') is 'development'

app.use (err, req, res, next) ->
  res.status(err.status || 500)
  err.stack = null unless showStackTrace

  standardRender res, 'error',
    message: err.message
    error: err

module.exports = app
