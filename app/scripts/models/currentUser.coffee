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
      localStorage.setItem('c_auth_token', this.get('auth_token'))
      localStorage.setItem('c_name', this.get('name'))

    logout: () ->
      session = new SessionModel({ auth_token: @auth_token })
      session.destroy
        success: (model, data) =>
          @set auth: false
          delete @attributes.auth_token
          delete @attributes.name

    checkAuth: () ->
      if (localStorage.getItem('c_auth_token') && localStorage.getItem('c_name'))
        auth_token = localStorage.getItem('c_auth_token')
        name = localStorage.getItem('c_name')
        @set auth_token: auth_token, name: name, auth: true

  return new CurrentUser()
