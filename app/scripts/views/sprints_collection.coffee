define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'collections/sprints',

  'views/panel'
], ($, _, Backbone, JST, PanelView, SprintsCollection) ->
  class SprintsCollectionView extends Backbone.View
    template: JST['app/scripts/templates/sprints_collection.hbs']

    el: '#container'

    panel: new PanelView()

    events: {}

    initialize: () ->
      # @listenTo @model, 'change', @render

    render: () =>
      console.log()
      @$el.html @template(@collection.toJSON())

      @panel.$el = @$('#user_panel')
      @panel.render()
      @panel.delegateEvents()




