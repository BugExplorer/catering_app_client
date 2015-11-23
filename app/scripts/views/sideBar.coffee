define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'
  'channel'

  'views/sideBarDish'
  'views/helpers'
], ($, _, Backbone, JST, ui, channel, SideBarDishView, Helpers) ->
  class SideBarView extends Backbone.View
    template: JST['app/scripts/templates/sideBar.hbs']

    initialize: (sprint, days) ->
      @childViews = []
      @total_price = []
      @sprint = sprint
      @days = days
      this.listenTo @days, 'reset', this.render
      this.listenTo channel, 'sideBar:dishAdded', @addDish
      this.listenTo channel, 'sideBar:dishRemoved', @removeDish
      this.listenTo channel, 'sideBarDish:priceChanged', @validatePrice

    # Append dish to the sidebar (after day title)
    addDish: (dish, day_id, quanity) ->
      view = new SideBarDishView(dish, day_id, @days.get(day_id), quanity)
      @childViews.push(view)
      # Validate price
      price = (parseFloat(dish.price) * parseFloat(quanity)).toFixed(2)
      channel.trigger('sideBarDish:priceChanged', price, 0, day_id)
      rendered_view = view.render().el
      # To make slide animation via JQuery
      $(rendered_view).css('display', 'none')
      $(rendered_view).appendTo(@$('#' + day_id)).slideDown(250)

    # Remove dish view from the sidebar and trigger price validation event
    removeDish: (dish, day_id, quanity) ->
      @$('#' + day_id).children('#dish-' + dish.id).slideUp(200, () ->
        # Validate price
        price = (parseFloat(dish.price) * parseFloat(quanity)).toFixed(2)
        channel.trigger('sideBarDish:priceChanged', 0, price, day_id)
        # Remove dish when animation is complete
        channel.trigger('sideBarDish:leave', $(this).attr('view'))
        this.remove()
      )

    # Validate total price for a day
    # If it is invalid, then change day title color to red
    validatePrice: (price, price_before, day_id) ->
      @$('#' + day_id).removeClass('error')
      total_price = (@total_price[day_id] - parseFloat(price_before) +
                     parseFloat(price)).toFixed(2)
      # Make day color red if total price is invalid
      if total_price > @days.get(day_id).get('max_total')
        @$('#' + day_id).addClass('error')
      # Change total price for this day
      @total_price[day_id] = total_price

    render: ->
      @$el.html @template(days: @days.toJSON())
      @childViews = []
      # Fill total prices array
      @days.each((day) =>
        @total_price[day.id] = 0
      )
      return this
