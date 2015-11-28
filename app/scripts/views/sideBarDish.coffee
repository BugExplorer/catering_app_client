define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'
  'channel'
  'views/helpers'
], ($, _, Backbone, JST, ui, channel, Helpers) ->
  class SideBarDishView extends Backbone.View
    template: JST['app/scripts/templates/sideBarDish.hbs']

    tagName: 'li'
    className: 'side-bar-dish'

    initialize: (dish, day) ->
      @dish  = dish
      @day   = day
      @price = (dish.get('price') * dish.get('quantity')).toFixed(2)

      this.listenTo channel, 'sideBarDish:quantityChanged', @changeQuantity
      this.listenTo channel, 'sideBarDish:leave', @remove

    # Change dish quantity on the sidebar and trigger price validation event
    changeQuantity: (dish) ->
      if @dish == dish
        # Run total price validation
        @price = (dish.get('price') * dish.get('quantity')).toFixed(2)
        # Re-render view
        this.render()

    # Call this when view is being removed
    remove: (view_cid) ->
      if @cid == view_cid
        this.undelegateEvents()
        this.leave()

    render: ->
      @$el.html @template(dish: @dish.toJSON(), price: @price)
      # set li's id
      @$el.attr('id', 'dish-' + @dish.id)
      @$el.attr('view', @cid)
      return this
