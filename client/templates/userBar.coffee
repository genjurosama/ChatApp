Template.userBar.events 'click .logout': ->
  Meteor.logout (error) ->
    if error
      Bert.alert error.reason, 'danger'
    else
      Bert.alert 'Succesfully logged out!', 'success'
    return
  return

Template.userBar.rendered = ()->
  console.log("userbar render")
  $('#toggle-right').on 'click', ->
    $('#sidebar-right').toggleClass 'sidebar-right-open'
    $('#toggle-right .fa').toggleClass 'fa-indent fa-dedent'
    return