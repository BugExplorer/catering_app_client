define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'channel'
], ($, _, Backbone, JST, channel) ->
  class OrderView extends Backbone.View
    template: JST['app/scripts/templates/order.hbs']

    # className: 'navbar'

    initialize: ->
      # @listenTo channel, 'user:loggedIn', @render

    render: ->
      @$el.html @template()
      return this
