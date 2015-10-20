module.exports = (grunt) ->
  grunt.loadNpmTasks 'grunt-mocha-test'
  grunt.initConfig
    coffee:
      compile:
        files:
          'lib/vtree-maker.js': ['src/vtree-maker.coffee']
          'lib/reactive-builder.js': ['src/reactive-builder.coffee']
    mochaTest:
      test:
        options:
          reporter: 'spec'
          require: 'coffee-script/register'
          quiet: false
        src: ['test/*.coffee']
  grunt.registerTask 'default', ['coffee', 'mochaTest']
  grunt.registerTask 'test', 'mochaTest'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
