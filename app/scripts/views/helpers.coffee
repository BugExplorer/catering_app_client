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
      date = new Date(date)
      return date.getDate() + "." + (date.getMonth() + 1) + "." + date.getFullYear()
  )

  Handlebars.registerHelper(
    'day_of_week'
    (day) ->
      days = ["Monday", "Tuesday", "Wednesday", "Thursday"
      , "Friday", "Saturday", "Sunday"]
      days[day]
  )
