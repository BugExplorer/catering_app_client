define [
  'jquery'
  'underscore'
  'backbone'
  'router'

  'instances/sessionModel'

  'models/sprint'

  'collections/sprints'
  'collections/dailyMenus'

  'views/login'
  'views/sprints'
  'views/dailyRationsForm'
], ($, _, Backbone, Router, sessionModel, Sprint, SprintsCollection, DailyMenusCollection, LoginView, SprintsCollectionView, DailyRationsFormView) ->
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
      # It's here because I need to send a Sprint from Sprints to it's view
      _sprints = new SprintsCollection()

      @router.on 'route:login', (page) ->
        _view = new LoginView()
        _view.render()

      @router.on 'route:sprint', (sprint_id) =>
        unless _sprints.get(sprint_id)
          @router.navigate("sprints", {trigger: true})
        else
          _sprint = _sprints.get(sprint_id)

          _dailyMenus = new DailyMenusCollection()
          new Promise (resolve, reject) =>
            _dailyMenus.fetch(
              success: (collection) =>
                _view = new DailyRationsFormView(_sprint, _dailyMenus)
                _view.render()
                resolve()
            )

      @router.on 'route:sprints', (page) ->
        new Promise (resolve, reject) =>
          _sprints.fetch(
            success: (model, response) ->
              _view = new SprintsCollectionView(collection: _sprints)
              _view.render()
              resolve()
            error: (model, response) ->
              reject 'Unauthorized'
          )

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
