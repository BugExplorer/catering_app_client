define [
  'jquery'
  'underscore'
  'backbone'
  'router'

  'models/session'
  'models/sprint'

  'collections/sprints'
  'collections/days'

  'views/login'
  'views/sprints'
  'views/form'
], ($, _, Backbone, Router, SessionModel, SprintModel, SprintsCollection
 ,  DaysCollection, LoginView, SprintsCollectionView, FormView) ->
  class Application
    @defaults =
      api_endpoint: "http://127.0.0.1:3000/api/v1"

    constructor: (options = {}) ->
      @router = null
      @options = $.extend(Application.defaults, options)

    initialize: () ->
      SessionModel.getAuth()

      this.initConfiguration()
      this.initRoutes()
      this.initEvents()

    initConfiguration: ->
      $.ajaxPrefilter \
        (options, originalOptions, jqXHR) =>
          options.url = "#{@options.api_endpoint}/#{options.url}"
          return false

    initRoutes: ->
      @router = new Router()

      @router.on 'route:login', (page) ->
        view = new LoginView()
        view.render()

      @router.on 'route:sprint', (sprintId) =>
        # To set action attribute on the form
        apiEndpoint = @options.api_endpoint
        sprint = new SprintModel(sprintId)
        days = new DaysCollection()
        view = new FormView(sprint, days, apiEndpoint)
        view.render()

      @router.on 'route:sprints', (page) ->
        sprints = new SprintsCollection()
        view = new SprintsCollectionView({ collection: sprints })
        view.render()

      Backbone.history.start()

    initEvents: ->
      SessionModel.on 'change:auth', (session) =>
        this.checkAuth()

    checkAuth: ->
      if SessionModel.get('auth') is true
        @router.navigate("sprints", { trigger: true })
      else
        @router.navigate("sessions/new", { trigger: true })

  return new Application()
