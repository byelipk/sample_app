// Main slidein/slideout function
$('#profile-pop-out').click(function() {
	$('.popout').animate({'right':'0px'}, 500, 'swing');
	$(this).fadeOut();
});

$('.popout-header').click(function() {
	$('.popout').animate({'right':'-1000px'}, 500, 'swing');
  	$('#profile-pop-out').fadeIn();
});

// Carousel effect
$('.popout-bucket').click(function() {
	$('.carousel-actions').animate({'margin-left': '1000px'}, 500, 'swing');
	$('.carousel-content').animate({'left': '5px'}, 500, 'swing');
	console.log(this);								
});

$('.carousel-content p').click(function() {
	$('.carousel-actions').animate({'margin-left': '0px'}, 500, 'swing');
	$('.carousel-content').animate({'left': '-289px'}, 500, 'swing');	
});


// $('.carousel-actions > div').click(function() {
// 	$(this).css('background-color': 'none');
// 	attribute = $(this).attr('id');
// 	console.log('I clicked on ' + attribute)
// });