define [
  'jquery'
  'underscore'
  'backbone'
  'router'

  'models/session'
  'models/sprint'

  'collections/sprints'

  'views/contacts'
  'views/login'
  'views/sprints_collection'
], ($, _, Backbone, Router, Session, Sprint, SprintsCollection, ContactsView, LoginView, SprintsCollectionView) ->
  class Application
    @defaults =
      api_endpoint: "http://127.0.0.1:3000/api/v1"

    Backbone.emulateJSON = true

    constructor: (options = {}) ->
      @router = null
      @options = $.extend(Application.defaults, options)
      @session = null

    initialize: () ->
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

      @router.on 'route:contacts', (page) ->
        _view = new ContactsView()
        _view.render()

      @router.on 'route:sprints', (page) ->
        sprints = new SprintsCollection()
        _view = new SprintsCollectionView(collection: sprints)
        _view.render()

      Backbone.history.start()

    _initEvents: ->
      self = this

      Session.on 'change:auth', (session) ->
        self.checkAuth()

      Session.getAuth()

    checkAuth: ->
      if Session.get('auth') is true
        @router.navigate("sprints", {trigger: true})
      else
        @router.navigate("sessions/new", {trigger: true})

  return new Application()
