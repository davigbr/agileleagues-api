'use strict';

module.exports = function (grunt) {

    // Load grunt tasks automatically
    require('load-grunt-tasks')(grunt);

    var jslintCommand = "jslint `find app/src app/test -regex '.*\\.js$' -type f | tr '\\n' ' '` > .lint.out || (cat .lint.out && exit 1)";

    // Define the configuration for all the tasks
    grunt.initConfig({
        exec: {
            'jslint' : jslintCommand,
            'test': 'mocha app/test --recursive -R progress'
        },

        // Watches files for changes and runs tasks based on the changed files
        watch: {
            src: {
                files: ['app/src/**/*.js', 'app/test/**/*.js'],
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
