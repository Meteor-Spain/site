console.log "Configuring meetup login"
ServiceConfiguration.configurations.upsert { service: 'meetup' }, $set:
  clientId: Meteor.settings.meetup.clientId
  loginStyle: 'popup'
  secret: Meteor.settings.meetup.secret

Accounts.onCreateUser (options, user) ->
  community   = Meteor.settings.meetup.community.default.name
  adminRoles  = Meteor.settings.meetup.community.default.admin_roles
  accessToken = user.services.meetup.accessToken

  result = undefined
  id = user.services.meetup.id
  try
    result = Meteor.http.get(
      'https://api.meetup.com/2/profiles.json/?member_id=' + id,
      headers:
        'User-Agent': 'Meteor/1.0'
        'Authorization': 'Bearer ' + accessToken)
  catch error
    throw error

  profile = result.data.results.filter (prof) ->
    prof.group.urlname == community

  if !profile
    throw new (Meteor.Error)(503, 'The user has to belong to Meetup Community')
  user.profile = profile[0]
  return user
