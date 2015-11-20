define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/helpers'
], ($, _, Backbone, JST, ui, Helpers) ->
  class SideBarDishView extends Backbone.View
    template: JST['app/scripts/templates/sideBarDish.hbs']

    tagName: "li"
    className: "side-bar-dish"

    render: ->
      @$el.html @template(dish: @model)
      # set li's id
      @$el.attr('id', @model.id)
      return this
