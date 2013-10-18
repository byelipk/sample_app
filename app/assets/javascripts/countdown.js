function updateCountdown() {
  // 140 characters max
  var left = 140 - $('#micropost_content').val().length;
  if(left == 1) {
    var charactersLeft = ' character left.'
  }
  else if(left < 0){
    var charactersLeft = ' characters too many.'
  }
  else{
    var charactersLeft = ' characters left.'
  }
  $('.countdown').text(Math.abs(left) + charactersLeft);
}

$('#micropost_content').keyup(function() {
	updateCountdown();
	$('#micropost_content').change(updateCountdown);
	$('#micropost_content').keyup(updateCountdown);
});