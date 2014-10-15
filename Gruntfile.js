'use strict';

module.exports = function (grunt) {

    // Load grunt tasks automatically
    require('load-grunt-tasks')(grunt);

    var jslintCommand = 'node node_modules/waferpie/node_modules/jslint/bin/jslint.js --node --vars --devel --nomen --stupid --indent 4 --maxlen 2048 erpconnect/src/*.js erpconnect/test/*.js erpconnect/src/**/*.js erpconnect/test/**/*.js pswn/src/*.js pswn/test/*.js pswn/src/**/*.js pswn/test/**/*.js parking/src/*.js parking/test/*.js parking/src/**/*.js parking/test/**/*.js > lint.out || (cat lint.out && exit 1)';

    // Define the configuration for all the tasks
    grunt.initConfig({
        exec: {
            'jslint' : jslintCommand,
            'test': 'mocha erpconnect/test/** -R progress && mocha pswn/test/** -R progress && mocha parking/test/** -R progress'
        },

        // Watches files for changes and runs tasks based on the changed files
        watch: {
            src: {
                files: ['erpconnect/src/**/*.js', 'erpconnect/test/**/*.js', 'pswn/src/**/*.js', 'pswn/test/**/*.js', 'parking/src/**/*.js', 'parking/test/**/*.js'],
                tasks: ['test']
            },
            gruntfile: {
                files: ['Gruntfile.js']
            },
        }
    });

    grunt.registerTask('default', 'Watch files', function () {
        grunt.task.run([
            'watch'
        ]);
    });
    grunt.registerTask('lint', 'JSLint', 'exec:jslint');
    grunt.registerTask('test', 'Testing...', 'exec');

};
