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

    initialize: (sprint, dailyMenus, api_endpoint) ->
      @sprint = sprint
      @dailyMenus = dailyMenus
      @api_endpoint = api_endpoint
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

      # Setting action attribute on the form
      # Maybe I could create a new model, serialize form and post data via js
      $('#daysContainer').attr('action', @api_endpoint + '/sprints/' + @sprint.get('id') + '/daily_rations')
