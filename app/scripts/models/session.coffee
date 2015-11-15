define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  class SessionModel extends Backbone.Model
    url: 'sessions'

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) =>
        options.xhrFields =
          withCredentials: true

        if @auth_token
          jqXHR.setRequestHeader('X-Auth-Token', @auth_token)
      )

    getAuth: () ->
      # ToDo. It's not a proper way.
      # Should validate auth-token from the sessionStorage
      if (sessionStorage.getItem('auth_token') && sessionStorage.getItem('name'))
        _auth_token = sessionStorage.getItem('auth_token')
        _name = sessionStorage.getItem('name')
        this.set({ auth: true, auth_token: _auth_token, name: _name })
