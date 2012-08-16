C.Vimeo =
  init: (player_id) ->
    $('#play-demo').bind('click', -> 
      $('#' + player_id).get(0).api('api_play', null)
      false
    )

C.Home = 
  init: () ->
    $('#slider').fadeIn();
    if ($('#slider img').size() > 1) 
      $('#slider').cycle({ fx: 'fade'})
    false

jQuery ->
  
  $('#slider').find('img').batchImageLoad
    loadingCompleteCallback: C.Home.init

  $('#coworfingMovie').each (index, iframe) -> 
    iframe.addEvent('onLoad', C.Vimeo.init)   

  $('#play-demo').click () ->
    $(this).hide()
    $('#slider').hide()
    $('#coworfingMovie').show()
