Meteor.subscribe("Chatrooms");
Meteor.subscribe("Messages");

Template.chatroomsList.events({
  "click #createRoom": function (e){
    e.preventDefault();
    console.log($("#roomName").val());
    roomName = $("#roomName").val();
    Chatrooms.insert({name:roomName,createdBy:Meteor.userId(),author:Meteor.user().profile.name});
    $("#roomName").val("");
  }
});

Template.roomslist.helpers({
  rooms: function (e){
    return Chatrooms.find();

  }
});


Template.chat.helpers({
  messages: function (e){
    return Messages.find({roomId:this._id});

  }
});

Template.chat.events({
  "click #sendMessage": function (e){
    message = $("#message").val();
    console.log(message);
    Messages.insert({text:message,uid:Meteor.userId,roomId:this._id,createdBy:Meteor.userId(),author:Meteor.user().profile.name})

  }
});

Template.roomslist.events({
  "click #deleteRoom": function (e){
    currentId=this._id;
    swal({   title: "Are you sure?",
      text: "You will not be able to recover this Chatroom!",
      type: "warning",
      showCancelButton: true,
      confirmButtonColor: "#DD6B55",
      confirmButtonText: "Yes, delete it!",
      cancelButtonText: "No, cancel plx!",
      closeOnConfirm: false,   closeOnCancel: false },
        function(isConfirm){   if (isConfirm) {
          Chatrooms.remove({_id:currentId},function(result,error){
            if(!error){
              swal("Deleted!", "Your imaginary file has been deleted.", "success");
            }
            else{
              swal("Cancelled", "Your imaginary file is safe :)", "error");
            }
          })
           } });

  },
  "click #accessRoom": function(e){
    console.log("access");
    Router.go('rooms', {_id: this._id}, {query: 'q=s', hash: 'hashFrag'});
  }
});