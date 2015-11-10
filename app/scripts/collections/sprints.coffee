define [
  'underscore'
  'backbone'

  'models/session'

  'models/sprint'
], (_, Backbone, SessionModel, SprintModel) ->

  class SprintsCollection extends Backbone.Collection

    model: SprintModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if SessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', SessionModel.get('auth_token'))
      )

      @url = 'sprints'
