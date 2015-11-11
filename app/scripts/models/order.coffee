define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class OrderModel extends Backbone.Model

    initialize: (sprint_id) ->
      $.ajaxSetup({
        'beforeSend': (xhr) ->
          xhr.setRequestHeader("accept", "application/json");
      })

      $.ajaxPrefilter( (options, originalOptions, jqXHR) =>
        options.xhrFields =
          withCredentials: true

        if this.get('auth_token')?
          jqXHR.setRequestHeader('X-Auth-Token', this.get('auth_token'))
      )
      # Setting POST API url
      @url = 'sprints/' + sprint_id + '/daily_rations'

    save: (params) ->
      # Convert params, and so jquery's post method can parse them
      data = params
      data = data.replace(/%5B/g,"[")
      data = data.replace(/%5D/g,"]")
      # Use AJAX
      $.post( @url, data )
