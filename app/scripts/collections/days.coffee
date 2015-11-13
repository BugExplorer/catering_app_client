define [
  'underscore'
  'backbone'

  'models/session'

  'models/day'
], (_, Backbone, SessionModel, DayModel) ->

  class DaysCollection extends Backbone.Collection
    url: 'form_contents'

    model: DayModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if SessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', SessionModel.get('auth_token'))
      )
