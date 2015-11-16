define [
  'underscore'
  'backbone'

  'channel'

  'models/session'
], (_, Backbone, channel, SessionModel) ->
  class CurrentUser extends Backbone.Model

    initialize: () ->
      @listenTo channel, "user:loggedIn", @login
      @listenTo channel, "user:loggedOut", @logout

    login: (auth_token, name) ->
      @set auth_token: auth_token, name: name, auth: true

    logout: () ->
      session = new SessionModel({ auth_token: @auth_token })
      session.destroy
        success: (model, data) =>
          @set auth: false
          delete @attributes.auth_token
          delete @attributes.name

  return new CurrentUser()
