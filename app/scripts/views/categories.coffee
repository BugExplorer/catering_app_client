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

    initialize: (collection, day_id) ->
      @collection = collection
      @day_id = day_id

    render: ->
      @$el.html @template(categories: @collection)
      this.renderDishesCollection()
      return this

    renderDishesCollection: ->
      _.each(@collection, (category) =>
        # Append categories view to the each category
        view = new DishesCollectionView(category.dishes, @day_id)
        @$("#" + category.id).html(view.render().el)
        view.delegateEvents()
      )
