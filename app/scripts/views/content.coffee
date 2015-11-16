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

    render: ->
      @$el.html(@template())
      return this

    initialize: ->
      @listenTo channel, "user:loggedIn", @swapToSprints
      @listenTo channel, "accessDenied", @accessDenied

    accessDenied: ->
      @swap(new AccessDeniedView())

    swapToSprints: ->
      @swap(new SprintsCollectionView({ collection: new SprintsCollection() }))
      Backbone.history.navigate("sprints")

    swap: (view) ->
      @changeCurrentView(view)
      @$('#main-area').html(@currentMainView.render().el)

    changeCurrentView: (view) ->
      @currentMainView.leave() if @currentMainView
      @currentMainView = view
