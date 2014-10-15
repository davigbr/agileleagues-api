/*globals describe, beforeEach, it*/
'use strict';

var Testing = require('waferpie').Testing;
var expect = require('expect.js');

describe('Domains.js', function () {

    var testing;

    beforeEach(function () {
        testing = new Testing(require('path').join(__dirname, '../../'));
    });

    describe('get', function () {

        it('should return an empty object', function (done) {
            try {
                testing.callController('Domains', 'get', {}, function (response) {
                    expect(response).to.be.an('object');
                    done();
                });
            } catch (e) {
                console.log(e);
            }

        });
    });
});