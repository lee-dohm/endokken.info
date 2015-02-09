express = require 'express'
fs = require 'fs'

router = express.Router()

router.get /\/.*\/[^.]+$/, (request, response) ->
  response.set('Content-Type', 'text/html')
  path = "docs#{request.url}"
  response.send(new Buffer(fs.readFileSync(path)))

router.use express.static("#{__dirname}/../docs")

module.exports = router
