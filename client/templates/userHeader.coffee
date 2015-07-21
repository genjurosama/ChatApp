Template.userHeader.events 'click #toggle-left': ->
  bodyEl = $('#main-wrapper')
  if $(window).width() > 767 then $(bodyEl).toggleClass('sidebar-mini') else $(bodyEl).toggleClass('sidebar-opened')
  return