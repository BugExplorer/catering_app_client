define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/dish'
  'views/helpers'
], ($, _, Backbone, JST, ui, DishView, Helpers) ->
  class DishesCollectionView extends Backbone.View
    template: JST['app/scripts/templates/dishes.hbs']

    initialize: (collection, day_id) ->
      @childViews = []
      @collection = collection
      @day_id = day_id

    render: ->
      @$el.html @template(collection: @collection)
      this.renderDishes()
      return this

    renderDishes: ->
      _.each(@collection, (dish) =>
        # Append categories view to the each category
        view = new DishView(dish, @day_id)
        @childViews.push(view)
        @$el.append(view.render().el)
        view.delegateEvents()
      )
