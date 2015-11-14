define [
  'underscore'
  'backbone'

  'models/session'

  'models/dailyRation'
], (_, Backbone, SessionModel, DailyRationModel) ->

  class DaysCollection extends Backbone.Collection
    url: 'form_contents'

    model: DailyRationModel

    initialize: (sprintId) ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if SessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', SessionModel.get('auth_token'))
      )

      # Setting POST API url
      @url = 'sprints/' + sprintId + '/daily_rations'
