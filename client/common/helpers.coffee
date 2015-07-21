String::startsWith ?= (s) -> @[...s.length] is s

Template.registerHelper "activeRoute", ->
  currentRoute = Router.current().route?.getName()
  return "" unless currentRoute
  isRoute = currentRoute == @?.path
  isPrefix = @.prefix and (currentRoute.startsWith @.prefix)
  return "active" if isRoute or isPrefix

Template.registerHelper "userName", (id)->
  return getUsername(id)

Template.registerHelper "myUserName", (id)->
  if !id
    id = Meteor.userId()
  return getUsername(id)


Template.registerHelper "equals", (a, b)->
  return a == b


Template.registerHelper 'concat', ()->
  return Array.prototype.slice.call(arguments, 0, -1).join('');

Template.registerHelper 'field2label', (fieldName)->
  return field2label(fieldName)

Template.registerHelper "activeRoute", ->
  currentRoute = Router.current().route?.getName()
  return "" unless currentRoute
  isRoute = currentRoute == @?.path
  isPrefix = @.prefix and (currentRoute.startsWith @.prefix)
  return "active" if isRoute or isPrefix

Template.registerHelper "share_url", ->
  genShareUrl()

Template.registerHelper "share_urlencoded", ->
  url = genShareUrl()
  encodeURIComponent url if url

Template.registerHelper 'linebreaksbr', (input) ->
  nl2br = (input + '').replace(/([^>\r\n]?)(\r\n|\n\r|\r|\n)/g, '$1' + '<br>' + '$2');
  return new Spacebars.SafeString(nl2br);

Template.registerHelper 'formatDateTime', (rawDate, formatString) ->
  if !_.isDate(rawDate)
    return ''
  if _.isString(formatString)
    moment(rawDate).format formatString
  else
    moment(rawDate).format()

Template.registerHelper 'truncateChars', (input, length) ->
  if !_.isString(input)
    return ''
  if !_.isFinite(length)
    return input
  input.substring 0, length

Template.registerHelper 'getField', (field, collection, id) ->
  return window[collection].findOne({_id:id})[field]

Template.registerHelper 'isUserInRole', (role) ->
  return isUserInRole Meteor.userId(), role

Template.registerHelper 'conditionHelper', (bVar, ifTrue, ifFalse) ->
  if bVar
    return ifTrue
  else
    return ifFalse

#NON-template
@widgetToggle = ->
  $('.actions > .fa-chevron-up').click ->
    $(this).parent().parent().parent().next().slideToggle('fast')
    $(this).toggleClass('fa-chevron-down fa-chevron-up')
    return
  return


genShareUrl = ->
  referralPath = "ref/"+Meteor.userId()
  return Meteor.absoluteUrl referralPath

@field2label = (fieldName)->
  label = fieldName
  lastPeriod = label.lastIndexOf(".")
  if lastPeriod != -1
    label = label.substring(lastPeriod + 1)
    if label == "$"
      pcs = fieldName.split(".")
      label = pcs[pcs.length - 2]
  if label == "_id"
    return "ID"
  return S(label).humanize().s

isUserInRole = (uid, role)->
  rows = Meteor.roles.find({name:new RegExp("^"+role+".*")}).fetch()
  roles = []
  i=0
  while i<rows.length
    roles.push(rows[i].name);
    i++
  return Roles.userIsInRole(uid, roles)

@getUsername = (id)->
  usr = Meteor.users.findOne _id:id
  return profile2Username(usr)

@profile2Username = (usr)->
  if !usr
    return ""
  if !usr.profile.lastname
    usr.profile.lastname=''
  return usr.profile.lastname+" "+usr.profile.firstname