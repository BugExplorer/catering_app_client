define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/categories'
  'views/helpers'
], ($, _, Backbone, JST, ui, CategoriesCollectionView, Helpers) ->
  class DaysCollectionView extends Backbone.View
    template: JST['app/scripts/templates/days.hbs']

    initialize: () ->
      this.listenTo @collection, "reset", this.render

    render: ->
      @$el.html @template(dailyMenus: @collection.toJSON())
      this.renderCategories()
      # Use Jquery-UI to create tabbed form
      $("#tabs").tabs()
      return this

    renderCategories: ->
      @collection.each((day) ->
        # Append categories view to the each category
        view = new CategoriesCollectionView(day.get("categories"), day.id)
        $("#tabs-" + day.id).html(view.render().el)
        view.delegateEvents()
      )
