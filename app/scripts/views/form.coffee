define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/sprint'
  'views/days'

  'collections/dailyRations'
], ($, _, Backbone, JST, SprintView, DaysCollectionView, DailyRationsCollection) ->
  class FormView extends Backbone.View
    template: JST['app/scripts/templates/form.hbs']

    events:
      'click button': 'submit'

    initialize: (sprint, days) ->
      @sprint = sprint
      @sprint.fetch()
      @days = days
      @days.fetch({ reset: true })

    render: ->
      @$el.html @template()

      this.renderSprint()
      this.renderDays()
      return this

    renderSprint: ->
      sprintView = new SprintView({ model: @sprint })
      sprintView.$el = @$('#sprint')
      sprintView.render()
      return this

    renderDays: ->
      daysView = new DaysCollectionView({ collection: @days })
      daysView.$el = @$('#days')
      daysView.render()
      daysView.delegateEvents()
      return this

    submit: (event) ->
      # Without that submit event start multiplying on the submit button
      this.undelegateEvents()

      # Serialize form parameters that has multi-arrays in them.
      params = @$('form').serialize()
      params = params.replace(/%5B/g,"[")
      params = params.replace(/%5D/g,"]")

      # Send params to a daily rations collection
      # That sends a POST request and sets attributes from the response
      dailyRations = new DailyRationsCollection(@sprint.get('id'))
      dailyRations.fetch(data: params, type: 'POST')
