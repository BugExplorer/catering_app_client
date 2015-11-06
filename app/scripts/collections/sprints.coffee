define [
  'underscore'
  'backbone'
  'models/sprint'
], (_, Backbone, SprintModel) ->

  class SprintsCollection extends Backbone.Collection
    model: SprintModel

    url: 'sprints'

    initialize: () ->
      self = this

      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if sessionStorage.getItem('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token',
            sessionStorage.getItem('auth_token'))
      )

      this.fetch(
        dataType: 'json',
        type: 'GET'
        success: (collection, xhr, options) ->
          console.log('Success')
          console.log(collection)
        error: (collection, xhr, options) ->
          console.log('Error')
          console.log(options)
          console.log(xhr)
      )

