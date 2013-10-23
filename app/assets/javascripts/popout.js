// Main slidein/slideout function
$('#profile-pop-out').click(function() {
	$('.popout').animate({'right':'0px'}, 500, 'swing');
	$(this).fadeOut();
});

$('.popout-header').click(function() {
	$('.popout').animate({'right':'-1000px'}, 500, 'swing');
  	$('#profile-pop-out').fadeIn();
});

// Slide effect
$('.popout-bucket').click(function() {
	$('.carousel-actions').animate({'margin-left': '1000px'}, 500, 'swing');
	$('.carousel-content').animate({'left': '5px'}, 500, 'swing');
	console.log(this);								
});

$('.carousel-content p').click(function() {
	$('.carousel-actions').animate({'margin-left': '0px'}, 500, 'swing');
	$('.carousel-content').animate({'left': '-289px'}, 500, 'swing');	
});

// Popout menu navigation effect
$('.carousel-actions > div').toggle(function () {
	id = $(this).attr("id");
	siblings = $(this).siblings();
	label = $(this).children();


	for (var i = 0; i < siblings.length; i++) {

		if (siblings[i]["id"] == id ) {
			continue
		}

		if ( siblings[i]["id"] == "action-ppl" || siblings[i]["id"] == "action-thk" || siblings[i]["id"] == "action-not" ) {
			$('#' + siblings[i]["id"] +'').animate({
				opacity: 'hide',
				height: 'hide',
				marginLeft: '200px'
			}, 'slow');	
		} else {
			$('#' + siblings[i]["id"] +'').animate({
				opacity: 'hide',
				height: 'hide',
				marginRight: '200px'
			}, 'slow');
		}		
	}

	label.hide();
    $(this).animate( { height: "28.55em", width: "19.2em", opacity: .1 }, 500 );

	}, function () {

		for (var i = 0; i < siblings.length; i++) {
			if (siblings[i]["id"] == id ) {
				continue
			}

			if ( siblings[i]["id"] == "action-ppl" || siblings[i]["id"] == "action-thk" || siblings[i]["id"] == "action-not" ) {
				$('#' + siblings[i]["id"] +'').animate({
					opacity: 'show',
					height: 'show',
					marginLeft: '0px'
				}, 'slow');	
			} else {
				$('#' + siblings[i]["id"] +'').animate({
					opacity: 'show',
					height: 'show',
					marginRight: '0px'
				}, 'slow');
			}
		}

		$(this).animate( { height: "9em", width: "9.2em", opacity: 1 }, 500, function() {
			label.show();
		});
});