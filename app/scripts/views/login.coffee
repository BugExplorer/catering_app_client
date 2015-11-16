define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'channel'
], ($, _, Backbone, JST, channel) ->
  class LoginView extends Backbone.View
    template: JST['app/scripts/templates/login.hbs']

    # el: '#container'

    events:
      'click button': 'submit'

    initialize: ->
      @listenTo @model, 'error', @renderError
      @listenTo @model, 'sync', @triggerLoggedIn

    renderError: ->
      @$('.alert').html('Credentials are not valid').show()

    triggerLoggedIn: ->
      channel.trigger("user:loggedIn",
                       @model.get('auth_token'),
                       @model.get('name'))

    render: ->
      @$el.html @template()
      return this

    submit: (event) ->
      event.preventDefault()
      @model.set email: @$('#email').val()
      @model.set password: @$('#password').val()
      @model.save()

      return false
