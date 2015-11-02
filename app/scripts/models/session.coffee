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

    # # defaults: {}
    # login: (params) ->
    #   that = this
    #   _login = $.ajax(
    #     url: @url,
    #     data: params,
    #     dataType: 'json',
    #     type: 'GET'
    #     success: (data, textStatus, jqXHR) ->
    #       console.log(textStatus)
    #     error: (data, textStatus, jqXHR) ->
    #       debugger
    #       console.log(data)
    #       console.log(jqXHR)
    #       console.log(textStatus)
    #     )


    login: (params) ->
      self = this

      this.fetch(
        data: params,
        dataType: 'json',
        type: 'GET'
        success: (model, xhr, options) ->
          console.log("Success")
          console.log(model)
        error: (model, xhr, options) ->
          console.log("Error")
          console.log(options)
          console.log(xhr)
          console.log(JSON.parse(xhr.responseText))
      )

    # logout: (params) ->
    #   self = this

    #   this.destroy(
    #     success: (model, response) ->
    #       model.clear()
    #       model.id = null

    #       self.set({auth: false, auth_token: null, name: null})
      # )

    # getAuth: (callback) ->
    #   # this.fetch(
    #   #   data: params
    #   #   success: () ->
    #   #     alert(this)
    #   #     console.log(this)
    #   #     self.render()
    #   # )
    #   this.fetch(
    #     success: callback
    #   )

  return new SessionModel()
