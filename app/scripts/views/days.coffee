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

    initialize: (dailyMenus) ->
      @dailyMenus = dailyMenus
      # @dailyMenus.bind("sync", this.render, this)

    render: ->
      @$el.html @template(dailyMenus: @dailyMenus.toJSON())
      # Use Jquery-UI to create tabbed form
      $("#tabs").tabs()

    bindInputs: (event) ->
      checkbox = event.target
      number_input = $(checkbox).closest('.dish').find('input[type=number]')
      if ($(checkbox)).is(":checked")
        number_input.removeAttr('disabled')
      else
        number_input.prop('disabled', true)


