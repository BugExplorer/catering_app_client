define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'channel'

  'models/currentUser'
], ($, _, Backbone, JST, channel, CurrentUser) ->
  class LoginView extends Backbone.View
    template: JST['app/scripts/templates/header.hbs']

    className: 'navbar'

    initialize: ->
      @listenTo channel, 'user:loggedIn', @render

    render: ->
      @$el.html @template({ current_user: CurrentUser.get('name') })
      return this
