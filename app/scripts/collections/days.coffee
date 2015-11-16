define [
  'underscore'
  'backbone'

  'models/currentUser'

  'models/day'
], (_, Backbone, CurrentUser, DayModel) ->

  class DaysCollection extends Backbone.Collection
    url: 'form_contents'

    model: DayModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if CurrentUser.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', CurrentUser.get('auth_token'))
      )
