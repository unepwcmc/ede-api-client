Promise = require('bluebird')
request = Promise.promisifyAll(require('request'))

EDE_BASE_URL = 'http://geodev.grid.unep.ch/api'

exports.getAllVariables = (cb) ->
  new Promise( (resolve, reject) ->
    request.getAsync(
      url: "#{EDE_BASE_URL}/variables"
      json: true
    ).then( (body) ->
      cb(null, body) if cb?
      resolve(body)
    ).catch( (err) ->
      cb(err) if cb?
      reject(err)
    )
  )

exports.getVariable = (id, cb) ->
  new Promise( (resolve, reject) ->
    request.getAsync(
      url: "#{EDE_BASE_URL}/variables/#{id}"
      json: true
    ).then( (body) ->
      # the [0] is due to the fact that the EDE api returns an array, even
      # with a single element in it
      cb(null, body[0]) if cb?
      resolve(body[0])
    ).catch( (err) ->
      cb(err) if cb?
      reject(err)
    )
  )

exports.findVariables = (query, cb) ->
  new Promise( (resolve, reject) ->
    request.getAsync(
      url: "#{EDE_BASE_URL}/variables/find/#{query}"
      json: true
    ).then( (body) ->
      cb(null, body) if cb?
      resolve(body)
    ).catch( (err) ->
      cb(err) if cb?
      reject(err)
    )
  )

exports.getDataForCountry = (countryIso2, variableId, cb) ->
  new Promise( (resolve, reject) ->
    request.getAsync(
      url: "#{EDE_BASE_URL}/countries/#{countryIso2}/variables/#{variableId}"
      json: true
    ).then( (body) ->
      cb(null, body) if cb?
      resolve(body)
    ).catch( (err) ->
      cb(err) if cb?
      reject(err)
    )
  )

module.exports = exports
