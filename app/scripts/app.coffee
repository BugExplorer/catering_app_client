define [
  'jquery'
  'underscore'
  'backbone'

  'routes/catering'

  'models/currentUser'
], ($, _, Backbone, CateringRouter, CurrentUser) ->
  class Application
    @defaults =
      api_endpoint: "http://127.0.0.1:3000/api/v1"

    constructor: (options = {}) ->
      @options = $.extend(Application.defaults, options)

    initialize: () ->
      this.initConfiguration()
      this.checkAuth()

      new CateringRouter()
      Backbone.history.start()

    initConfiguration: ->
      $.ajaxPrefilter \
        (options, originalOptions, jqXHR) =>
          options.url = "#{@options.api_endpoint}/#{options.url}"
          return false

    checkAuth: ->
      CurrentUser.checkAuth()

  return new Application()
