define [
  'underscore'
  'backbone'
], (_, Backbone) ->
  'use strict';

  class SprintModel extends Backbone.Model
    url: 'sprints',

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if self.get('auth_token')?
          jqXHR.setRequestHeader('X-Auth-Token', self.get('auth_token'))
      )

    # defaults: {}

    # validate: (attrs, options) ->

    # parse: (response, options) ->
    #   response
