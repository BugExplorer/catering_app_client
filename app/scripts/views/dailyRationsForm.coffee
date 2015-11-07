define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/sprint'
  'views/dailyMenus'
  'views/panel'
], ($, _, Backbone, JST, SprintView, DailyMenusCollectionView, PanelView) ->
  class DailyRationsFormView extends Backbone.View
    template: JST['app/scripts/templates/dailyRationsForm.hbs']

    el: '#container'

    panel: new PanelView()

    initialize: (sprint, dailyMenus) ->
      @sprint = sprint
      @dailyMenus = dailyMenus
      @sprintView = new SprintView(@sprint)
      @dailyMenusView = new DailyMenusCollectionView(@dailyMenus)

    render: ->
      @$el.html @template()

      @panel.$el = @$('#user_panel')
      @panel.render()
      @panel.delegateEvents()

      # Render sprint date
      @sprintView.$el = @$('#sprintContainer')
      @sprintView.render()

      # Render form tabs
      @dailyMenusView.$el = @$('#daysContainer')
      @dailyMenusView.render()
