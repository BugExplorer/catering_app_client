define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/mainFormView'
  'views/sideBarView'

  'collections/dailyRations'
], ($, _, Backbone, JST, MainFormView, SideBarView, DailyRationsCollection) ->
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
      this.renderMainView()
      this.renderSideBarView()
      return this

    renderMainView: ->
      mainView = new MainFormView(@sprint, @days)
      mainView.$el = @$('#main')
      mainView.render()
      mainView.delegateEvents()
      return this

    renderSideBarView: ->
      sideBarView = new SideBarView(@sprint, @days)
      sideBarView.$el = @$('#side')
      sideBarView.render()
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
