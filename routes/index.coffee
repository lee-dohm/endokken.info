express = require 'express'
utilities = require '../lib/utilities'

router = express.Router()

router.get '/', (req, res, next) ->
  res.render('index', title: 'endokken.info', utilities: utilities)

module.exports = router
