define [
  'backbone'

  'models/currentUser'
  'models/session'
  'models/sprint'

  'collections/sprints'
  'collections/formDays'
  'collections/dailyRations'
  'collections/dailyMenus'

  'views/content'
  'views/login'
  'views/sprints'
  'views/form'
  'views/accessDenied'
  'views/order'
  'views/header'
], (Backbone, CurrentUser, SessionModel, SprintModel, SprintsCollection
 ,  FormDaysCollection, DailyRationsCollection, DailyMenusCollection
 ,  ContentView, LoginView, SprintsCollectionView, FormView, AccessDeniedView
 ,  OrderView, HeaderView) ->
  class CateringRouter extends Backbone.Router
    routes:
      '': 'login'
      'logout': 'logout'
      'sprints': 'showSprints'
      'sprint/:id': 'showSprint'

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
      v = new AccessDeniedView()

      sprint = new SprintModel({ id: id })
      sprint.fetch()

      daily_rations = new DailyRationsCollection(id)
      daily_rations.fetch(
        success: (collection) ->
          # If collection is empty and sprint is running, then show order form
          if daily_rations.length == 0 && sprint.get('state') == 'running'
            days = new FormDaysCollection()
            v = new FormView(sprint, days)
          else # show user's order
            dailyMenus = new DailyMenusCollection()
            dailyMenus.fetch(reset: true)
            v = new OrderView(daily_rations, dailyMenus)
      ).then(() =>
        @contentView.swap(v)
      )

    layoutViews: ->
      $('#header').html(@headerView.render().el)
      $('#content').html(@contentView.render().el)
