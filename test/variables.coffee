sinon = require('sinon')
assert = require('chai').assert

edeClient = require('../index')

suite('Variables')

test('#getAllVariables calls EDE API and returns an array of variables', (done) ->
  edeClient.getAllVariables().then( (variables) ->
    assert.deepEqual variables, expectedVariables,
      "Expected all variables to be returned"
  )

)
