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
      CurrentUser.logout().then(() =>
        this.navigate('', true))

    showSprints: ->
      @layoutViews()
      if CurrentUser.get('auth')
        v = new SprintsCollectionView({ collection: new SprintsCollection() })
      else
        v = new AccessDeniedView()
      @contentView.swap(v)

    showSprint: (id) ->
      @layoutViews()
      unless CurrentUser.get('auth')
        v = new AccessDeniedView()
        @contentView.swap(v)
      else
        # Check if user made order before
        response = $.ajax({
          url: 'sprints/' + id + '/daily_rations',
          headers: { 'X-Auth-Token': CurrentUser.get('auth_token') }
        })
        .done(() =>
          # There are db records with that user
          if response.status == 204
            v = new AccessDeniedView()
          else
            # Show order form
            sprint = new SprintModel({ id: id })
            days = new DaysCollection()
            v = new FormView(sprint, days)

          @contentView.swap(v)
        )


    layoutViews: ->
      $('#header').html(@headerView.render().el)
      $('#content').html(@contentView.render().el)
