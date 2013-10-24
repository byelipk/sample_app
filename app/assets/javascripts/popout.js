// Main slidein/slideout function
$('#profile-pop-out').click(function() {
	$('.popout').animate({'right':'0px'}, 500);
	$(this).fadeOut();
});

$('.popout-header').click(function() {
	$('.popout').animate({'right':'-1000px'}, 500);
  	$('#profile-pop-out').fadeIn();
});

// Carosel slide effect
$('.carousel-actions > div').click(function ( event ) {
	event.stopPropagation();
	
	myParent   = $(this).parent();
    myCousin   = $('.carousel-' + $(this).attr('id').split('-')[1] + '');
    
    myCousinOriginalLeft = myCousin.css( 'left' );
    myCousinOriginalRight = myCousin.css( 'right' );
	
	if ( $(this).hasClass( "carousel-action-left" ) ) {
		myParent.animate( { 'left': '1000px' }, 500 );
		myCousin.animate( { 'right': '5px' }, 500 );
	} else {
		myParent.animate( { 'right': '1000px' }, 500 );
		myCousin.animate( { 'left': '5px' }, 500 );
	}
	
});

$('.popout-carousel > div p').click( function( event ) {
	event.stopPropagation();

	if ( myCousin.hasClass( "carousel-left" ) ) {
		myCousin.animate( { 'right': '' + myCousinOriginalRight + '' }, 500 );
		myParent.animate( { 'left' : '5px' }, 500, function() {
			myParent.css( 'left', 'auto' );
		} );
	} else {
		myCousin.animate( { 'left': '' + myCousinOriginalLeft + '' }, 500 );
		myParent.animate( { 'right' : '5px' }, 500, function() {
			myParent.css( 'right', 'auto' );
		} );
	}
});