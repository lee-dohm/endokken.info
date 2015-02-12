debug = (require 'debug')('router:docs')
express = require 'express'
fs = require 'fs'
path = require 'path'
semver = require 'semver'

latestVersion = (packagePath) ->
  versions = fs.readdirSync(packagePath)
  versions.sort(semver.rcompare)[0]

# Splits a
splitLatestUrl = (url) ->
  match = url.match(/^\/([^/]+)\/latest\/(.*)$/)
  match?[1..-1]

router = express.Router()

# Match URLs of the form: /package/latest/somethingsomething
# Redirects to the latest version of the package
router.get /^\/[^/]+\/latest/, (req, res, next) ->
  debug("received #{req.url}, checking for latest version")
  req.url = "#{req.url}/" if req.url.match(/latest$/)

  match = splitLatestUrl(req.url)
  if match?
    [packageName, rest] = match
    debug("received #{req.url}, finding latest version of #{packageName}")

    packagePath = path.join('docs', packageName)
    latest = latestVersion(packagePath)

    debug("redirecting to version #{latest} of #{packageName}")
    res.redirect(path.join('/docs', packageName, latest, rest))
  else
    err = new Error('Not found')
    err.status = 404
    next(err)

# Match URLs that end in a slash and redirect them to the README at the same path
router.get /\/$/, (req, res) ->
  debug("received #{req.url}, redirecting to README")
  res.redirect('README')

# Match file URLs with no extension and return them as HTML.
router.get /\/[^.]+$/, (req, res, next) ->
  debug("received #{req.url}, rendering as HTML")
  res.set('Content-Type', 'text/html')
  filePath = path.join(path.dirname(__dirname), 'docs', req.url)

  if fs.existsSync(filePath)
    res.sendFile(filePath)
  else
    err = new Error('Not found')
    err.status = 404
    next(err)

router.use express.static('docs')

module.exports = router
