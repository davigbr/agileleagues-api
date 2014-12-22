class Domains
    before: (callback) ->
        @gameMasterId = parseInt @segments[0]
        @id = parseInt @segments[1]

        if isNaN @gameMasterId
            @statusCode = 500
            return callback
                message: 'Game Master Id not present in the URL'

        @domain = @model 'Domain'
        $ = @component 'QueryBuilder'
        @cimple = @component 'Cimple',
            model: @domain
            controller: @
            conditions: $.equal 'player_id_owner', @gameMasterId

        callback true

    get: (callback) ->
        @cimple.get @id, callback

    put: (callback) ->
        @cimple.put @id, @payload, callback

    delete: (callback) ->
        @cimple.delete @id, callback

    post: (callback) ->
        data = @payload
        data.player_id_owner = @gameMasterId
        @cimple.post data, callback

module.exports = Domains
