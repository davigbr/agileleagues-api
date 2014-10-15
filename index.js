var WaferPie = require('waferpie');
var server = new WaferPie();
server.configure('config.json');
server.setUp('app');
server.start('localhost', 20000);
