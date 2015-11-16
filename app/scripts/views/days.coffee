define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/helpers'
], ($, _, Backbone, JST, ui, Helpers) ->
  class DaysCollectionView extends Backbone.View
    template: JST['app/scripts/templates/days.hbs']

    events:
      "click input[type=checkbox]": "bindInputs"

    initialize: () ->
      this.listenTo @collection, "reset", this.render

    render: ->
      @$el.html @template(dailyMenus: @collection.toJSON())
      # Use Jquery-UI to create tabbed form
      $("#tabs").tabs()
      return this

    bindInputs: (event) ->
      checkbox = event.target
      number_input = $(checkbox).closest('.dish').find('input[type=number]')
      if ($(checkbox)).is(":checked")
        number_input.removeAttr('disabled')
      else
        number_input.prop('disabled', true)


