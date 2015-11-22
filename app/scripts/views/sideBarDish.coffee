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

    initialize: (dish, day_id, day) ->
      @model   = dish
      @day_id  = day_id
      @day     = day
      @price   = @model.price
      @quanity = 1
      this.listenTo channel, "sideBarDish:quanityChanged", @changeQuanity

    changeQuanity: (dish, day_id, quanity) ->
      if @model == dish && @day_id == day_id
        # Validate day limit
        price = (@model.price * quanity).toFixed(2)
        channel.trigger("sideBarDish:priceChanged", price, @price, day_id)
        @price = price
        @quanity = quanity
        @$el.find(".price").html(price)
        @$el.find(".badge").html(quanity)

    render: ->
      @$el.html @template(dish: @model, price: @price, quanity: @quanity)
      # set li's id
      @$el.attr('id', "dish-" + @model.id)
      return this
