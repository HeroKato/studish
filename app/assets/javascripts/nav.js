$(function(){
  $('.nav a').on('click', function(){
  	if (window.innerWidth <= 768) {
  		$('.navbar-toggle').click();
  	}
  });
});