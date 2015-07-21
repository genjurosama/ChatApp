Router.route "chatrooms",
  onBeforeAction: ->
    Router.go("chatrooms.list")

Router.route "chatrooms.list"

Router.route '/room/:_id',
  name: 'rooms'
  action: ->
    @render 'chat', data: ->
      console.log 'id' + @params._id
      Chatrooms.findOne _id: @params._id
    return