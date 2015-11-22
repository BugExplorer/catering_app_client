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

    tagName: "li"
    className: "side-bar-dish"

    initialize: (dish, day_id, day, quanity) ->
      @model   = dish
      @day_id  = day_id
      @day     = day
      @price   = (parseFloat(dish.price) * parseFloat(quanity)).toFixed(2)
      @quanity = quanity
      this.listenTo channel, "sideBarDish:quanityChanged", @changeQuanity
      this.listenTo channel, "sideBarDish:leave", @remove

    changeQuanity: (dish, day_id, quanity) ->
      if @model == dish && @day_id == day_id
        # Validate day limit
        price = (@model.price * quanity).toFixed(2)
        channel.trigger("sideBarDish:priceChanged", price, @price, day_id)
        @price = price
        @quanity = quanity
        # Re-render
        this.render()

    remove: (view_cid) ->
      if @cid == view_cid
        this.undelegateEvents()
        this.leave()

    render: ->
      @$el.html @template(dish: @model, price: @price, quanity: @quanity)
      # set li's id
      @$el.attr('id', "dish-" + @model.id)
      @$el.attr('view', @cid)
      return this
