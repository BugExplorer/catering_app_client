define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/helpers'
], ($, _, Backbone, JST, ui, Helpers) ->
  class DailyMenusCollectionView extends Backbone.View
    template: JST['app/scripts/templates/dailyMenus.hbs']

    initialize: (dailyMenus) ->
      @dailyMenus = dailyMenus
      @dailyMenus.bind("sync", this.render, this)

    render: ->
      @$el.html @template(dailyMenus: @dailyMenus.toJSON())
      # Use Jquery-UI to create tabbed form
      $("#tabs").tabs()
      # Enable number input if checkbox is checked
      $('input[type=checkbox]').click(() ->
        id = $(this).attr('id')
        input_el = $('#' + id + '-inp')
        toggled = input_el.attr('disabled')
        toggled = !toggled
        input_el.prop('disabled', toggled)
      )

