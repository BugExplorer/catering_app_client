define [
  'backbone'

  'models/currentUser'
  'models/session'

  'collections/sprints'

  'views/header'
  'views/content'
  'views/login'
  'views/sprints'
], (Backbone, CurrentUser, SessionModel, SprintsCollection, HeaderView, ContentView, LoginView, SprintsCollectionView) ->
  class CateringRouter extends Backbone.Router
    routes:
      "": "login"
      "logout": "logout"
      "sprints": "showSprints"
      "sprint/:sprintId": "showSprint"

    initialize: ->
      @headerView = new HeaderView()
      @contentView = new ContentView()

    login: ->
      @layoutViews()
      @contentView.swap(new LoginView({ model: new SessionModel() }))

    logout: ->
      if CurrentUser.get('auth')
        CurrentUser.logout()
        view = new LoginView()
      else
        view = new AccessDenied()
      @layoutViews()
      @contentView.swap(view)

    showSprints: ->
      @layoutViews()
      @contentView.swap(
        new SprintsCollectionView({ collection: new SprintsCollection() })
      )
      console.log(@contentView)

    layoutViews: ->
      $('#header').html(@headerView.render().el)
      $('#content').html(@contentView.render().el)
