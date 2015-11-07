define [
  'underscore'
  'backbone'
  'models/sprint'
], (_, Backbone, SprintModel) ->

  class SprintsCollection extends Backbone.Collection
    url: 'sprints'

    model: SprintModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        # It's not a safe way
        if sessionStorage.getItem('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token',
            sessionStorage.getItem('auth_token'))
      )
