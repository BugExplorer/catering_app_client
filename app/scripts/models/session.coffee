define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class SessionModel extends Backbone.Model
    url: 'sessions'

    Backbone.emulateJSON = true

    initialize: () ->
      self = this

      $.ajaxSetup({
        'beforeSend': (xhr) ->
          xhr.setRequestHeader("accept", "application/json");
      })

      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if self.get('auth_token')?
          jqXHR.setRequestHeader('X-Auth-Token', self.get('auth_token'))
      )

    login: (params) ->
      this.fetch(
        data: params,
        dataType: 'json',
        type: 'POST'
        success: (model, xhr, options) ->
          console.log('Login Success')
          console.log(model)
          localStorage.setItem('auth_token', model.get('auth_token'))
          localStorage.setItem('name', model.get('name'))
        error: (model, xhr, options) ->
          console.log('Login Error')
          console.log(options)
          console.log(xhr)
      )

    logout: (params) ->
      this.destroy(
        success: (model, response) ->
          model.clear()
          model.id = null
          localStorage.removeItem('auth_token')
          localStorage.removeItem('name')
      )

    getAuth: () ->
      self = this
      if (localStorage.getItem('auth_token') && localStorage.getItem('name'))
        _auth_token = localStorage.getItem('auth_token')
        _name = localStorage.getItem('name')
        self.set({ auth: true, auth_token: _auth_token, name: _name })
