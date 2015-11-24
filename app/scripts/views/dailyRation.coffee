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
      # console.log(@model.toJSON())
      @$el.html @template(model: @model.toJSON())
      return this

