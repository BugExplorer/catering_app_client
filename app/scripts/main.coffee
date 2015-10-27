#/*global require*/
'use strict'

require.config
  shim: {
    bootstrap:
      deps: ['jquery'],
      exports: 'jquery'
    handlebars:
      exports: 'Handlebars'
  }
  paths:
    jquery: '../bower_components/jquery/dist/jquery'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/bootstrap-sass-official/assets/javascripts/bootstrap'
    handlebars: '../bower_components/handlebars/handlebars'

require [
  'backbone'
], (Backbone) ->
  Backbone.history.start()
