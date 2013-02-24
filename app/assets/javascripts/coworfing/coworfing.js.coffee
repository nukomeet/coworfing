jQuery ->
    $("img.lazy").lazyload()

    $("input.date_picker").datetimepicker({ dateFormat: 'yy-mm-dd', timeFormat: 'hh:mm' })
    
    $(".chzn-select").select2()
    
    # initialize carousel
		$('[rel=carousel]').carousel()
		
		# initialize tooltip
		$('[rel=tooltip]').tooltip()
		
		# initialize tabs
		$('.nav-tabs a:first').tab('show')
		
		# back to top button
		
		$('<i id="back-to-top" class="icon-chevron-up"></i>').appendTo($('body'))

		$(window).scroll ()->
		  if ( $(this).scrollTop() != 0 )
		    $('#back-to-top').fadeIn()
		  else
			  $('#back-to-top').fadeOut()
				
		$('#back-to-top').click ()->
			$('body,html').animate({scrollTop:0},600)
			
			
		# fancybox
		$(".fancybox").fancybox()
