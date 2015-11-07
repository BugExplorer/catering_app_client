define [
  'jquery'
  'underscore'
  'backbone'
  'router'

  'instances/sessionModel'
  'models/sprint'

  'collections/sprints'

  'views/login'
  'views/sprints'
], ($, _, Backbone, Router, sessionModel, Sprint, SprintsCollection, LoginView, SprintsCollectionView) ->
  class Application
    @defaults =
      api_endpoint: "http://127.0.0.1:3000/api/v1"

    Backbone.emulateJSON = true

    constructor: (options = {}) ->
      @router = null
      @options = $.extend(Application.defaults, options)

    initialize: () ->
      sessionModel.getAuth()

      this._initConfiguration()
      this._initRoutes()
      this._initEvents()

    _initConfiguration: ->
      self = this

      $.ajaxPrefilter \
        (options, originalOptions, jqXHR) ->
          options.url = "#{self.options.api_endpoint}/#{options.url}"
          no

    _initRoutes: ->
      @router = new Router()

      @router.on 'route:login', (page) ->
        _view = new LoginView()
        _view.render()

      @router.on 'route:sprints', (page) ->
        _sprints = new SprintsCollection()
        _sprints.fetch()

        _view = new SprintsCollectionView(collection: _sprints)
        _view.render()

      Backbone.history.start()

    _initEvents: ->
      self = this

      sessionModel.on 'change:auth', (session) ->
        self.checkAuth()

    checkAuth: ->
      if sessionModel.get('auth') is true
        @router.navigate("sprints", {trigger: true})
      else
        @router.navigate("sessions/new", {trigger: true})

  return new Application()
