define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/helpers'
], ($, _, Backbone, JST, ui, Helpers) ->
  class SideBarView extends Backbone.View
    template: JST['app/scripts/templates/sideBarView.hbs']

    initialize: (sprint, days) ->
      @sprint = sprint
      @days = days

    render: ->
      @$el.html @template()
      return this
