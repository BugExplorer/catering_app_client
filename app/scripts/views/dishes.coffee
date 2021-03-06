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
    tagName: 'div'
    className: 'dishes row'

    initialize: (collection, dayId) ->
      @childViews = []
      @dayId      = dayId
      @collection = collection

    render: ->
      @$el.html
      this.renderDishes()
      return this

    renderDishes: ->
      _.each(@collection, (dish) =>
        # Append categories view to the each category
        view = new DishView(dish, @dayId)
        @childViews.push(view)
        @$el.append(view.render().el)
        view.delegateEvents()
      )
