define [
  'underscore'
  'backbone'

  'models/currentUser'
], (_, Backbone, CurrentUser) ->
  class SprintModel extends Backbone.Model

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields =
          withCredentials: true

        if CurrentUser.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', CurrentUser.get('auth_token'))
      )

      @url = 'sprints/' + @id
