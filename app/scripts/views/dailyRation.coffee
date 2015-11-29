define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'channel'
], ($, _, Backbone, JST, channel) ->
  class DailyRationView extends Backbone.View
    template: JST['app/scripts/templates/dailyRation.hbs']

    tagName: 'p'

    render: ->
      @$el.html @template(model: @model)
      return this
