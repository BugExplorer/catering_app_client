define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/dishes'
  'views/helpers'
], ($, _, Backbone, JST, ui, DishesCollectionView, Helpers) ->
  class CategoriesCollectionView extends Backbone.View
    template: JST['app/scripts/templates/categories.hbs']

    tagName: 'div'
    className: 'categories'

    initialize: (collection, dayId) ->
      @childViews = []
      @collection = collection
      @dayId      = dayId

    render: ->
      @$el.html @template(categories: @collection)
      this.renderDishesCollection()
      return this

    renderDishesCollection: ->
      _.each(@collection, (category) =>
        # Append categories view to the each category
        view = new DishesCollectionView(category.dishes, @dayId)
        @childViews.push(view)
        @$('#category-' + category.id).append(view.render().el)
        view.delegateEvents()
      )
