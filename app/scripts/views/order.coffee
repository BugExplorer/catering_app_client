define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'models/currentUser'
  'views/dailyRation'
], ($, _, Backbone, JST, CurrentUser, DailyRationView) ->
  class OrderView extends Backbone.View
    template: JST['app/scripts/templates/order.hbs']

    tagName: 'div'
    className: 'col-sm-offset-2 col-sm-8 col-sm-offset-2'

    initialize: (dailyRations, dailyMenus) ->
      @childViews   = []
      @dailyRations = dailyRations
      @dailyMenus   = dailyMenus

      this.listenTo @dailyRations, 'sync', this.render
      this.listenTo @dailyMenus,   'sync', this.render

    render: ->
      if @dailyRations.length == 0
        @$el.html('<h2 class="text-center">Your order is empty</h2>')
      else
        @$el.html @template(dailyMenus: @dailyMenus.toJSON())
        this.renderDailyRations()
      return this

    renderDailyRations: ->
      @dailyRations.each((dailyRation) =>
        view = new DailyRationView(model: dailyRation.toJSON())
        @childViews.push(view)
        @$('#' + dailyRation.get('daily_menu_id')).append(view.render().el)
      )
