Meteor.publish('Chatrooms', function(id) {
  return Chatrooms.find();
});

Meteor.publish('Messages', function(id) {
  return Messages.find();
});