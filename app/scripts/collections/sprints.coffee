define [
  'underscore'
  'backbone'
  'models/sprint'
], (_, Backbone, SprintModel) ->

  class SprintsCollection extends Backbone.Collection
    url: 'sprints'

    model: SprintModel

    initialize: () ->
      self = this

      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if sessionStorage.getItem('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token',
            sessionStorage.getItem('auth_token'))
      )
