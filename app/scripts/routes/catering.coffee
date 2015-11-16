define [
  'backbone'

  'models/currentUser'
  'models/session'
  'models/sprint'

  'collections/sprints'
  'collections/days'

  'views/header'
  'views/content'
  'views/login'
  'views/sprints'
  'views/form'
  'views/accessDenied'
], (Backbone, CurrentUser, SessionModel, SprintModel, SprintsCollection
 ,  DaysCollection, HeaderView, ContentView, LoginView, SprintsCollectionView
 ,  FormView, AccessDeniedView) ->
  class CateringRouter extends Backbone.Router
    routes:
      "": "login"
      "logout": "logout"
      "sprints": "showSprints"
      "sprint/:id": "showSprint"

    initialize: ->
      @headerView = new HeaderView()
      @contentView = new ContentView()

    login: ->
      if CurrentUser.get('auth')
        this.navigate('sprints', { trigger: true })
      else
        @layoutViews()
        @contentView.swap(new LoginView({ model: new SessionModel() }))

    logout: ->
      CurrentUser.logout()
      this.navigate('', { trigger: true })

    showSprints: ->
      @layoutViews()
      if CurrentUser.get('auth')
        v = new SprintsCollectionView({ collection: new SprintsCollection() })
      else
        v = new AccessDeniedView()
      @contentView.swap(v)

    showSprint: (id) ->
      @layoutViews()
      if CurrentUser.get('auth')
        sprint = new SprintModel({ id: id })
        days = new DaysCollection()
        v = new FormView(sprint, days)
      else
        v = new AccessDeniedView()
      @contentView.swap(v)

    layoutViews: ->
      $('#header').html(@headerView.render().el)
      $('#content').html(@contentView.render().el)
