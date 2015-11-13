define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/sprint'
  'views/days'
  'views/panel'

  'models/order'
], ($, _, Backbone, JST, SprintView, DaysCollectionView, PanelView, OrderModel) ->
  class FormView extends Backbone.View
    template: JST['app/scripts/templates/form.hbs']

    el: '#container'

    events:
      'submit form.order': 'submit'

    initialize: (sprint, days, apiEndpoint) ->
      @sprint = sprint
      @days = days
      @apiEndpoint = apiEndpoint

    render: ->
      @$el.html @template()

      this.renderPanel()
      this.renderSprint()
      this.renderDays()
      @

    renderPanel: ->
      panelView = new PanelView()
      panelView.$el = @$('#user_panel')
      panelView.render()
      panelView.delegateEvents()
      @

    renderSprint: ->
      sprintView = new SprintView(@sprint)
      sprintView.$el = @$('#sprint')
      @sprint.fetch().then(() ->
        sprintView.render()
      )
      @

    renderDays: ->
      daysView = new DaysCollectionView(@days)
      daysView.$el = @$('#days')
      @days.fetch().then(() ->
        daysView.render()
        daysView.delegateEvents()
      )
      @

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
