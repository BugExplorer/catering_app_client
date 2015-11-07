define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'collections/sprints',

  'views/panel'
], ($, _, Backbone, JST, SprintsCollection, PanelView) ->
  class SprintsCollectionView extends Backbone.View
    template: JST['app/scripts/templates/sprints.hbs']

    el: '#container'

    panel: new PanelView()

    events: {}

    initialize: () ->
      this.collection.bind("sync", this.render, this)

    render: () =>
      @$el.html @template(sprints: @collection.toJSON())

      @panel.$el = @$('#user_panel')
      @panel.render()
      @panel.delegateEvents()




