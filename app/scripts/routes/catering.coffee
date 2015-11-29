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
      daily_rations.fetch(reset: true).then(() =>
        new Promise((resolve, reject) =>
          if daily_rations.length == 0 && sprint.get('state') == 'running'
            days = new FormDaysCollection()
            days.fetch(reset: true)
            v = new FormView(sprint, days)
            resolve()
          else # show user's order
            dailyMenus = new DailyMenusCollection()
            dailyMenus.fetch(reset: true).then(() =>
              v = new OrderView(daily_rations, dailyMenus)
              resolve()
            )
        ).then(() =>
          @contentView.swap(v)
        )
      )


    layoutViews: ->
      $('#header').html(@headerView.render().el)
      $('#content').html(@contentView.render().el)
