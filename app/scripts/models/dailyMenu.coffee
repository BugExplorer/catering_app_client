define [
  'underscore'
  'backbone'

  'models/session'
], (_, Backbone, SessionModel) ->
  'use strict';

  class DailyMenuModel extends Backbone.Model

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields =
          withCredentials: true

        if SessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', SessionModel.get('auth_token'))
      )
