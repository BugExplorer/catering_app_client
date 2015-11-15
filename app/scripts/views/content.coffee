define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'channel'

  'collections/sprints'

  'views/sprints'
], ($, _, Backbone, JST, channel, SprintsCollection, SprintsCollectionView) ->
  class ContentView extends Backbone.View
    className: 'row'

    template: JST['app/scripts/templates/content.hbs']

    render: ->
      @$el.html(@template())
      return this

    initialize: ->
      @listenTo channel, "user:loggedIn", @swapToSprints

    swapToSprints: ->
      console.log("Swap")
      @swap(new SprintsCollectionView({ collection: new SprintsCollection() }))

    swap: (view) ->
      @changeCurrentView(view)
      @$('#main-area').html(@currentMainView.render().el)

    changeCurrentView: (view) ->
      @currentMainView.leave() if @currentMainView
      @currentMainView = view
