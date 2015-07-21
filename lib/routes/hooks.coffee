###
* Hook: Check if a User is Logged In
* If a user is not logged in and attempts to go to an authenticated route,
* re-route them to the login screen.
###

checkUserLoggedIn = ->
  if !Meteor.loggingIn() and !Meteor.user()
    Router.go 'login'
  else
    @next()
  return

###
* Hook: Check if a User Exists
* If a user is logged in and attempts to go to a public route, re-route
* them to the index path.
###

userAuthenticated = ->
  if !Meteor.loggingIn() and Meteor.user()
    Router.go 'index'
  else
    @next()
  return

checkUserRights = ->
  rn = this.route.getName()
  #console.log rn, rn.split(".")[0], rn.replace(/[A-Z]/, ".").split(".")[0]
  rolesArr = false
  if rolesPermissions[rn]
    rolesArr = rolesPermissions[rn]
  if rolesPermissions[rn.split(".")[0]+"."]
    rolesArr = rolesPermissions[rn.split(".")[0]+"."]
  if rolesPermissions[rn.replace(/[A-Z]/, ".").split(".")[0]+"."]
    rolesArr = rolesPermissions[rn.replace(/[A-Z]/, ".").split(".")[0]+"."]
  if rolesArr && !Roles.userIsInRole(Meteor.userId(), rolesArr)
    Bert.alert "You have no permission to access this page", 'danger'
    Router.go 'index'

  @next()


###
* Run Hooks
###



Router.onBeforeAction checkUserLoggedIn, except: [
  'signup'
  'login'
  'recover-password'
  'reset-password'
  'ref'
]

Router.onBeforeAction userAuthenticated, only: [
  'signup'
  'login'
  'recover-password'
  'reset-password'
  'ref'
]

Router.onBeforeAction checkUserRights, except: [
  'signup'
  'login'
  'recover-password'
  'reset-password'
  'ref'
]


@rolesPermissions = {
  "client.":
    ['admin','processor','salesRep']
  "clients.":
    ['admin','processor','salesRep']
  "admin.":
    ['admin']
  "leads.":
    ['admin','processor','salesRep']
}
