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
