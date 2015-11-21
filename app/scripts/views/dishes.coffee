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

    initialize: (collection, day_number) ->
      @childViews = []
      @collection = collection
      @day_number = day_number

    render: ->
      @$el.html @template(collection: @collection)
      this.renderDishes()
      return this

    renderDishes: ->
      _.each(@collection, (dish) =>
        # Append categories view to the each category
        view = new DishView(dish, @day_number)
        @childViews.push(view)
        @$el.append(view.render().el)
        view.delegateEvents()
      )
