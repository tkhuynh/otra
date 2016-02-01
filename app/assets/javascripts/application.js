// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery
//= require bootstrap-sprockets
//= require_tree .

$(function() {
	$('body').on('click', '#remove', function(e) {
		console.log("Clicked!");
		// $(this).prev("input[type=hidden]").value = "1";
		$(this).hide().prevAll().remove();
	});
	$("#add").click(function (e) {
		var clone_form_index = $(".fields").length + 1;
		var new_form = $(".fields").last().clone().attr("class", "fields");
		new_form.find("select").addClass("date_input");
		new_form.find(".location_label").attr("for", "tour_performances_attributes_" + clone_form_index + "_location");
    new_form.find(".location_input").attr("id", "tour_performances_attributes_" + clone_form_index + "_location").attr("name", "tour[performances_attributes][" + clone_form_index + "][location]").val("");
		
		new_form.find(".date_label").attr("for", "tour_performances_attributes_" + clone_form_index + "_performance_date");
		new_form.find("select").first().attr("id", "tour_performances_attributes_" + clone_form_index + "_performance_date_1i").attr("name", "tour[performances_attributes][" + clone_form_index + "][performance_date(1i)]");
		new_form.find("select").first().next().attr("id", "tour_performances_attributes_" + clone_form_index + "_performance_date_2i").attr("name", "tour[performances_attributes][" + clone_form_index + "][performance_date(2i)]");
		new_form.find("select").last().attr("id", "tour_performances_attributes_" + clone_form_index + "_performance_date_3i").attr("name", "tour[performances_attributes][" + clone_form_index + "][performance_date(3i)]");
		$(".fields").last().after(new_form);
		$("#tour_performances_attributes_" + clone_form_index + "_location").focus();
		onGeocoder();
		e.preventDefault();
	});

	// Geocoder
	function onGeocoder() {
		var options = {
		          types: ['(cities)'],
		          componentRestrictions: {country: ["usa"]}
		      };
		$(".city_stops").geocomplete(options);
	}

	onGeocoder();
	
	
	// Google Map

	var map;
	function initialize() {
		var center = new google.maps.LatLng(41.850033, -87.6500523);
		map = new google.maps.Map(document.getElementById('map'), {
			center: center,
			zoom: 4,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		});

		  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);
	}

	google.maps.event.addDomListener(window, 'load', initialize);
});



