define [
  'underscore'
  'backbone'

  'models/currentUser'

  'models/dailyMenu'
], (_, Backbone, CurrentUser, DailyMenuModel) ->

  class DailyMenusCollection extends Backbone.Collection
    url: 'daily_menus'

    model: DailyMenuModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if CurrentUser.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', CurrentUser.get('auth_token'))
      )
