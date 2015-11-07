define [
  'handlebars'
], (Handlebars) ->
  Handlebars.registerHelper(
    'state_class'
    (state) ->
      css_classes =
        running: 'btn-success'
        closed: 'btn-info'

      return css_classes[state]
  )

  Handlebars.registerHelper(
    'to_date_format'
    (date) ->
      _date = new Date(date)
      return _date.getDate() + "." + (_date.getMonth() + 1) + "." + _date.getFullYear()
  )

  Handlebars.registerHelper(
    'day_of_week'
    (day) ->
      _days = ["Monday", "Tuesday", "Wednesday", "Thursday"
      , "Friday", "Saturday", "Sunday"]
      _days[day - 1]
  )
