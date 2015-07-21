Router.configure
  layoutTemplate: 'layout'

Router.route "index",
  path: "/"

Router.route 'signup',
  template: 'signUp'
  name: 'signup'
Router.route 'login',
  template: 'loginSignup'
  layoutTemplate: 'landing'

Router.route "ref/:_id",
  name: 'referralLogin'
  onBeforeAction: ->
    if Cookie.set("CRMRefID",this.params._id, {path: "/", expires: 3600*24*365})
      Router.go("login")
