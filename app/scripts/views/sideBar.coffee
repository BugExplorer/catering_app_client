define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'
  'channel'

  'views/sideBarDish'
  'views/helpers'
], ($, _, Backbone, JST, ui, channel, SideBarDishView, Helpers) ->
  class SideBarView extends Backbone.View
    template: JST['app/scripts/templates/sideBar.hbs']

    initialize: (sprint, days) ->
      @childViews = []
      @sprint = sprint
      @days = days
      this.listenTo @days, "reset", this.render
      this.listenTo channel, "sideBar:dishAdded", @addDish
      this.listenTo channel, "sideBar:dishRemoved", @removeDish

    # Append dish to the sidebar (after day title)
    addDish: (dish, day_number) ->
      view = new SideBarDishView(model: dish)
      @childViews.push(view)
      @$("#" + day_number).append(view.render().el)

    # Remove dish from the sidebar
    removeDish: (dish, day_number) ->
      @$("#" + day_number).children("#dish-" + dish.id).remove()

    render: ->
      @$el.html @template(days: @days.toJSON())
      return this
