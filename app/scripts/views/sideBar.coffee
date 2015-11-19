define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'
  'channel'

  'views/helpers'
], ($, _, Backbone, JST, ui, channel, Helpers) ->
  class SideBarView extends Backbone.View
    template: JST['app/scripts/templates/sideBar.hbs']

    initialize: (sprint, days) ->
      @sprint = sprint
      @days = days
      this.listenTo @days, "reset", this.render
      # this.listenTo channel, "dayChanged", @changeDay

    # Change current day on the sidebar
    # changeDay: ->

    render: ->
      @$el.html @template(days: @days.toJSON())
      return this

    # renderDays: ->
    #   daysView = new DaysCollectionView({ collection: @days })
    #   daysView.$el = @$('#days')
    #   daysView.render()
    #   daysView.delegateEvents()
    #   return this
