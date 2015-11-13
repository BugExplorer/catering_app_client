define [
  'underscore'
  'backbone'

  'models/session'
], (_, Backbone, SessionModel) ->
  'use strict';

  class SprintModel extends Backbone.Model
    idAttribute: "id"

    initialize: (sprint_id) ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields =
          withCredentials: true

        if SessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', SessionModel.get('auth_token'))
      )

      @url = 'sprints/' + sprint_id
