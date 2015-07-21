Template.landing.rendered = (e, tpl)->
  $('#page-loader').fadeOut(1500)


#LOGIN#
Template.signUp.events
  "submit form": (e, tpl) ->
    e.preventDefault()
Template.logIn.events
  "submit form": (e, tpl) ->
    e.preventDefault()


Template.signUp.rendered = ->
  $form = $('#sign-up-form')
  $('#sign-up-form').validate
    rules:
      email:
        required: true,
        email: true
      pass:
        required: true,
        minlength: 6
    messages:
      email:
        required: "Please enter your email address to sign up.",
        email: "Please enter a valid email address."
      pass:
        required: "Please enter a password to sign up.",
        minlength: "Please use at least six characters."
    submitHandler: ->
      # Grab the user's details.
      user =
        email: $form.find('[name="email"]').val()
        password: $form.find('[name="pass"]').val()
        name: $form.find('[name="name"]').val()
      profile = {}
      if Cookie.get("CRMRefID")
        profile.affiliate = Cookie.get("CRMRefID")

      Meteor.call 'registerUser', user, profile, (err, data) ->
        return Bert.alert(err.reason, 'danger') if err

        Meteor.loginWithPassword user.email, user.password, (err)->
          if err
            Bert.alert(err.reason, 'danger');
          else
            Router.go('index')



Template.logIn.helpers
  reset_password: -> Session.get('reset_password')
Template.logIn.helpers
  reseting_status: -> Session.get('reseting_status')

Template.logIn.events
  "click .btn-reset-password": (e, tpl) ->
    e.preventDefault()
    Session.set('reset_password', true)
  "click .btn-unreset-password": (e, tpl) ->
    e.preventDefault()
    Session.set('reset_password', false)

Template._loginForm.rendered = ->
  $form = $('#log-in-form')
  console.log $form
  $('#log-in-form').validate
    rules:
      email:
        required: true,
        email: true
      pass:
        required: true,
    messages:
      emailAddress:
        required: "Please enter your email address to login.",
        email: "Please enter a valid email address."
      password:
        required: "Please enter your password to login."
    submitHandler: ->
      # Grab the user's details.
      user =
        email: $form.find('[name="email"]').val()
        password: $form.find('[name="pass"]').val()

      # Log the user in.
      Meteor.loginWithPassword user.email, user.password, (err)->
        if err
          Bert.alert(err.reason, 'danger');
        else
          Bert.alert('Logged in!', 'success');
          Router.go('index')

Template._forgotForm.rendered = ->
  $reset = $('#reset-form')
  $reset.validate
    rules:
      email:
        required: true,
        email: true
    messages:
      emailAddress:
        required: "Please enter your email address to login.",
        email: "Please enter a valid email address."
    submitHandler: ->
      user =
        email: $reset.find('[name="email"]').val()
      Session.set "reseting_status", "Resetting password..."
      Accounts.forgotPassword user, (err)->
        if err
          Session.set "reseting_status", false
          Bert.alert(err.reason, 'danger');
        else
          Session.set "reseting_status", "We've sent you and email with instructions"


