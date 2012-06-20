(function( $ ){
  $.fn.replaceResponsiveImages = function() {
  	function sortNumbers(one,two){
  		return(one-two);
  	}
    return this.each(function() {
    var $this = $(this); //this is the element we have passed to the function
     if ($(this).data() ){
     	var breakpoints = $(this).data(); //get the data from the image
     	var keyArray = [];
     	for (key in breakpoints) { //loop through all the breakpoints found
     		var currentKeyValue = parseInt(key); //create int from the key e.g. '960' --> 960
     		if(window.devicePixelRatio >= 2)  { //if display is retina then
     			if (screen.width * 2 > currentKeyValue) { //if the screen double width is wider than the current break point::
     				keyArray.push(currentKeyValue); //add it to the array
     			}
     		} else {
     			if (screen.width > currentKeyValue) { //if the screen is wider than the current break point::
     				keyArray.push(currentKeyValue); //add it to the array
     			}
     		}
     	}
     	if (keyArray.length > 0) {//if the array has a length then we have beaten one break point so we can apply it
     		keyArray.sort(sortNumbers); //sort the data by its value
     		var highestBreakPoint = "" + keyArray.slice(-1)[0];//take the last value of the list (biggest num)
     		$(this).attr('src', $(this).data(highestBreakPoint));//set the src to the highest breakpoint that matched
     	}
     }
    });
  };
})( jQuery );

