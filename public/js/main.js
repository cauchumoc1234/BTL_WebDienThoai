// Handle Slide show
var slideIndex = 1;
		showDivs(slideIndex);
		function plusDivs(n) {
		  showDivs(slideIndex += n);
		}
		
		function showDivs(n) {
		  
		  var i;
		  var x = document.getElementsByClassName("slide-item");
		  if (n > x.length) {slideIndex = 1}
		  if (n < 1) {slideIndex = x.length}
		  for (i = 0; i < x.length; i++) {
			x[i].style.opacity = "0";
		  }
		  
		  x[slideIndex - 1].style.opacity = "1";
		}
