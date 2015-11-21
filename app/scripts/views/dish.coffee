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
      "click input[type=checkbox]": "bindInputs"

    tagName: "div"
    className: "col-md-4 dish"

    initialize: (model, day_number) ->
      @model = model
      @day_number = day_number

    render: ->
      @$el.html @template(dish: @model)
      # change id attribute
      @$el.attr('id', "dish-" + @model.id)
      console.log(@model)
      return this

    # Enable quanity input and add a checked dish to the sidebar
    bindInputs: (event) ->
      checkbox = event.target
      number_input = $(checkbox).closest('.dish').find('input[type=number]')
      if ($(checkbox)).is(":checked")
        number_input.removeAttr('disabled')
        # Trigger event and send id of checked dish
        channel.trigger("sideBar:dishAdded", @model, @day_number)
      else
        number_input.prop('disabled', true)
        # Remove dish from the sidebar
        channel.trigger("sideBar:dishRemoved", @model, @day_number)

