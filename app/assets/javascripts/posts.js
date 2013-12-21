// AJAX request for making a new post
$(document).ready(function() {
	$('form#new_post').on('ajax:beforeSend', function(event, xhr, settings){
	  	var $submitButton = $(this).find('input[name="commit"]');

	  	// Store original text of submit button so it can be restored when finished
	  	$submitButton.data('OrigText', $(this).find('input[name="commit"]').attr("value"));
	  	$submitButton.attr("value", "Loading..." );
	})
	.on('ajax:success', function(event, data, status, xhr) {
		
		$('form#response_post').on('ajax:beforeSend', function() {
			console.log("What do we do before the request is sent?");
		})
		.on('ajax:success', function() {
			console.log("What do we do after a successful request?");
		})
		.on('ajax:error', function() {
			console.log("What do we do when there is an error?");
		})
		.on('ajax:complete', function() {
			console.log("Maybe we hide the element?");
			$(this).hide();
		});

	})
	.on('ajax:error', function(event, xhr, status, error) {
		console.log("FAILURE!");
	})
	.on('ajax:complete', function(event, xhr, status) {
      	var $submitButton = $(this).find('input[name="commit"]');

      	// Restore original text
      	$submitButton.attr("value", $submitButton.data('OrigText') );   
	});
});