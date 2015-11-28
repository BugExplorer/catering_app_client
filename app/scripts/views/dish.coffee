define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'
  'channel'
  'models/dish'
  'views/helpers'
], ($, _, Backbone, JST, ui, channel, DishModel, Helpers) ->
  class DishView extends Backbone.View
    template: JST['app/scripts/templates/dish.hbs']

    events:
      'click input[type=checkbox]': 'bindInputs'
      'change input[type=number]': 'quantityChanged'

    tagName: 'div'
    className: 'col-md-4 dish'

    initialize: (model, dayId) ->
      # Create dish model
      @dish = new DishModel()
      @dish.set(model)
      @dish.set day_id: dayId
      @dish.set quantity: 1

    render: ->
      @$el.html @template(dish: @dish.toJSON())
      # Change id attribute
      @$el.attr('id', 'dish-' + @dish.id)
      return this

    quantityChanged: (event) ->
      input = event.target
      @dish.set quantity: parseInt($(input).val())
      channel.trigger('sideBarDish:quantityChanged', @dish)

    # Enable quantity input and add a checked dish to the sidebar
    bindInputs: (event) ->
      checkbox = event.target
      number_input = $(checkbox).closest('.dish').find('input[type=number]')
      if ($(checkbox)).is(':checked')
        number_input.removeAttr('disabled')
        # Set quanity value from input
        @dish.set quantity: parseInt(@$el.closest('.dish').find('input[type=number]').val())
        channel.trigger('sideBar:dishAdded', @dish)
      else
        number_input.prop('disabled', true)
        # Remove dish from the sidebar
        channel.trigger('sideBar:dishRemoved', @dish)
