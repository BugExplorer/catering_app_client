define [
  'underscore'
  'backbone'
  'models/sprint'
], (_, Backbone, SprintModel) ->

  class SprintsCollection extends Backbone.Collection
    model: SprintModel
