Testing = require('waferpie').Testing
expect = require 'expect.js'
path = require 'path'

describe 'Domains', ->

    testing = null

    beforeEach ->
        testing = new Testing(path.join __dirname, '../../../')

    describe 'get', ->

        it 'should return the hello world json', ->
