define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'collections/sprints',

  'views/panel'
  'views/helpers'
], ($, _, Backbone, JST, SprintsCollection, PanelView, Helpers) ->
  class SprintsCollectionView extends Backbone.View
    template: JST['app/scripts/templates/sprints.hbs']

    el: '#container'

    initialize: () ->
      # this.collection.bind("reset", this.render, this)

    render: ->
      @collection.fetch().then(() =>
        @$el.html @template(sprints: @collection.toJSON())
        this.renderPanel()
      )

    renderPanel: () ->
      @panel = new PanelView()
      @panel.$el = @$('#user_panel')
      @panel.render()
      @panel.delegateEvents()
