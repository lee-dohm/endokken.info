express = require 'express'
fs = require 'fs'
path = require 'path'

router = express.Router()

router.get /\/$/, (request, response) ->
  response.redirect('README')

router.get /\/[^.]+$/, (request, response) ->
  response.set('Content-Type', 'text/html')
  url = fs.realpathSync(path.join('docs', request.url))
  response.sendFile(url)

router.use express.static("#{__dirname}/../docs")

module.exports = router
