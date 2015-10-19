# GLOBAL SETTINGS
# -----------------------------------------------------------------------------

# SUBSCRIPTIONS
FlowRouter.subscriptions = ->
  # this.register('mySub', Meteor.subscribe('mySubName'));
  return

# TRIGGERS
FlowRouter.triggers.enter []
FlowRouter.triggers.exit []

# ROUTES - PUBLIC
# -----------------------------------------------------------------------------
FlowRouter.route '/',
  name: 'index'
  triggersEnter: []
  subscriptions: (params, queryParams) ->
  action: (params, queryParams) ->
    BlazeLayout.render 'LayoutDefault', content: 'Home'
  triggersExit: []

FlowRouter.route '/login',
  name: 'login'
  triggersEnter: [->
    if Meteor.userId()
      if Session.get 'redirectAfterLogin'
        FlowRouter.go Session.get 'redirectAfterLogin'
      else
        FlowRouter.go 'index'
  ]
  subscriptions: (params, queryParams) ->
  action: (params, queryParams) ->
    BlazeLayout.render 'Login'
  triggersExit: []

# ROUTES - REQUIRE USER
# -----------------------------------------------------------------------------
loggedIn = FlowRouter.group
  triggersEnter: [ ->
    unless Meteor.loggingIn() or Meteor.userId()
      route = FlowRouter.current()

      unless route.route.name is 'login'
        Session.set 'redirectAfterLogin', route.path

      FlowRouter.go 'login'
  ]

# ROUTES - REQUIRE USER
# -----------------------------------------------------------------------------
loggedIn.route '/admin',
  name: 'admin'
  triggersEnter: []
  subscriptions: (params, queryParams) ->
  action: (params, queryParams) ->
    BlazeLayout.render 'LayoutAdmin', content: 'AdminDashboard'
  triggersExit: []
