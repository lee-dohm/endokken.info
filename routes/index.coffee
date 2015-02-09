express = require 'express'
{standardRender} = require '../lib/render-helper'

router = express.Router()

router.get '/', (req, res, next) ->
  standardRender(res, 'index', title: 'endokken.info')

module.exports = router
