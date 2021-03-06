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
    jquery_ui: '../bower_components/jquery-ui/jquery-ui'
    backbone: '../bower_components/backbone/backbone'
    underscore: '../bower_components/lodash/dist/lodash'
    bootstrap: '../bower_components/bootstrap-sass-official/assets/javascripts/bootstrap'
    handlebars: '../bower_components/handlebars/handlebars'
    router: 'routes/catering'

require [
  'backbone',
  'app'
], (Backbone, Application) ->
  # Fixes views memory leak
  Backbone.View.prototype.leave = ->
    @$el.empty().off()
    this.stopListening()
    if @childViews
      @childViews.forEach (v) -> v.leave()
    return this

  Application.initialize()
