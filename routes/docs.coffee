debug = (require 'debug')('router:docs')
express = require 'express'
fs = require 'fs'
path = require 'path'
semver = require 'semver'

latestVersion = (packagePath) ->
  versions = fs.readdirSync(packagePath)
  versions.sort(semver.rcompare)[0]

splitLatestUrl = (url) ->
  url.match(/^\/([^/]+)\/latest\/(.*)$/)

router = express.Router()

router.get /^\/[^/]+\/latest/, (req, res, next) ->
  debug("received #{req.url}, checking for latest version")
  req.url = "#{req.url}/" if req.url.match(/latest$/)

  match = splitLatestUrl(req.url)
  if match?
    [..., packageName, rest] = match
    debug("received #{req.url}, finding latest version of #{packageName}")

    packagePath = path.join('docs', packageName)
    latest = latestVersion(packagePath)

    debug("redirecting to version #{latest} of #{packageName}")
    res.redirect(path.join('/docs', packageName, latest, rest))
  else
    err = new Error('Not found')
    err.status = 404
    next(err)

router.get /\/$/, (req, res) ->
  debug("received #{req.url}, redirecting to README")
  res.redirect('README')

router.get /\/[^.]+$/, (req, res) ->
  debug("received #{req.url}, rendering as HTML")
  res.set('Content-Type', 'text/html')
  url = fs.realpathSync(path.join('docs', req.url))
  res.sendFile(url)

router.use express.static('docs')

module.exports = router
