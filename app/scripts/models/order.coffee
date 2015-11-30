define [
  'underscore'
  'backbone'
  'channel'
  'models/currentUser'
], (_, Backbone, channel, CurrentUser) ->
  class OrderModel extends Backbone.Model
    initialize: (sprintId, days) ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if CurrentUser.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', CurrentUser.get('auth_token'))
      )
      @sprintId = sprintId
      @days     = days
      @url      = 'sprints/' + @sprintId + '/daily_rations'

    valid: () ->
      errors = {}
      pairs = _.pairs(this.get('days'))
      errors.sideNav = "Please, fill the form" if _.isEmpty(pairs)
      _.each(pairs, (pair) =>
        dayId = parseInt(pair[0])
        dayLimit = @days.get(dayId).get('max_total')
        totalPrice = 0
        _.each(pair[1], (dish) ->
          totalPrice += parseFloat(dish.price)
        )
        errors[dayId] = "Order total is bigger than limit" if totalPrice > dayLimit
      )
      return true if _.isEmpty(errors)
      channel.trigger('form:invalid', errors)
      return false
