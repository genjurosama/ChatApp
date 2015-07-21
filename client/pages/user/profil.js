
Template.profileEdit.created = function() {
  Session.set('userEditErrors', {});
};



Template.profileEdit.rendered= function (){

  //this is to preselect the gender dropdownlist
  $("#genderDropdown").find('option').each(function( i, opt ) {
    if( opt.value === Meteor.user().profile.gender) {
        $(opt).attr('selected', 'selected');
    }
  }

  );

  $("#phone").keypress(function (e) {
     //if the letter is not digit then display error and don't type anything
     if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
        //display error message
       // $("#errmsg").html("Digits Only").show().fadeOut("slow");
               return false;
    }
   });

};

//defining the error helpers

Template.profileEdit.helpers({
  errorMessage: function(field) {
    return Session.get('userEditErrors')[field];
  },
  errorClass: function (field) {
    return !!Session.get('userEditErrors')[field] ? 'has-error' : '';
  },
  currentuser : function (){
    return Meteor.user();
  }
});
Template.profile.helpers({
  userHasStripe: function(){
    return !Meteor.user().profile.stripe;
  }
});
Template.profile.events({
  'click .btn-stripe': function(e) {
    var popup = window.open('', 'BigDataCandy', 'scrollbars=1,width=1024,height=768');
    popup.location = "https://connect.stripe.com/oauth/authorize?response_type=code&client_id=ca_5ySHoQBlMKYSBN5dYD4GqcJjPFsj0V9A&scope=read_write";
  }
});

Template.profileEdit.events({
    'click #avatar': function (e) {
        console.log("avatar clicked");
        e.preventDefault();
        $('#editYourAvatarModal').modal();
    },
    'click #genApi':function(e) {
      e.preventDefault();
      apiKey = generateUUID();
      user=Meteor.user();
      console.log(apiKey);
      Meteor.users.update({_id:Meteor.userId()},{$set:{'profile.apiKey':apiKey}});
    }


}
);

//validating the user information on client side
validateUser = function (profil) {
  var errors = {};
  if (!profil.firstname)
    errors.firstname= "Please fill in a first name";
  if (!profil.lastname)
    errors.lastname=  "Please fill in a last name";
  if (!profil.gender)
    errors.gender=  "Please fill choose a gender";

  return errors;
}


//function that updates the profile

function updateProfil(e){

  e.preventDefault();
      var currentuserId = Meteor.userId();
      //retreiving the user attributes from web fields
      var userProperties = {
      firstname: $("#firstname").val(),
      lastname: $("#lastname").val(),
      gender: $("#genderDropdown").val(),
      billingadress:$("#billingadress").val(),
      mailingadress:$("#mailingadress").val(),
      phone:$("#phone").val(),
      skypeaccount:$("#skypeaccount").val()
    }

    // user validation

   
    fullname = userProperties.firstname+' '+userProperties.lastname;

    Meteor.users.update({_id:Meteor.userId()}, { $set:        {"profile.firstname":userProperties.firstname,"profile.lastname":userProperties.lastname,"profile.gender":userProperties.gender,"profile.name":fullname,
 "profile.billingadress":userProperties.billingadress,"profile.mailingadress":userProperties.mailingadress,"profile.phone":userProperties.phone,"profile.skypeaccount":userProperties.skypeaccount}},
    function(error) { if (error) {
        // display the error to the user
         Bert.alert("Profile successfuly edited", 'danger', 'growl-top-right');
      } else {
        Bert.alert("Profile successfuly edited", 'success', 'growl-top-right');
      }
    });

}

//intializing the autoComplete for adress

var initAutoComplete = function() {
     new google.maps.places.Autocomplete(
    (document.getElementById('billingadress')),{types: ['geocode'] }
  );
    new google.maps.places.Autocomplete(
    (document.getElementById('mailingadress')),{types: ['geocode'] }
  );
};



function generateUUID () {
  var d, uuid;
  d = (new Date).getTime();
  uuid = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
    var r;
    r = (d + Math.random() * 16) % 16 | 0;
    d = Math.floor(d / 16);
    return (c === 'x' ? r : r & 0x3 | 0x8).toString(16);
  });
  return uuid;
};
