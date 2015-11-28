define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'channel'
  'views/main'
  'views/sideBar'

  'collections/dailyRations'
], ($, _, Backbone, JST, channel, MainView, SideBarView, DailyRationsCollection) ->
  class FormView extends Backbone.View
    template: JST['app/scripts/templates/form.hbs']

    events:
      'click button': 'submit'

    initialize: (sprint, days) ->
      @childViews = []
      @sprint     = sprint
      @days       = days
      @sprint.fetch()
      @days.fetch({ reset: true })

    render: ->
      @$el.html @template()
      this.renderMainView()
      this.renderSideBarView()
      return this

    renderMainView: ->
      mainView = new MainView(@sprint, @days)
      mainView.$el = @$('#main')
      # To prevent zombie views
      @childViews.push(mainView)
      mainView.render()
      mainView.delegateEvents()
      return this

    renderSideBarView: ->
      sideBarView = new SideBarView(@sprint, @days)
      sideBarView.$el = @$('#side')
      # To prevent zombie views
      @childViews.push(sideBarView)
      sideBarView.render()
      return this

    submit: (event) ->
      if $('li.error')[0]
        alert('Please check form errors.')
      else if $(':checkbox:checked').length == 0
        alert('Please check dishes')
      else
        # Serialize form parameters that has multi-arrays in them.
        params = @$('form').serialize()
        params = params.replace(/%5B/g,'[')
        params = params.replace(/%5D/g,']')

        # Send params to a daily rations collection
        # That sends a POST request and sets attributes from the response
        dailyRations = new DailyRationsCollection(@sprint.get('id'))
        dailyRations.fetch(
          reset: true
          data: params
          type: 'POST'
          success: (collection) ->
            # Show order summary
            channel.trigger 'order:submitted', collection
          error: () ->
            channel.trigger 'accessDenied'
        )
