define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
], ($, _, Backbone, JST) ->
  class DishesCollectionView extends Backbone.View
    template: JST['app/scripts/templates/dishes.hbs']

    initialize: (dishes) ->
      @dishes = dishes
      # @dishes.bind("sync", this.render, this)

    render: ->
      @$el.html @template(dishes: @dishes.toJSON())
