define [
  'jquery'
  'underscore'
  'backbone'
  'templates'

  'views/helpers'
], ($, _, Backbone, JST, Helpers) ->
  class SprintView extends Backbone.View
    template: JST['app/scripts/templates/sprint.hbs']

    initialize: (sprint) ->
      @sprint = sprint
      @sprint.bind("sync", this.render, this)

    render: ->
      @$el.html @template(sprint: @sprint.toJSON())
