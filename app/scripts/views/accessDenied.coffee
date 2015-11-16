define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/helpers'
  'channel'
], ($, _, Backbone, JST, Helpers, channel) ->
  class AccessDeniedView extends Backbone.View
    template: JST['app/scripts/templates/accessDenied.hbs']

    render: ->
      @$el.html @template()
      return this
