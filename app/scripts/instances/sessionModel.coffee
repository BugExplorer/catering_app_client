define [
  'models/session'
], (Session) ->
  if sessionModel == undefined
    sessionModel = new Session()

  return sessionModel
