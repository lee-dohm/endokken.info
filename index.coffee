fs = require 'fs'
express = require 'express'

app = express()

app.set('port', (process.env.PORT or 5000))

app.use(express.static("#{__dirname}/public"))
app.get /\/docs\/.*\/[^.]+$/, (request, response) ->
  response.set('Content-Type', 'text/html')
  path = request.url.slice(1)
  response.send(new Buffer(fs.readFileSync(path)))

app.use('/docs', express.static("#{__dirname}/docs"))

app.get '/', (request, response) ->
  response.send('Hello World!')

app.listen app.get('port'), ->
  console.log("Node app is running at localhost: #{app.get('port')}")
