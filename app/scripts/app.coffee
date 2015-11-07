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
  'views/sprint'
], ($, _, Backbone, Router, sessionModel, Sprint, SprintsCollection, LoginView, SprintsCollectionView, SprintView) ->
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
      $.ajaxPrefilter \
        (options, originalOptions, jqXHR) =>
          options.url = "#{@options.api_endpoint}/#{options.url}"
          return false

    _initRoutes: ->
      @router = new Router()

      @router.on 'route:login', (page) ->
        _view = new LoginView()
        _view.render()

      @router.on 'route:sprint', (page, sprint_id) ->
        _view = new SprintView()
        _view.render()

      @router.on 'route:sprints', (page) ->
        _sprints = new SprintsCollection()
        # Maybe I could fetch in the initialize method of the SprintsCollection
        _sprints.fetch()
        console.log(_sprints)

        _view = new SprintsCollectionView(collection: _sprints)
        _view.render()

      Backbone.history.start()

    _initEvents: ->
      sessionModel.on 'change:auth', (session) =>
        this.checkAuth()

    checkAuth: ->
      if sessionModel.get('auth') is true
        @router.navigate("sprints", {trigger: true})
      else
        @router.navigate("sessions/new", {trigger: true})

  return new Application()
