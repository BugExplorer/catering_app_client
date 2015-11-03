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
        # options.crossDomain = { crossDomain: true }
        # options.xhrFields = { withCredentials: true }

        if self.get('auth_token')?
          jqXHR.setRequestHeader('X-Auth-Token', self.get('auth_token'))
      )

    login: (params) ->
      self = this

      this.fetch(
        data: params,
        dataType: 'json',
        type: 'GET'
        success: (model, xhr, options) ->
          console.log('Success')
          console.log(model)
          sessionStorage.setItem('auth_token', model.get('auth_token'))
          sessionStorage.setItem('name', model.get('name'))
        error: (model, xhr, options) ->
          console.log('Error')
          console.log(options)
          console.log(xhr)
      )

    logout: (params) ->
      self = this

      this.destroy(
        headers: {
          'X-Auth-Token': self.get("auth_token")
        }
        success: (model, response) ->
          model.clear()
          model.id = null
          sessionStorage.removeItem('auth_token')
          sessionStorage.removeItem('name')
          console.log("Logged out")
          self.set({ auth: false, auth_token: null, name: null} )
    )

    getAuth: () ->
      self = this
      if (sessionStorage.getItem('auth_token') && sessionStorage.getItem('name'))
        _auth_token = sessionStorage.getItem('auth_token')
        _name = sessionStorage.getItem('name')
        self.set({ auth: true, auth_token: _auth_token, name: _name })

  return new SessionModel()
