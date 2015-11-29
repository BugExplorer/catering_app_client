define [
  'jquery'
  'underscore'
  'backbone'
  'templates'
  'channel'
  'views/main'
  'views/sideBar'
  'models/order'
], ($, _, Backbone, JST, channel, MainView, SideBarView, OrderModel) ->
  class FormView extends Backbone.View
    template: JST['app/scripts/templates/form.hbs']

    events:
      'click button': 'submit'

    initialize: (sprint, days) ->
      @childViews = []
      @sprint     = sprint
      @days       = days

      # @sprint.fetch()
      # @days.fetch({ reset: true })

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

    seralizeParams: (elements) ->
      params = {}
      elements.each((i) ->
        dish_price    = parseFloat($(this).attr("dish-price"))
        dish_quantity = parseFloat($(this).val())
        price = (dish_price * dish_quantity).toFixed(2)
        obj = {
          daily_menu_id: $(this).attr("day-id"),
          dish_id:       $(this).attr("dish-id"),
          title:         $(this).attr("dish-title"),
          price:         price,
          quantity:      dish_quantity
        }
        day = obj.daily_menu_id
        unless params[day]
          params[day] = []
        params[day].push(obj)
      )
      return params

    submit: (event) ->
      if $(':checkbox:checked').length == 0
        alert('Please fill order form')
      else
        # Serialize form parameters.
        inputs = $('form input[type=number]:enabled')
        params = this.seralizeParams(inputs)

        # Create and validate collection
        order = new OrderModel(@sprint.get('id'), @days)
        order.set(days: params)
        if order.valid()
          $.post(order.url, days: params)
          .done(() =>
            channel.trigger 'order:submitted', @sprint.get('id')
          )
          .fail(() ->
            channel.trigger 'accessDenied'
          )
