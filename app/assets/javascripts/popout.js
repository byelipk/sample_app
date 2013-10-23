// Main slidein/slideout function
$('#profile-pop-out').click(function() {
	$('.popout').animate({'right':'0px'}, 500, 'swing');
	$(this).fadeOut();
});

$('.popout-header').click(function() {
	$('.popout').animate({'right':'-1000px'}, 500, 'swing');
  	$('#profile-pop-out').fadeIn();
});

// Carosel slide effect
$('.popout-bucket').click(function() {
	$('.carousel-actions').animate({'margin-left': '1000px'}, 500, 'swing');
	$('.carousel-content').animate({'left': '5px'}, 500, 'swing');							
});

$('.carousel-content p').click(function() {
	$('.carousel-actions').animate({'margin-left': '0px'}, 500, 'swing');
	$('.carousel-content').animate({'left': '-289px'}, 500, 'swing');	
});

// Popout menu navigation effect
$('.carousel-actions > div').toggle(function () {
	mySiblings = $(this).siblings(); // Represents unclicked tiles
	myLabel = $(this).children('.action-wrapper'); // Navigation tile
	myContent = $(this).children('.content-wrapper') // Displayed when user clicks on tile
	currBackground = $(this).css( 'background-color' ); // Current tile background color value

	for (var i = 0; i < mySiblings.length; i++) {

		if ( mySiblings[i]["id"] == "action-ppl" || mySiblings[i]["id"] == "action-thk" || mySiblings[i]["id"] == "action-not" ) {
			$('#' + mySiblings[i]["id"] +'').animate({
				opacity: 'hide',
				height: 'hide',
				marginLeft: '200px'
			}, 'slow');	
		} else {
			$('#' + mySiblings[i]["id"] +'').animate({
				opacity: 'hide',
				height: 'hide',
				marginRight: '200px'
			}, 'slow');
		}		
	}

	// Hide tile
	myLabel.hide();
	
	// Animate the tile
    $(this).css( "backgroundColor", "#333333" ).animate( { 
		height: "28.55em", 
		width: "19.2em" }, 500, function() {

			// Show content
 			myContent.children().show();
    });

	}, function () {

		for (var i = 0; i < mySiblings.length; i++) {

			if ( mySiblings[i]["id"] == "action-ppl" || mySiblings[i]["id"] == "action-thk" || mySiblings[i]["id"] == "action-not" ) {
				$('#' + mySiblings[i]["id"] +'').animate({
					opacity: 'show',
					height: 'show',
					marginLeft: '0px'
				}, 'slow');	
			} else {
				$('#' + mySiblings[i]["id"] +'').animate({
					opacity: 'show',
					height: 'show',
					marginRight: '0px'
				}, 'slow');
			}
		}

		// Hide content
		myContent.children().hide();

		// Animate the tile back to original position
		$(this).css('backgroundColor', ' ' + currBackground +' ' ).animate( { 
			height: "9em", 
			width: "9.2em" }, 500, function() {

				// Show tile
				myLabel.show();
		});
});