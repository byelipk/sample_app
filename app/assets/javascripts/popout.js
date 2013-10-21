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
	children = $(this).parent().find("div");
	for (var i = 0; i < children.length; i++) {
		if (children[i]["id"] == id ) {
			continue
		}

		if ( children[i]["id"] == "action-ppl" || children[i]["id"] == "action-thk" || children[i]["id"] == "action-not" ) {
			console.log(children[i]['id'] + " needs to have its margin-left animated");
			$('#' + children[i]["id"] +'').animate({
				opacity: 'hide',
				height: 'hide',
				marginLeft: '200px'
			}, 'slow');	
		} else {
			console.log(children[i]['id'] + " needs to have its margin-right animated");
			$('#' + children[i]["id"] +'').animate({
				opacity: 'hide',
				height: 'hide',
				marginRight: '200px'
			}, 'slow');
		}		
	}
    
    $(this).animate( { height: "100%", width: "98%", opacity: .1 }, 500 );

	}, function () {
	for (var i = 0; i < children.length; i++) {
		if (children[i]["id"] == id ) {
			continue
		}

		if ( children[i]["id"] == "action-ppl" || children[i]["id"] == "action-thk" || children[i]["id"] == "action-not" ) {
			console.log(children[i]['id'] + " needs to have its margin-left animated");
			$('#' + children[i]["id"] +'').animate({
				opacity: 'show',
				height: 'show',
				marginLeft: '0px'
			}, 'slow');	
		} else {
			console.log(children[i]['id'] + " needs to have its margin-right animated");
			$('#' + children[i]["id"] +'').animate({
				opacity: 'show',
				height: 'show',
				marginRight: '0px'
			}, 'slow');
		}
	}
	$(this).animate( { height: "32%", width: "47.5%", opacity: 1 }, 500 );
});