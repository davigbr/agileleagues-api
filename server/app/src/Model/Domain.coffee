class Domain
    constructor: ->
        @table = 'domain'

    init: ->
        @validate =
            id: {}
            name:
                maxLength:
                    params: [30]
                    message: 'Must contain less than 30 chars'
            color:
                regex:
                    params: [/\#[a-fA-F0-9]{6}/]
                    message: 'Must be a valid hex color string (ex: #ffdd00)'
            description:
                maxLength:
                    params: [200]
                    message: 'Must contain less than 200 chars'
            icon:
                maxLength:
                    params: [50]
                    message: 'Must contain less than 50 chars'
            created:
                datetime:
                    message: 'Must be a datetime'
            inactive:
                isBoolean:
                    message: 'Must be a boolean'
            player_id_owner:
                isInteger:
                    message: 'Must be an integer'

        @ninja = @component 'Database.MyNinja',
            validate: @validate
            table: 'domain'
        @ninja.bind @


module.exports = Domain
