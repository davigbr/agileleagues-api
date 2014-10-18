# GET /domains/:gameMasterId/
# GET /domains/:gameMasterId/:id

# PUT /domains/:gameMasterId/
# PUT /domains/:gameMasterId/:id

# DELETE /domains/:gameMasterId/
# DELETE /domains/:gameMasterId/:id


class Domains
    handleError: (error) ->
        @statusCode = 500
        console.log error.toString()
        return error

    before: (callback) ->
        @domain = @model 'Domain'
        callback true

    get: (callback) ->
        id = @segments[0]

        if id
            @domain.findById id, (err, rows) =>
                if err
                    @statusCode = 500
                    return callback @handleError err

                callback rows
        else
            @domain.findAll (err, rows) =>
                if err
                    @statusCode = 500
                    callback @handleError err
                else
                    callback rows

    put: (callback) ->
        id = @segments[0]
        if id
            callback {}
        else
            @domain.create @payload, (err, data) =>
                if err
                    @statusCode = 500
                    return callback @handleError err

                @statusCode = 201
                callback data

    delete: (callback) ->
        callback {}

    post: (callback) ->
        callback {}

module.exports = Domains
