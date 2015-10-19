Template.Login.events
  "click #login-meetup": (event, template) ->
    Meteor.loginWithMeetup 'loginStyle': 'popup', ->
      console.log arguments
