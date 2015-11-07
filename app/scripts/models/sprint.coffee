define [
  'underscore'
  'backbone'

  'instances/sessionModel'

  'collections/dailyMenus'
], (_, Backbone, sessionModel, DailyMenusCollection) ->
  'use strict';

  class SprintModel extends Backbone.Model
    idAttribute: "id"

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields =
          withCredentials: true

        if sessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', sessionModel.get('auth_token'))
      )
