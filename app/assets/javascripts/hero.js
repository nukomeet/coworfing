var coworfing = {};

coworfing.vimeo = {
  init: function(player_id) {
    $('#play-demo').bind('click', function() {
      $('#' + player_id).get(0).api('api_play', null);
    });
  }
};

coworfing.init = function() {
  $('#slider').fadeIn();
  if ($('#slider img').size() > 1) {
    $('#slider').cycle({ fx: 'fade'});
  }
};


$(function() {

  $('#slider').find('img').batchImageLoad({
    loadingCompleteCallback: coworfing.init
  });

  $('#coworfingMovie').each(function(index, iframe){
    iframe.addEvent('onLoad', coworfing.vimeo.init);   
  });

  $('#play-demo').click(function(){
    $(this).hide();
    $('#slider').hide();
    $('#coworfingMovie').show();
  });
});
