define [
  'underscore'
  'backbone'

  'models/currentUser'

  'models/dailyRation'
], (_, Backbone, CurrentUser, DailyRationModel) ->

  class DailyRationsCollection extends Backbone.Collection
    model: DailyRationModel

    initialize: (sprintId) ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if CurrentUser.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', CurrentUser.get('auth_token'))
      )

      # Setting the POST and GET url
      @url = 'sprints/' + sprintId + '/daily_rations'
