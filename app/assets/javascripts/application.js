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
		// only allow to remove city field if there is more than one
		if ($(".fields").length > 1) {
			$(this).parent().parent().parent().remove();
		} else {
			// alert when user try to remove the last city field
			$(this).parent().parent().parent().prepend("<div class='alert alert-danger city-field-alert'>You can't delete all city fields.</div>");
		}
	});
	// set fiels index for cloning with unique index number
	var setFieldIndex = 2;
	$("#add").click(function(e) {
		$(".city-field-alert").remove();
		setFieldIndex++;
		var clone_form_index = setFieldIndex;
		var new_form = $(".fields").last().clone().attr("class", "fields");
		// setting all element with new index number
		new_form.find("input[value='scheduled']").prev().attr("id", "tour_performances_attributes_" + clone_form_index + "_band_id").attr("name", "tour[performances_attributes][" + clone_form_index + "][band_id]");
		new_form.find("input[value='scheduled']").attr("id", "tour_performances_attributes_" + clone_form_index + "_status").attr("name", "tour[performances_attributes][" + clone_form_index + "][status]");
		new_form.find("select").addClass("date_input");
		new_form.find(".location_label").attr("for", "tour_performances_attributes_" + clone_form_index + "_location");
		new_form.find(".location_input").attr("id", "tour_performances_attributes_" + clone_form_index + "_location").attr("name", "tour[performances_attributes][" + clone_form_index + "][location]").val("");

		new_form.find(".date_label").attr("for", "tour_performances_attributes_" + clone_form_index + "_performance_date");
		new_form.find("select").first().attr("id", "tour_performances_attributes_" + clone_form_index + "_performance_date_1i").attr("name", "tour[performances_attributes][" + clone_form_index + "][performance_date(1i)]");
		new_form.find("select").first().next().attr("id", "tour_performances_attributes_" + clone_form_index + "_performance_date_2i").attr("name", "tour[performances_attributes][" + clone_form_index + "][performance_date(2i)]");
		new_form.find("select").last().attr("id", "tour_performances_attributes_" + clone_form_index + "_performance_date_3i").attr("name", "tour[performances_attributes][" + clone_form_index + "][performance_date(3i)]");
		$(".fields").last().after(new_form);
		$("#tour_performances_attributes_" + clone_form_index + "_location").focus();
		onGeocomplete();
		e.preventDefault();
	});

	// Geocomplete
	function onGeocomplete() {
		var options = {
			types: ['(cities)'],
			componentRestrictions: {
				country: "usa"
			}
		};
		$(".city_stops").geocomplete(options);
	}

	onGeocomplete();

	// Google Map
	var geocoder;
	var map;
	geocoder = new google.maps.Geocoder();
	var markers = [];

	function initialize(mapId) {
		var center = new google.maps.LatLng(38.50033, -97.6500523);
		map = new google.maps.Map(document.getElementById(mapId), {
			center: center,
			zoom: 4,
			mapTypeId: google.maps.MapTypeId.ROADMAP,
			scrollwheel: false
		});
	}

	function get_marker(city) {
		var cityName = city.location;
		if (cityName !== undefined) {
			geocoder.geocode({
				'address': cityName
			}, function(results, status) {
				var latitude = results[0].geometry.location.lat();
				var longitude = results[0].geometry.location.lng();
				var marker = new google.maps.Marker({
					position: new google.maps.LatLng(latitude, longitude),
					map: map,
					title: city.location + ' - ' + city.performance_date,
					icon: 'http://icons.iconarchive.com/icons/glyphish/glyphish/32/07-map-marker-icon.png'
				});
				markers.push(marker);
			});
		}
	}
	function get_marker_without_save(city) {
		var cityName = city.location;
		if (cityName !== undefined) {
			geocoder.geocode({
				'address': cityName
			}, function(results, status) {
				var latitude = results[0].geometry.location.lat();
				var longitude = results[0].geometry.location.lng();
				var marker = new google.maps.Marker({
					position: new google.maps.LatLng(latitude, longitude),
					map: map,
					title: city.location + ' - ' + city.performance_date,
					icon: 'http://icons.iconarchive.com/icons/glyphish/glyphish/32/07-map-marker-icon.png'
				});
			});
		}
	}
	for (var i = 1; i < $(".map").length; i++) {
		$("#map" + i).hide();
	}
	$.get("/band_dashboard.json", function(data) {
		initialize("map0");
		data[0][1].forEach(get_marker_without_save);

		$("body").on("click", ".view-map", function(e) {
			for (var i = 0; i < markers.length; i++) {
				markers[i].setMap(null);
			}
			markers = [];
			var tour_index = $(".view-map").index(this);
			var mapId = "map" + tour_index;
			$("#" + mapId).toggle();
			initialize(mapId);
			data[tour_index][1].forEach(get_marker);
		});
	});
	// tab for group shows and group performances
	$(".date-tab").first().addClass("active");
	$(".tab-pane").first().addClass("in active");

	// signup form
	$(".host-signup").click(function(e) {
		$("#signup").show();
		$("#role").val("Host");
	});
	$(".band-signup").click(function(e) {
		$("#signup").show();
		$("#role").val("Band");
	});
});