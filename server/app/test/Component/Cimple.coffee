Loader = require('waferpie').Loader
expect = require 'expect.js'

describe 'Cimple', ->

    loader = null
    $ = null
    globalConditions = null

    beforeEach ->
        loader = new Loader(require('path').join __dirname, '../../')
        $ = loader.createComponent 'QueryBuilder'
        globalConditions = $.equal('x', 1)

    describe 'get', ->
        it 'should output all records if no id is passed', (done) ->
            data = [
                {id: 1, name: 'Record 1'}
                {id: 2, name: 'Record 2'}
            ]
            modelMock =
                findAll: (params) ->
                    expect(params.conditions).to.be.ok()
                    params.callback null, data

            instance = loader.createComponent 'Cimple',
                conditions: globalConditions
                controller: {}
                model: modelMock

            instance.init()

            instance.get undefined, (output) ->
                expect(output.count).to.be 2
                expect(output.data).to.be data
                done()

        it 'should output a single record if the id is passed', (done) ->
            data = id: 2, name: 'Record 2'
            modelMock =
                find: (params) ->
                    expectedConditions =
                        $.and(
                            $.equal('id', 2),
                            globalConditions
                        )
                    expect(params.conditions).to.eql expectedConditions
                    params.callback null, data

            instance = loader.createComponent 'Cimple',
                conditions: globalConditions
                controller: {}
                model: modelMock

            instance.init()

            instance.get 2, (output) ->
                expect(output.data).to.be data
                done()

    describe 'post', ->

        it 'should save the data and return it', (done) ->
            data = name: 'Record'
            controller = {}
            modelMock =
                save: (params) ->
                    data.id = 1
                    params.callback null, data
            instance = loader.createComponent 'Cimple',
                conditions: globalConditions
                controller: controller
                model: modelMock

            instance.init()

            instance.post data, (output) ->
                expect(output.data).to.be data
                expect(controller.statusCode).to.be 201
                done()

    describe 'delete', ->

        it 'should output an error message if the id is not present', (done) ->
            controller = {}
            instance = loader.createComponent 'Cimple',
                conditions: globalConditions
                controller: controller
                model: {}
            instance.init()
            instance.delete null, (output) ->
                expect(controller.statusCode).to.be 500
                expect(output.message).to.be.ok()
                done()

        it 'should remove the record by id and return nothing', (done) ->
            modelMock =
                removeById: (id, callback) ->
                    expect(id).to.be 1
                    callback()

            instance = loader.createComponent 'Cimple',
                conditions: globalConditions
                controller: {}
                model: modelMock
            instance.init()
            instance.delete 1, (output) ->
                expect(output).to.eql {}
                done()

    describe 'put', ->

        it 'should output an error message if the id is present', (done) ->
            controller = {}
            instance = loader.createComponent 'Cimple',
                conditions: globalConditions
                controller: controller
                model: {}
            instance.init()
            instance.put null, {}, (output) ->
                expect(controller.statusCode).to.be 500
                expect(output.message).to.be.ok()
                done()

        it 'should save the data and return it', (done) ->
            data = name: 'Record'
            controller = {}
            modelMock =
                save: (params) ->
                    params.callback null, params.data
            instance = loader.createComponent 'Cimple',
                conditions: globalConditions
                controller: controller
                model: modelMock

            instance.init()

            instance.put 1, data, (output) ->
                expect(output.data.name).to.be 'Record'
                expect(output.data.id).to.be 1
                done()
