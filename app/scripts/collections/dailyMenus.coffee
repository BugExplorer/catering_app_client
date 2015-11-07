define [
  'underscore'
  'backbone'

  'instances/sessionModel'

  'models/dailyMenu'
], (_, Backbone, sessionModel, DailyMenuModel) ->

  class DailyMenusCollection extends Backbone.Collection
    url: 'daily_menus'

    model: DailyMenuModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if sessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', sessionModel.get('auth_token'))
      )
