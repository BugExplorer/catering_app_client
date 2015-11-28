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
      @childViews  = []
      @sprint      = sprint
      @days        = days

      this.listenTo @days,   'reset', this.render
      this.listenTo channel, 'sideBar:dishAdded', @addDish
      this.listenTo channel, 'sideBar:dishRemoved', @removeDish

    # Append dish to the sidebar (after day title)
    addDish: (dish) ->
      dayId = dish.get('day_id')
      view = new SideBarDishView(dish, @days.get(dayId))
      @childViews.push(view)

      # To make slide animation via JQuery
      rendered_view = view.render().el
      $(rendered_view).css('display', 'none')
      $(rendered_view).appendTo(@$('#' + dayId)).slideDown(250)

    # Remove dish view from the sidebar and trigger price validation event
    removeDish: (dish) ->
      @$('#' + dish.get('day_id')).children('#dish-' + dish.id).slideUp(200, () ->
        # Remove dish when animation is complete
        channel.trigger('sideBarDish:leave', $(this).attr('view'))
        this.remove()
      )

    render: ->
      @$el.html @template(days: @days.toJSON())
      @childViews = []
      return this
