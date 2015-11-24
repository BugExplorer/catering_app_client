define [
  'underscore'
  'backbone'

  'models/currentUser'

  'models/formDay'
], (_, Backbone, CurrentUser, FormDayModel) ->

  class FormDaysCollection extends Backbone.Collection
    url: 'form_contents'

    model: FormDayModel

    initialize: () ->
      $.ajaxPrefilter( (options, originalOptions, jqXHR) ->
        options.xhrFields = { withCredentials: true }

        if CurrentUser.get('auth_token')
          jqXHR.setRequestHeader('X-Auth-Token', CurrentUser.get('auth_token'))
      )
