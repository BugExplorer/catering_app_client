define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class SessionModel extends Backbone.Model
    url: 'sessions'

    initialize: () ->
      $.ajaxSetup({
        'beforeSend': (xhr) ->
          xhr.setRequestHeader("accept", "application/json");
      })

      $.ajaxPrefilter( (options, originalOptions, jqXHR) =>
        options.xhrFields =
          withCredentials: true

        if this.get('auth_token')?
          jqXHR.setRequestHeader('X-Auth-Token', this.get('auth_token'))
      )

    login: (params) ->
      this.fetch(
        data: params,
        dataType: 'json',
        type: 'POST'
        success: (model, xhr, options) ->
          console.log('Login Success')
          sessionStorage.setItem('auth_token', model.get('auth_token'))
          sessionStorage.setItem('name', model.get('name'))
        error: (model, xhr, options) ->
          console.log('Login Error')
      )

    logout: (params) ->
      this.destroy(
        success: (model, response) ->
          model.clear()
          model.id = null
          sessionStorage.removeItem('auth_token')
          sessionStorage.removeItem('name')
      )

    getAuth: () ->
      # ToDo. It's not a proper way.
      # Should validate auth-token from the sessionStorage
      if (sessionStorage.getItem('auth_token') && sessionStorage.getItem('name'))
        _auth_token = sessionStorage.getItem('auth_token')
        _name = sessionStorage.getItem('name')
        this.set({ auth: true, auth_token: _auth_token, name: _name })

  return new SessionModel()
