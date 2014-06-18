Promise = require('bluebird')
request = Promise.promisifyAll(require('request'))

EDE_BASE_URL = 'http://geodev.grid.unep.ch/api'

callEdeApi = (path, cb) ->
  new Promise( (resolve, reject) ->
    request.getAsync(
      url: "#{EDE_BASE_URL}#{path}"
      json: true
    ).then( (body) ->
      cb(null, body) if cb?
      resolve(body)
    ).catch( (err) ->
      cb(err) if cb?
      reject(err)
    )
  )

getFirstAndTap = (next) ->
  (err, variables) -> next(err, variables?[0])

exports.getVariable = (id, cb) ->
  cb = getFirstAndTap(cb) if cb?
  callEdeApi("variables/#{id}", cb).get(0)

exports.getAllVariables = (cb) ->
  callEdeApi('variables', cb)

exports.findVariables = (query, cb) ->
  callEdeApi("variables/find/#{query}", cb)

exports.getDataForCountry = (countryIso2, variableId, cb) ->
  callEdeApi("countries/#{countryIso2}/variables/#{variableId}", cb)

module.exports = exports
