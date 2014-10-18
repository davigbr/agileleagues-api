/*jslint devel: true, node: true, indent: 4 */
'use strict';
function ExceptionsController() {
    this.name = 'Exceptions';
}

ExceptionsController.prototype.onApplicationNotFound = function (callback) {
    this.statusCode = 404;
    callback({
        'code' : 404,
        'error' : 'ApplicationNotFound'
    });
};

ExceptionsController.prototype.onControllerNotFound = function (callback) {
    this.statusCode = 404;
    callback({
        'code' : 404,
        'error' : 'ControllerNotFound'
    });
};

ExceptionsController.prototype.onMethodNotFound = function (callback) {
    this.statusCode = 404;
    callback({
        'code' : 404,
        'error' : 'MethodNotFound'
    });
};

ExceptionsController.prototype.onForbidden = function (callback) {
    this.statusCode = 403;
    callback({
        'code' : 403,
        'error' : 'Forbidden'
    });
};

ExceptionsController.prototype.onTimeout = function (callback) {
    this.statusCode = 504;
    callback({
        'code' : 504,
        'error' : 'Timeout'
    });
};

ExceptionsController.prototype.onGeneral = function (callback, exception) {
    this.statusCode = 500;
    if (exception.stack !== undefined) {
        console.log(exception.stack);
    }
    callback({
        'name' : 'General',
        'cause' : exception
    });
};

module.exports = ExceptionsController;
