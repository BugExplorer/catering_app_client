define [
  'underscore'
  'backbone'

  'instances/sessionModel'
], (_, Backbone, sessionModel) ->
  'use strict';

  class DailyMenuModel extends Backbone.Model

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields =
          withCredentials: true

        if sessionModel.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', sessionModel.get('auth_token'))
      )
