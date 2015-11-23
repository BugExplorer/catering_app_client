define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'channel'

  'collections/sprints'

  'views/sprints'
  'views/accessDenied'
], ($, _, Backbone, JST, channel, SprintsCollection, SprintsCollectionView
 ,  AccessDeniedView) ->
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

    swapToSprints: (sprint_id) ->
      @swap(new OrderView({ collection: new DailyRationsCollection() }))
      Backbone.history.navigate('order/' + sprint_id)

    accessDenied: ->
      @swap(new AccessDeniedView())
      Backbone.history.navigate('/')

    swap: (view) ->
      @changeCurrentView(view)
      @$('#main-area').html(@currentMainView.render().el)

    changeCurrentView: (view) ->
      @currentMainView.leave() if @currentMainView
      @currentMainView = view
