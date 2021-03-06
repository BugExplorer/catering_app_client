define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/categories'
  'views/helpers'
], ($, _, Backbone, JST, ui, CategoriesCollectionView, Helpers) ->
  class FormDaysCollectionView extends Backbone.View
    template: JST['app/scripts/templates/days.hbs']

    initialize: () ->
      @childViews = []
      this.listenTo @collection, 'reset', this.render

    render: ->
      @$el.html @template(dailyMenus: @collection.toJSON())
      this.renderCategories()
      # Use Jquery-UI to create tabbed form
      $('#tabs').tabs()
      return this

    renderCategories: ->
      @collection.each((day) =>
        # Append categories view to the each category
        view = new CategoriesCollectionView(day.get('categories'), day.id)
        @childViews.push(view)
        $('#tabs-' + day.id).append(view.render().el)
        view.delegateEvents()
      )
