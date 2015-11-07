define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'models/sprint',

  'views/panel'
  'views/helpers'
], ($, _, Backbone, JST, SprintModel, PanelView, Helpers) ->
  class SprintView extends Backbone.View
    template: JST['app/scripts/templates/sprints.hbs']

    el: '#container'

    panel: new PanelView()

    initialize: () ->
      # this.collection.bind("sync", this.render, this)

    render: () =>
      @$el.html @template()

      @panel.$el = @$('#user_panel')
      @panel.render()
      @panel.delegateEvents()
