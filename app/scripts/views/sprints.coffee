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

    panel: new PanelView()

    initialize: (sprint) ->
      @sprint = sprint
      # this.collection.bind("sync", this.render, this)

    render: ->
      @$el.html @template(sprints: @collection.toJSON())

      @panel.$el = @$('#user_panel')
      @panel.render()
      @panel.delegateEvents()
