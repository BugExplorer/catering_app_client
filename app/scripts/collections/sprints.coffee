define [
  'underscore'
  'backbone'

  'models/currentUser'

  'models/sprint'
], (_, Backbone, CurrentUser, SprintModel) ->

  class SprintsCollection extends Backbone.Collection

    model: SprintModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if CurrentUser.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', CurrentUser.get('auth_token'))
      )

      @url = 'sprints'
