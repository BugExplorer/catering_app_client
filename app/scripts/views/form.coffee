define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/sprint'
  'views/days'
  'views/panel'

  'collections/dailyRations'
], ($, _, Backbone, JST, SprintView, DaysCollectionView, PanelView, DailyRationsCollection) ->
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
      return this

    renderPanel: ->
      panelView = new PanelView()
      panelView.$el = @$('#user_panel')
      panelView.render()
      panelView.delegateEvents()
      return this

    renderSprint: ->
      sprintView = new SprintView(@sprint)
      sprintView.$el = @$('#sprint')
      @sprint.fetch().then(() ->
        sprintView.render()
      )
      return this

    renderDays: ->
      daysView = new DaysCollectionView(@days)
      daysView.$el = @$('#days')
      @days.fetch().then(() ->
        daysView.render()
        daysView.delegateEvents()
      )
      return this

    submit: (event) ->
      # Without that submit event start multiplying on the submit button
      this.undelegateEvents()

      params = @$(event.currentTarget).serialize()
      # Send params to a daily rations collection
      # That sends a POST request and sets attributes from the response

      dailyRations = new dailyRationsCollection(@sprint.get('id'))
      dailyRations.save(params,
        success: # Todo: make some message
          Backbone.history.navigate('sprints', { trigger: true })
      )

      return false
