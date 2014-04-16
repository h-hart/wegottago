$(document).ready ->
  $(window).keydown (event) ->
    if event.keyCode is 13
      event.preventDefault()
      false

  return
initGoogleMaps = (gm_cont_id, input_id, hidden_lat_id, hidden_lng_id)->
  map = false
  startLat = 40.629240778743025
  startLng = -74.02587890625
  startZoom = 5
  mapIcon = "/assets/comment.png"
  mapTitle = "Here!"
  
  mapOptions =
    center: new google.maps.LatLng(startLat, startLng)
    zoom: startZoom
    disableDefaultUI: true

  map = new google.maps.Map(document.getElementById( gm_cont_id ), mapOptions)

  input = (document.getElementById( input_id ))
  map.controls[google.maps.ControlPosition.TOP_LEFT].push input
  autocomplete = new google.maps.places.Autocomplete(input)
  autocomplete.bindTo "bounds", map
  infowindow = new google.maps.InfoWindow()
  marker = new google.maps.Marker(map: map)
  google.maps.event.addListener autocomplete, "place_changed", ->
    infowindow.close()
    marker.setVisible false
    place = autocomplete.getPlace()
    return  unless place.geometry
    $('#' + hidden_lat_id ).val place.geometry.location.lat()
    $('#' + hidden_lng_id).val place.geometry.location.lng()
    # If the place has a geometry, then present it on a map.
    if place.geometry.viewport
      map.fitBounds place.geometry.viewport
    else
      map.setCenter place.geometry.location
      map.setZoom 17 # Why 17? Because it looks good.
    marker.setIcon (
      url: place.icon
      size: new google.maps.Size(71, 71)
      origin: new google.maps.Point(0, 0)
      anchor: new google.maps.Point(17, 34)
      scaledSize: new google.maps.Size(35, 35)
    )
    marker.setPosition place.geometry.location
    marker.setVisible true
    address = ""
    address = [(place.address_components[0] and place.address_components[0].short_name or ""), (place.address_components[1] and place.address_components[1].short_name or ""), (place.address_components[2] and place.address_components[2].short_name or "")].join(" ")  if place.address_components
    infowindow.setContent "<div class=\"test\"><strong>" + place.name + "</strong><br>" + address + "</div>"
    infowindow.open map, marker

$(document).ready ->
  try
    console.log "Google initialized"
    initGoogleMaps 'gl-map', 'city_name', 'city_loc_lat', 'city_loc_lng'
    return
  catch err
    console.log err