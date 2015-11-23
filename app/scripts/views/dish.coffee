define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'
  'channel'

  'views/helpers'
], ($, _, Backbone, JST, ui, channel, Helpers) ->
  class DishView extends Backbone.View
    template: JST['app/scripts/templates/dish.hbs']

    events:
      'click input[type=checkbox]': 'bindInputs'
      'change input[type=number]': 'quanityChanged'

    tagName: 'div'
    className: 'col-md-4 dish'

    initialize: (model, day_id) ->
      @model = model
      @day_id = day_id
      @quanity = 1

    render: ->
      @$el.html @template(dish: @model, day: @day_id)
      # change id attribute
      @$el.attr('id', 'dish-' + @model.id)
      return this

    quanityChanged: (event) ->
      input = event.target
      @quanity = $(input).val()
      channel.trigger('sideBarDish:quanityChanged', @model, @day_id, @quanity)

    # Enable quanity input and add a checked dish to the sidebar
    bindInputs: (event) ->
      checkbox = event.target
      number_input = $(checkbox).closest('.dish').find('input[type=number]')
      if ($(checkbox)).is(':checked')
        number_input.removeAttr('disabled')

        # Trigger event, send id and quanity of checked dish
        @quanity = @$el.closest('.dish').find('input[type=number]').val()
        channel.trigger('sideBar:dishAdded', @model, @day_id, @quanity)
      else
        number_input.prop('disabled', true)

        # Remove dish from the sidebar
        channel.trigger('sideBar:dishRemoved', @model, @day_id, @quanity)

