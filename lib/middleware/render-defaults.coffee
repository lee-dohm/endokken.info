_ = require 'underscore'

defaults = (defaultLocals) ->
  middleware = (req, res, next) ->
    res.oldRender = res.render
    res.render = (layout, locals, callback) ->
      locals = _.extend(defaultLocals, locals)
      res.oldRender(layout, locals, callback)

    next()

module.exports = defaults
