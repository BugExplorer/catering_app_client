define [
  'underscore'
  'backbone'
  'models/currentUser'
], (_, Backbone, CurrentUser) ->
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
      errors = 0
      pairs = _.pairs(this.get('days'))
      _.each(pairs, (pair) =>
        dayLimit = @days.get(parseInt(pair[0])).get('max_total')
        totalPrice = 0
        _.each(pair[1], (dish) ->
          totalPrice += parseFloat(dish.price)
        )
        errors += 1 if totalPrice > dayLimit
      )
      console.log(errors)
      return false if errors != 0
      return true
