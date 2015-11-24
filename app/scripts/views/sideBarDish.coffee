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

    initialize: (dish, day_id, day, quantity) ->
      @model   = dish
      @day_id  = day_id
      @day     = day
      @price   = (parseFloat(dish.price) * parseFloat(quantity)).toFixed(2)
      @quantity = quantity

      this.listenTo channel, 'sideBarDish:quantityChanged', @changeQuantity
      this.listenTo channel, 'sideBarDish:leave', @remove

    # Change dish quantity on the sidebar and trigger price validation event
    changeQuantity: (dish, day_id, quantity) ->
      if @model == dish && @day_id == day_id
        # Run total price validation
        price = (@model.price * quantity).toFixed(2)
        channel.trigger('sideBarDish:priceChanged', price, @price, day_id)
        @price = price
        @quantity = quantity

        # Re-render view
        this.render()

    # Call this when view is being removed
    remove: (view_cid) ->
      if @cid == view_cid
        this.undelegateEvents()
        this.leave()

    render: ->
      @$el.html @template(dish: @model, price: @price, quantity: @quantity)
      # set li's id
      @$el.attr('id', 'dish-' + @model.id)
      @$el.attr('view', @cid)
      return this
