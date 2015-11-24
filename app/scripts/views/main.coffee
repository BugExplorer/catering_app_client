define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'jquery_ui'

  'views/sprint'
  'views/formDays'

  'views/helpers'
], ($, _, Backbone, JST, ui, SprintView, FormDaysCollectionView, Helpers) ->
  class MainFormView extends Backbone.View
    template: JST['app/scripts/templates/main.hbs']

    initialize: (sprint, days) ->
      @childViews = []
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
      # To prevent zombie views
      @childViews.push(sprintView)
      sprintView.render()
      sprintView.delegateEvents()
      return this

    renderDays: ->
      daysView = new FormDaysCollectionView({ collection: @days })
      daysView.$el = @$('#days')
      # To prevent zombie views
      @childViews.push(daysView)
      daysView.render()
      daysView.delegateEvents()
      return this
