
var map = false;
var startLat = 40.629240778743025;
var startLng = -74.02587890625;
var startZoom = 5;
var mapIcon = '/assets/comment.png';
var mapTitle = 'Here!';

function initializeForm() {
  var mapOptions = {
    center: new google.maps.LatLng(startLat, startLng),
    zoom: startZoom,
    disableDefaultUI: true
  };

  map = new google.maps.Map(document.getElementById('location-map-canvas'), mapOptions);
  var input = /** @type {HTMLInputElement} */(
      document.getElementById('pac-input'));
  map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  var autocomplete = new google.maps.places.Autocomplete(input);
  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(17);  // Why 17? Because it looks good.
    }

    startLat = place.geometry.location.lat();
    startLng = place.geometry.location.lng();

    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }
    $('.postActivity #activity_location').val($('#pac-input').val());
    $('.postActivity #activity_lat').val(startLat);
    $('.postActivity #activity_lng').val(startLng);
    infowindow.setContent('<div class="test"><strong>' + place.name + '</strong><br>' + address+'</div>');
    infowindow.open(map, marker);
  });
}

function initializeView() {
  var address = $('#map-canvas').attr('data');
  if (typeof address === "undefined") return false;
  var geocoder = new google.maps.Geocoder();
  var mapOptions = {
    zoom: 17,
    center: new google.maps.LatLng(startLat, startLng),
    disableDefaultUI: true
  };

  mapView = new google.maps.Map(document.getElementById('map-canvas'), mapOptions);

  if (geocoder) {
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == google.maps.GeocoderStatus.OK) {
        if (status != google.maps.GeocoderStatus.ZERO_RESULTS) {
          mapView.setCenter(results[0].geometry.location);

          if (results[0].geometry.viewport) {
            mapView.fitBounds(results[0].geometry.viewport);
          }

          var infowindow = new google.maps.InfoWindow({
                content: '<div class="test"><b>'+address+'</b></div>',
                size: new google.maps.Size(150,50)
          });

          var marker = new google.maps.Marker({
              position: results[0].geometry.location,
              map: mapView, 
              title:address
          }); 

          infowindow.open(mapView, marker);
        } else {
          alert("No results found");
        }
      } else {
        alert("Geocode was not successful for the following reason: " + status);
      }
    });
  }
}

function initializeActivitiesLocationSearch() {
  if (0 === $('.search #search_location_contains').length) return false;
  $('.search #search_location_contains').keypress(function(e) {
    if(e.which == 13) e.preventDefault();
    if ($('.search #search_location_contains').val().length <= 1) {
      $('.search #search_lng_gt').val('');
      $('.search #search_lng_lt').val('');

      $('.search #search_lat_gt').val('');
      $('.search #search_lat_lt').val('');
    }
  });

  var lngRange = 2;//-180 to 180
  var latRange = 1;//-90 to 90
  var input = /** @type {HTMLInputElement} */(
      document.getElementById('search_location_contains'));

  var autocomplete = new google.maps.places.Autocomplete(input);

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.geometry) return;
    lat = place.geometry.location.lat();
    lng = place.geometry.location.lng();

    $('.search #search_lng_gt').val(lng-lngRange/2);
    $('.search #search_lng_lt').val(lng+lngRange/2);

    $('.search #search_lat_gt').val(lat-latRange/2);
    $('.search #search_lat_lt').val(lat+latRange/2);
  });
}

function initializeFriendsLocationSearch() {
  if (0 === $('.friend-search #search_location_contains').length) return false;
  $('.friend-search #search_location_contains').keypress(function(e) {
    if(e.which == 13) e.preventDefault();
    if ($('.friend-search #search_location_contains').val().length <= 1) {
      $('.friend-search #search_loc_lng_gt').val('');
      $('.friend-search #search_loc_lng_lt').val('');

      $('.friend-search #search_loc_lat_gt').val('');
      $('.friend-search #search_loc_lat_lt').val('');
    }
  });

  var lngRange = 2;//-180 to 180
  var latRange = 1;//-90 to 90
  var input = /** @type {HTMLInputElement} */(
      document.getElementById('search_location_contains'));

  var autocomplete = new google.maps.places.Autocomplete(input);

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var place = autocomplete.getPlace();
    if (!place.geometry) return;
    lat = place.geometry.location.lat();
    lng = place.geometry.location.lng();

    $('.friend-search #search_loc_lng_gt').val(lng-lngRange/2);
    $('.friend-search #search_loc_lng_lt').val(lng+lngRange/2);

    $('.friend-search #search_loc_lat_gt').val(lat-latRange/2);
    $('.friend-search #search_loc_lat_lt').val(lat+latRange/2);
  });
}

google.maps.event.addDomListener(window, 'load', initializeView);
google.maps.event.addDomListener(window, 'load', initializeActivitiesLocationSearch);
google.maps.event.addDomListener(window, 'load', initializeFriendsLocationSearch);