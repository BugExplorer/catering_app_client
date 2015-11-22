define [
  'underscore'
  'backbone'
  'models/currentUser'
], (_, Backbone, CurrentUser) ->
  class SessionModel extends Backbone.Model
    url: 'sessions'

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if localStorage.getItem('c_auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', localStorage.getItem('c_auth_token'))
      )
