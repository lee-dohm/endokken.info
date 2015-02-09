express = require 'express'
router = express.Router()

router.get '/', (req, res, next) ->
  res.render('index', title: 'endokken.info')

module.exports = router
