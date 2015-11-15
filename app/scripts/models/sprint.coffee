define [
  'underscore'
  'backbone'

  'models/currentUser'
], (_, Backbone, CurrentUser) ->
  'use strict';

  class SprintModel extends Backbone.Model
    idAttribute: "id"

    initialize: (sprint_id) ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields =
          withCredentials: true

        if CurrentUser.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', CurrentUser.get('auth_token'))
      )

      @url = 'sprints/' + sprint_id
