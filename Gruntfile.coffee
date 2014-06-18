module.exports = (grunt) ->
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/index.js': ['src/*.coffee']
    mochaTest:
      options:
        colors: true
        compilers: 'coffee:coffee-script/register'
        ui: 'qunit'
        reporter: 'spec'
        recursive: true
      src: ['test/*.coffee']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.registerTask 'default', ['coffee', 'mochaTest']

