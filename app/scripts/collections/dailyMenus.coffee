define [
  'underscore'
  'backbone'

  'models/session'

  'models/dailyMenu'
], (_, Backbone, SessionModel, DailyMenuModel) ->

  class DailyMenusCollection extends Backbone.Collection
    url: 'daily_menus'

    model: DailyMenuModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if SessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', SessionModel.get('auth_token'))
      )
