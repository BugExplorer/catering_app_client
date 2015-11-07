define [
  'backbone'
], (Backbone) ->
  class CateringRouter extends Backbone.Router
    routes:
      "sessions/new": "login"
      "sprints": "sprints"
      "sprint/:sprint_id": "sprint"
