define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/sprint'
  'views/dailyMenus'
  'views/panel'

  'models/order'
], ($, _, Backbone, JST, SprintView, DailyMenusCollectionView, PanelView, OrderModel) ->
  class DailyRationsFormView extends Backbone.View
    template: JST['app/scripts/templates/dailyRationsForm.hbs']

    el: '#container'

    panel: new PanelView()

    events:
      'submit form.dailyRations': 'submit'

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
      @sprintView.$el = @$('#sprint')
      @sprintView.render()

      # Render form tabs
      @dailyMenusView.$el = @$('#dailyMenus')
      @dailyMenusView.render()
      @dailyMenusView.delegateEvents()

    submit: (event) ->
      # Without that submit event start multiplying on the submit button
      this.undelegateEvents()

      creds = @$(event.currentTarget).serialize()
      # Send params to a separate model, that sends POST to the server
      order = new OrderModel(@sprint.get('id'))
      order.save(creds).then(() ->
        # Todo: make some message
        Backbone.history.navigate('sprints', {trigger: true})
      )

      return false
