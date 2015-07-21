Template.index.helpers
  getEvents: ()->
    [
      {
        action: "Test timeline"
        title: "to see how is it look like"
        date: moment().toDate()
      },
      {
        action: "Note deleted"
        title: "Test"
        date: moment().subtract(1, 'days').toDate()
      },
      {
        action: "Note edited"
        title: "Test"
        date: moment().subtract(2, 'days').toDate()
      },
      {
        action: "Note added"
        title: "Test"
        date: moment().subtract(2, 'days').toDate()
      },
      {
        action: "Attachment deleted"
        title: "report04-23-2015.pdf"
        date: moment().subtract(3, 'days').toDate()
      },
      {
        action: "Attachment uploaded"
        title: "report04-23-2015.pdf"
        date: moment().subtract(4, 'days').toDate()
      },
      {
        action: "Note deleted"
        title: "New note about client"
        date: moment().subtract(11, 'days').toDate()
      },
      {
        action: "Note added"
        title: "New note about client"
        date: moment().subtract(13, 'days').toDate()
      },
      {
        action: "Profile edited"
        title: "Testberg Clientie"
        date: moment().subtract(30, 'days').toDate()
      },
      {
        action: "Profile edited"
        title: "Testberg Clientie"
        date: moment().subtract(34, 'days').toDate()
      },
      {
        action: "Profile edited"
        title: "Testberg Clientie"
        date: moment().subtract(35, 'days').toDate()
      },
      {
        action: "Profile created"
        title: "Testberg Clientie"
        date: moment().subtract(45, 'days').toDate()
      },
      {
        action: "Profile edited"
        title: "Alexey Chenosov"
        date: moment().subtract(47, 'days').toDate()
      },
      {
        action: "Profile created"
        title: "Alexey Chenosov"
        date: moment().subtract(47, 'days').toDate()
      }
    ]