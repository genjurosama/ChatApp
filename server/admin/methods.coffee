Meteor.methods
  removeUserRole: (uid, role)->
    check(uid, String)
    check(role, String)
    Roles.removeUsersFromRoles(uid, [role])
  addUserRole: (uid, role)->
    check(uid, String)
    check(role, String)
    Roles.addUsersToRoles(uid, [role])