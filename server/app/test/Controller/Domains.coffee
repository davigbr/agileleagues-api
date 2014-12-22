Loader = require('waferpie').Loader
expect = require 'expect.js'

describe 'Domains', ->

    loader = null

    beforeEach ->
        loader = new Loader(require('path').join __dirname, '../../')

    describe 'before', ->

        it 'should return an error if the game master id is not passed', (done) ->
            loader.callController 'Domains', 'GET', {}, (body, info) ->
                expect(body.message).to.be('Game Master Id not present in the URL')
                expect(info.statusCode).to.be 500
                done()

    describe 'post', ->

        it 'should call Cimple.post() and pass the payload as the data', (done) ->
            postCalled = false
            payload = {'this is' : 'payload'}

            loader.mockComponent 'Cimple',
                init: ->
                post: (data, callback) ->
                    expect(data).to.eql payload
                    postCalled = true
                    callback({})

            loader.callController 'Domains', 'POST',
                segments: ['1']
                payload: payload
            , (body, info) ->
                expect(postCalled).to.be true
                done()

    describe 'get', ->

        it 'should call Cimple.get()', (done) ->
            getCalled = false

            loader.mockComponent 'Cimple',
                init: ->
                get: (id, callback) ->
                    getCalled = true
                    callback({})

            loader.callController 'Domains', 'GET',
                segments: ['1']
            , (body, info) ->
                expect(getCalled).to.be true
                done()

    describe 'put', ->

        it 'should call Cimple.put()', (done) ->
            putCalled = false
            payload = {'this is' : 'payload'}

            loader.mockComponent 'Cimple',
                init: ->
                put: (id, data, callback) ->
                    expect(id).to.be 2
                    expect(data).to.eql payload
                    putCalled = true
                    callback({})

            loader.callController 'Domains', 'PUT',
                segments: ['1', '2']
                payload: payload
            , (body, info) ->
                expect(putCalled).to.be true
                done()

    describe 'delete', ->

        it 'should call Cimple.delete()', (done) ->
            deleteCalled = false

            loader.mockComponent 'Cimple',
                init: ->
                delete: (id, callback) ->
                    expect(id).to.be 2
                    deleteCalled = true
                    callback({})

            loader.callController 'Domains', 'DELETE',
                segments: ['1', '2']
            , (body, info) ->
                expect(deleteCalled).to.be true
                done()
