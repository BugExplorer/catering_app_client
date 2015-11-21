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
    addDish: (dish, day_id) ->
      view = new SideBarDishView(model: dish)
      @childViews.push(view)
      $(view.render().el).appendTo(@$("#" + day_id)).slideDown(250)

    # Remove dish from the sidebar
    removeDish: (dish, day_id) ->
      @$("#" + day_id).children("#dish-" + dish.id).slideUp(200, () ->
        # Remove dish when animation is complete
        this.remove()
      )

    render: ->
      @$el.html @template(days: @days.toJSON())
      return this
