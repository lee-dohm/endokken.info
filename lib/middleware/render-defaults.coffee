_ = require 'underscore'

# Public: Adds the default locals to every call to `res.render`.
#
# Replaces the `res.render` function with a new version that extends the default locals with the
# passed in locals, then chains to the old render function.
#
# ## Examples
#
# Adds the local `foo` with the value `bar` to every render call:
#
# ```coffee
# defaults = require './lib/middleware/render-defaults'
#
# app.use(defaults(foo: 'bar'))
# ```
#
# * `defaultLocals` {Object} of locals to provide.
#
# Returns a middleware {Function} suitable for `app.use`.
defaults = (defaultLocals) ->
  (req, res, next) ->
    res.oldRender = res.render
    res.render = (layout, locals, callback) ->
      locals = _.extend(defaultLocals, locals)
      res.oldRender(layout, locals, callback)

    next()

module.exports = defaults
