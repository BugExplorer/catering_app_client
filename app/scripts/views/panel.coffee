define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'instances/sessionModel'
], ($, _, Backbone, JST, sessionModel) ->
  class PanelView extends Backbone.View
    template: JST['app/scripts/templates/panel.hbs']

    events:
      'click .logout': 'logout'

    initialize: ->

    render: ->
      @$el.html @template({ name: sessionModel.get('name') })

    logout: (event) ->
      sessionModel.logout()
