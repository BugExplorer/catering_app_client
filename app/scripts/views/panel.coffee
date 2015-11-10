define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'models/session'
], ($, _, Backbone, JST, SessionModel) ->
  class PanelView extends Backbone.View
    template: JST['app/scripts/templates/panel.hbs']

    events:
      'click .logout': 'logout'

    initialize: ->

    render: ->
      @$el.html @template({ name: SessionModel.get('name') })

    logout: (event) ->
      SessionModel.logout()
