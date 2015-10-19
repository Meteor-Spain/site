console.log "Checking required configuration ..."
if not Meteor.settings
  throw new Meteor.Error 500, "Meteor.settings not found"
if not Meteor.settings.meetup
  throw new Meteor.Error 500, "Meteor.settings.meetup not found"
if not Meteor.settings.meetup.clientId
  throw new Meteor.Error 500, "Meteor.settings.meetup.clientId not found"
if not Meteor.settings.meetup.secret
  throw new Meteor.Error 500, "Meteor.settings.meetup.secret not found"
if not Meteor.settings.meetup.community
  throw new Meteor.Error 500, "Meteor.settings.community not found"
if not Meteor.settings.meetup.community.default
  throw new Meteor.Error 500, "Meteor.settings.community.default not found"
