define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/helpers'
  'channel'
], ($, _, Backbone, JST, Helpers, channel) ->
  class SprintView extends Backbone.View
    template: JST['app/scripts/templates/sprint.hbs']

    initialize: () ->
      this.listenTo @model, 'sync', this.render
      this.listenTo @model, 'error', this.triggerAccessDenied
      @model.fetch()

    triggerAccessDenied: -> channel.trigger 'accessDenied'

    render: ->
      @$el.html @template(sprint: @model.toJSON())
      return this
