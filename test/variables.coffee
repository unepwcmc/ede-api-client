sinon = require('sinon')
assert = require('chai').assert
Promise =  require('bluebird')
request = Promise.promisifyAll(require('request'))

edeClient = require('../src/index')

suite('Variables')


test('#getAllVariables calls EDE API and returns a promise resolving to an
 array of variables', (done) ->
  expectedVariables = [
    {
      id: "1672",
      name: "Agricultural Area",
      name_short: null,
      time_period: "1961-2011"
    }, {
      id: "2217",
      name: "Agricultural Area Certified Organic",
      name_short: null,
      time_period: "2004-2011"
    }, {
      id: "2134",
      name: "Agricultural Area Irrigated",
      name_short: null,
      time_period: "2001-2011"
    }
  ]

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve(expectedVariables)
  )

  edeClient.getAllVariables().then( (variables) ->
    assert.deepEqual variables, expectedVariables,
      "Expected all variables to be returned"

    done()
  ).catch(
    done
  ).finally( ->
    requestAsyncStub.restore()
  )
)


test('#getAllVariables called with a callback fulfils the callback with an
 array of variables', (done) ->
  expectedVariables = [
    {
      id: "1672",
      name: "Agricultural Area",
      name_short: null,
      time_period: "1961-2011"
    }, {
      id: "2217",
      name: "Agricultural Area Certified Organic",
      name_short: null,
      time_period: "2004-2011"
    }, {
      id: "2134",
      name: "Agricultural Area Irrigated",
      name_short: null,
      time_period: "2001-2011"
    }
  ]

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve(expectedVariables)
  )

  edeClient.getAllVariables( (err, variables) ->
    assert.isNull err, "Expected the error to be null"
    assert.deepEqual variables, expectedVariables,
      "Expected all variables to be passed to the cb"

    requestAsyncStub.restore()
    done()
  )
)


test('#findVariables accepts a query argument, and queries the EDE api, then
 returns a promise resolving to an array of matching variables', (done) ->
  expectedVariables = [
    {
      id: "2217",
      name: "Agricultural Area Certified Organic",
      name_short: null,
      time_period: "2004-2011"
    }
  ]

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve(expectedVariables)
  )

  edeClient.findVariables('Certified').then( (variables) ->
    assert.deepEqual variables, expectedVariables,
      'Expected the matching variables to be returned'

    assert.strictEqual requestAsyncStub.callCount, 1,
      'Expected request.getAsync to be called once'

    done()
  ).catch(
    done
  ).finally( ->
    requestAsyncStub.restore()
  )
)


test('#findVariables accepts a query and a callback, and queries the EDE api, then
 fulfils the callback with an array of matching variables', (done) ->
  expectedVariables = [
    {
      id: "2217",
      name: "Agricultural Area Certified Organic",
      name_short: null,
      time_period: "2004-2011"
    }
  ]

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve(expectedVariables)
  )

  edeClient.findVariables('Certified', (err, variables) ->
    try
      assert.isNull err, 'Expected the returned error to be null'
      assert.deepEqual variables, expectedVariables,
        'Expected the matching variables to be returned'

      assert.strictEqual requestAsyncStub.callCount, 1,
        'Expected request.getAsync to be called once'

      done()
    catch err
      done(err)
    finally
      requestAsyncStub.restore()
  )
)


test('#getVariable accepts an id argument, and queries the EDE api, then
 returns a promise resolving to the matching variable', (done) ->
  expectedVariable = {
    id: "2217",
    name: "Agricultural Area Certified Organic",
    name_short: null,
    time_period: "2004-2011"
  }

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve([expectedVariable])
  )

  edeClient.getVariable(2217).then( (variable) ->
    assert.deepEqual variable, expectedVariable,
      'Expected the matching variable to be returned'

    assert.strictEqual requestAsyncStub.callCount, 1,
      'Expected request.getAsync to be called once'

    done()
  ).catch(
    done
  ).finally( ->
    requestAsyncStub.restore()
  )
)


test('#getVariable accepts an id argument and a callback, and queries the EDE
 api, then fulfils the callback with the matching variable', (done) ->
  expectedVariable = {
    id: "2217",
    name: "Agricultural Area Certified Organic",
    name_short: null,
    time_period: "2004-2011"
  }

  requestAsyncStub = sinon.stub(request, 'getAsync', (opts) ->
    Promise.resolve([expectedVariable])
  )

  edeClient.getVariable(2217, (err, variable) ->
    try
      assert.deepEqual variable, expectedVariable,
        'Expected the matching variable to be returned'

      assert.strictEqual requestAsyncStub.callCount, 1,
        'Expected request.getAsync to be called once'

      done()
    catch err
      done(err)
    finally
      requestAsyncStub.restore()
  )
)
