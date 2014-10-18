'use strict';

module.exports = function (grunt) {

    // Load grunt tasks automatically
    require('load-grunt-tasks')(grunt);

    // Define the configuration for all the tasks
    grunt.initConfig({
        exec: {
            'clean' : 'rm -rf dist ; mkdir dist',
            'build' :
                '(cp -r server/* dist/ && find dist -type f ! -iname "*.yml" -delete) ; ' +
                'yaml2json dist/ --recursive --pretty --save ; ' +
                'find dist/ -name "*.yml" -type f -delete ; ' +
                'coffee --compile --output dist server'
            ,
            'lint' : 'coffeelint server',
            'test': 'mocha server/app/test --compilers coffee:coffee-script/register --recursive -R progress'
        },

        // Watches files for changes and runs tasks based on the changed files
        watch: {
            src: {
                files: ['server/**'],
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
    grunt.registerTask('lint', 'lint', 'exec:lint');
    grunt.registerTask('test', 'Testing...', 'exec:test');
    grunt.registerTask('build', 'Building...', 'exec:build');
    grunt.registerTask('clean', 'Building...', 'exec:clean');

};
