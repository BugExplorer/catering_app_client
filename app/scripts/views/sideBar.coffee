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
      # To prevent zombie views
      @childViews.push(view)
      @$("#" + day_number).append(view.render().el)
      # console.log(dish)
      console.log(day_number)

    # Remove dish from the sidebar
    removeDish: (dish, day_number) ->
      console.log(@$("#" + day_number))
      @$("#" + day_number).children("#" + dish.id + ".side-bar-dish").remove()
      # console.log(dish)
      # console.log(day_number)

    render: ->
      @$el.html @template(days: @days.toJSON())
      return this
