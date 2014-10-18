class Domain
    constructor: ->
        @table = 'domain'

    init: ->
        @mysql = @component('DataSource.MySQL')
        @q = @component('QueryBuilder')

    findAll: (callback) ->
        sql = @q.selectStarFrom(@table).build()
        @mysql.query sql, [], (err, rows) =>
            callback err, rows

    findById: (id, callback) ->
        sql = @q
            .selectStarFrom(@table)
            .where(@q.equal('id', id))
            .build()
        @mysql.query sql, [], callback

    remove: (id, callback) ->
        sql = @q.deleteFrom(@table).where($q.equal 'id', id).build()
        @mysql.query sql, [], callback

    removeAll: (callback) ->
        sql = @q.deleteFrom(@table).build()
        @mysql.query sql, [], callback

    create: (data, callback) ->
        data[i] = @q.escape(data[i]) for i of data
        sql = @q.insertInto(@table).set(data).build()
        @mysql.query sql, [], (err, rows) =>
            return callback err if err
            callback rows

    exists: (id, callback) ->
        sql = @q.select('id').from(@table).where($q.equal 'id', id).build()
        @mysql.query sql, [], (err, results) =>
            return callback err if err
            callback results.length > 0

module.exports = Domain
