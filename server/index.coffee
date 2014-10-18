WaferPie = require 'waferpie'
server = new WaferPie
server.configure 'config.yml'
server.setUp 'app'
server.start('localhost', 20000)