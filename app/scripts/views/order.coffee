define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/dailyRation'
], ($, _, Backbone, JST, DailyRationView) ->
  class OrderView extends Backbone.View
    template: JST['app/scripts/templates/order.hbs']

    tagName: 'div'
    className: 'col-sm-offset-2 col-sm-8 col-sm-offset-2'

    initialize: (dailyRations, dailyMenus) ->
      @childViews = []
      @dailyRations = dailyRations
      @dailyMenus   = dailyMenus
      console.log(@dailyMenus)
      console.log(@dailyRations)
      this.listenTo @dailyRations, 'sync', this.render
      this.listenTo @dailyMenus,   'sync', this.render

    render: ->
      @$el.html @template(dailyMenus: @dailyMenus.toJSON())
      this.renderDailyRations()
      return this

    renderDailyRations: ->
      @dailyRations.each((dailyRation) =>
        view = new DailyRationView(model: dailyRation)
        @childViews.push(view)
        @$('#' + dailyRation.get('daily_menu_id')).append(view.render().el)
      )
