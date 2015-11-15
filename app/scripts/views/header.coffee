define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'models/currentUser'
], ($, _, Backbone, JST, CurrentUser) ->
  class LoginView extends Backbone.View
    template: JST['app/scripts/templates/header.hbs']

    className: 'navbar'

    initialize: ->

    render: ->
      @$el.html @template({ current_user: CurrentUser.get('name') })
      return this
