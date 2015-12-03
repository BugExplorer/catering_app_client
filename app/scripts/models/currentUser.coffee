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

      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields =
          withCredentials: true

        if localStorage.getItem('c_auth_token')
          jqXHR.setRequestHeader('X-Auth-Token',
            localStorage.getItem('c_auth_token'))
      )

    login: (auth_token, name) ->
      @set auth_token: auth_token, name: name, auth: true
      localStorage.setItem('c_auth_token', this.get('auth_token'))
      localStorage.setItem('c_name', this.get('name'))

    logout: () ->
      session = new SessionModel({ auth_token: @auth_token })
      session.fetch(
        type: "DELETE"
        success: (model, data) =>
          this.set auth: false
          delete @attributes.auth_token
          delete @attributes.name
          localStorage.removeItem('c_auth_token')
          localStorage.removeItem('c_name')
        error: () =>
          localStorage.removeItem('c_auth_token')
          localStorage.removeItem('c_name')
      )

    checkAuth: () ->
      if (localStorage.getItem('c_auth_token') && localStorage.getItem('c_name'))
        auth_token = localStorage.getItem('c_auth_token')
        name = localStorage.getItem('c_name')
        @set auth_token: auth_token, name: name, auth: true
        return true

  return new CurrentUser()
