sinon = require('sinon')
assert = require('chai').assert
Promise =  require('bluebird')
request = Promise.promisifyAll(require('request'))

edeClient = require('../lib/index')

suite('Data')


test('#getDataForCountry accepts a country ISO2 code and a variable id
 argument, queries the EDE api, then returns a promise resolving to the array of
 data', (done) ->
  expectedData = [{
    "iso-2": "DE",
    "year": "1961",
    "value": "17257300"
  }, {
    "iso-2": "DE",
    "year": "1962",
    "value": "21166700"
  }]

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve(expectedData)
  )

  edeClient.getDataForCountry('DE', 2217).then( (data) ->
    assert.deepEqual data, expectedData,
      'Expected the matching data to be returned'

    assert.strictEqual requestAsyncStub.callCount, 1,
      'Expected request.getAsync to be called once'

    done()
  ).catch(
    done
  ).finally( ->
    requestAsyncStub.restore()
  )
)



test('#getDataForCountry accepts a country ISO2 code and a variable id
 argument, queries the EDE api, then returns a promise resolving to the array of
 data', (done) ->
  expectedData = [{
    "iso-2": "DE",
    "year": "1961",
    "value": "17257300"
  }, {
    "iso-2": "DE",
    "year": "1962",
    "value": "21166700"
  }]

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve(expectedData)
  )

  edeClient.getDataForCountry('DE', 2217).then( (data) ->
    assert.deepEqual data, expectedData,
      'Expected the matching data to be returned'

    assert.strictEqual requestAsyncStub.callCount, 1,
      'Expected request.getAsync to be called once'

    done()
  ).catch(
    done
  ).finally( ->
    requestAsyncStub.restore()
  )
)


test('#getDataForCountry accepts a country ISO2 code, a variable id and a
 callback, queries the EDE api, then fulfils the callback with the found data',
(done) ->
  expectedData = [{
    "iso-2": "DE",
    "year": "1961",
    "value": "17257300"
  }, {
    "iso-2": "DE",
    "year": "1962",
    "value": "21166700"
  }]

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve(expectedData)
  )

  edeClient.getDataForCountry('DE', 2217, (err, data) ->
    try
      assert.deepEqual data, expectedData,
        'Expected the matching data to be returned'

      assert.strictEqual requestAsyncStub.callCount, 1,
        'Expected request.getAsync to be called once'

      done()
    catch err
      done(err)
    finally
      requestAsyncStub.restore()
  )
)

