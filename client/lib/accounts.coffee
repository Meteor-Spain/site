Accounts.onLogin ->
  redirect = Session.get 'redirectAfterLogin'

  if redirect?
    unless redirect is '/login'
      FlowRouter.go redirect
