express = require 'express'
router = express.Router()

router.get '/', (req, res, next) ->
  res.render('index.jade', title: 'Express')

module.exports = router
