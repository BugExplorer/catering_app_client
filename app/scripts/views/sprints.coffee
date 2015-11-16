define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'collections/sprints',

  'views/helpers'

  'channel'
], ($, _, Backbone, JST, SprintsCollection, Helpers, channel) ->
  class SprintsCollectionView extends Backbone.View
    template: JST['app/scripts/templates/sprints.hbs']

    # el: '#container'

    initialize: ->
      this.listenTo @collection, "reset", this.render
      this.listenTo @collection, "error", this.triggerAccessDenied
      @collection.fetch({ reset: true })
      this.collection.bind("reset", this.render, this)

    triggerAccessDenied: -> channel.trigger 'accessDenied'

    render: ->
      @$el.html @template(sprints: @collection.toJSON())
      return this
