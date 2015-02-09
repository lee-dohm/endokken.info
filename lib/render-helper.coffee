_ = require 'underscore'

utilities = require './utilities'

module.exports =
  standardRender: (res, template, opts) ->
    options = _.extend(opts, utilities: utilities)
    res.render(template, options)
