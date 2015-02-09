_ = require 'underscore'

utilities = require './utilities'

module.exports =
  standardRender: (res, template, opts) ->
    options = _.extend(opts, helpers: utilities)
    res.render(template, options)
