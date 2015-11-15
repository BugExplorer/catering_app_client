define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'collections/sprints',

  'views/helpers'
], ($, _, Backbone, JST, SprintsCollection, Helpers) ->
  class SprintsCollectionView extends Backbone.View
    template: JST['app/scripts/templates/sprints.hbs']

    # el: '#container'

    initialize: () ->
      this.listenTo @collection, "reset", this.render
      @collection.fetch({ reset: true })
      this.collection.bind("reset", this.render, this)

    render: ->
      @$el.html @template(sprints: @collection.toJSON())
      return this
