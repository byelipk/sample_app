$('#profile-pop-out').click(function() {
	$(this).fadeOut();
	$('.popout').toggle("slide");
});

$('.popout-header').click(function() {
	$('.popout').toggle("slide");
  	$('#profile-pop-out').fadeIn();
});