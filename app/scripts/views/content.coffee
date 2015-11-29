define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'channel'

  'collections/sprints'

  'views/sprints'
  'views/accessDenied'
  'views/order'

  'collections/dailyMenus'
  'collections/dailyRations'
], ($, _, Backbone, JST, channel, SprintsCollection, SprintsCollectionView
 ,  AccessDeniedView, OrderView, DailyMenusCollection, DailyRationsCollection) ->
  class ContentView extends Backbone.View
    template: JST['app/scripts/templates/content.hbs']

    className: 'container-fluid'

    render: ->
      @$el.html(@template())
      return this

    initialize: ->
      @listenTo channel, 'user:loggedIn', @swapToSprints
      @listenTo channel, 'order:submitted', @swapToOrder
      @listenTo channel, 'accessDenied', @accessDenied

    swapToSprints: ->
      @swap(new SprintsCollectionView({ collection: new SprintsCollection() }))
      Backbone.history.navigate('sprints')

    swapToOrder: (sprint_id) ->
      dailyRations = new DailyRationsCollection(sprint_id)
      dailyRations.fetch(
        reset: true
        success: () =>
          dailyMenus = new DailyMenusCollection()
          dailyMenus.fetch(reset: true)
          @swap(new OrderView(dailyRations, dailyMenus))
      )

    accessDenied: ->
      @swap(new AccessDeniedView())
      Backbone.history.navigate('/')

    swap: (view) ->
      @changeCurrentView(view)
      @$('#main-area').html(@currentMainView.render().el)

    changeCurrentView: (view) ->
      @currentMainView.leave() if @currentMainView
      @currentMainView = view
