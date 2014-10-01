// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require cocoon
//= require bootstrap-sprockets
//= require_tree .

$( document ).ready(function(){
	clock();
	setInterval(clock, 1000);
	console.log('ready for dat time'); 

	function clock(){
		var time = new Date()
		var hr = time.getHours()
		var min = time.getMinutes()
		var sec = time.getSeconds()
		var ampm = " PM "
		if (hr < 12){
		ampm = " AM "
		}
		if (hr > 12){
		hr -= 12
		}
		if (hr < 10){
		hr = " " + hr
		}
		if (min < 10){
		min = "0" + min
		}
		if (sec < 10){
		sec = "0" + sec
		}
		document.clockForm.clockButton.value = hr + ":" + min + ":" + sec + ampm;		
		
	};

		function showDate(){
		// console.log("Hello World")
			var date = new Date();
			var year = date.getYear();
			if(year < 1000){
			year += 1900;
			};
			var monthArray = new Array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
			alert( monthArray[date.getMonth()] + " " + date.getDate() + ", " + year);
		}
	$('#tClkBtn').click(function(){
		showDate();
	});
});
