define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/sprint'
  'views/days'

  'views/helpers'
], ($, _, Backbone, JST, ui, SprintView, DaysCollectionView, Helpers) ->
  class MainFormView extends Backbone.View
    template: JST['app/scripts/templates/main.hbs']

    className: "container-fluid"

    initialize: (sprint, days) ->
      @sprint = sprint
      @days = days

    render: ->
      @$el.html @template()
      this.renderSprint()
      this.renderDays()
      return this

    renderSprint: ->
      sprintView = new SprintView({ model: @sprint })
      sprintView.$el = @$('#sprint')
      sprintView.render()
      sprintView.delegateEvents()
      return this

    renderDays: ->
      daysView = new DaysCollectionView({ collection: @days })
      daysView.$el = @$('#days')
      daysView.render()
      daysView.delegateEvents()
      return this
