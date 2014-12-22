class Cimple
    constructor: (params) ->
        @controller = params.controller
        @cimpleModel = params.model
        @conditions = params.conditions ? []
        @modelPrimaryKey = params.modelPrimaryKey ? 'id'

    init: ->
        @$ = @component 'QueryBuilder'

    _handleError: (error) ->
        @controller.statusCode = 500
        error.toString = error.toString()
        return error

    get: (id, callback) ->
        if isNaN parseInt id
            @cimpleModel.findAll
                conditions: @conditions
                callback: (err, rows) =>
                    return callback (@_handleError err) if err
                    callback
                        count: rows.length
                        data: rows
        else
            findConditions = @$.and(
                @$.equal @modelPrimaryKey, id
                @conditions
            )
            @cimpleModel.find
                conditions: findConditions
                callback: (err, row) =>
                    return callback (@_handleError err) if err
                    callback
                        data: row


    post: (data = {}, callback) ->
        @cimpleModel.save
            data: data
            callback: (err, result) =>
                return callback (@_handleError err) if err
                @controller.statusCode = 201
                callback
                    data: result

    delete: (id, callback) ->
        if isNaN parseInt id
            return callback @_handleError
                message: 'Id segment must be present for this operation'

        @cimpleModel.removeById id, (err, rows) =>
            return callback (@_handleError err) if err
            callback {}

    put: (id, data = {}, callback) ->
        if isNaN parseInt id
            return callback @_handleError
                message: 'Id segment must be present for this operation'

        data.id = id
        @cimpleModel.save
            data: data
            callback: (err, result) =>
                return callback (@_handleError err) if err
                callback
                    data: result


module.exports = Cimple
