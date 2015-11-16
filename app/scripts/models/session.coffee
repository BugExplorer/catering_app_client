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
