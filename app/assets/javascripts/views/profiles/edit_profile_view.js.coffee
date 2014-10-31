

Array::remove = (elem) ->
  match = -1
  @splice match, 1  while (match = @indexOf(elem)) > -1

class GottaGo.Views.EditProfile extends Backbone.View

  el: '.edit-forms'

  initialize: ()->
    @initUi()
    @initGoogleMaps()
    @showInitForm()

  events:
    # show/hide forms
    'click .basic-nav'                   : 'showBasicForm'
    'click .about-nav'                   : 'showAbout'
    'click .notifications-nav'           : 'showNotifications'
    'click .interests-nav'               : 'showInterests'
    'click .preferences-nav'             : 'showPreferences'
    'click .my-account-nav'              : 'showMyAccount'
    #froms events
    'click .current .close.ui-dr-inline' : 'removeInInterests'

  # show/hide from profile events

  showInitForm: ()->
    url = document.URL
    tmp_arr = url.split("=")
    form_id = tmp_arr[tmp_arr.length - 1]
    switch form_id
      when 'basic'
        @showBasicForm(@$el)
      when 'interests'
        @showInterests(@$el)
      when 'my-account' 
        @showMyAccount(@$el)
      when 'notifications'
        @showNotifications(@$el)
      when 'about'
        @showAbout(@$el)
#      when 'preferences'
#        @showPreferences(@$el)
      else
        @showBasicForm(@$el)


  showMyAccount: (e)->
    e.preventDefault
    @addActive( $('.my-account-nav') )
    @$el.find('.form-container').addClass('hidden')
    @$el.find('#my-account').removeClass('hidden')
    false

  showBasicForm: (e)->
    e.preventDefault
    @addActive( $('.basic-nav') )
    @$el.find('.form-container').addClass('hidden')
    @$el.find('#basic').removeClass('hidden')
    false

  showAbout: (e)->
    e.preventDefault
    @addActive( $('.about-nav') )
    @$el.find('.form-container').addClass('hidden')
    @$el.find('#about-me').removeClass('hidden')
    false

  showNotifications: (e)->
    e.preventDefault
    @addActive( $('.notifications-nav') )
    @$el.find('.form-container').addClass('hidden')
    @$el.find('#notifications').removeClass('hidden')
    false

  showInterests: (e)->
    e.preventDefault
    @addActive( $('.interests-nav') )
    @$el.find('.form-container').addClass('hidden')
    @$el.find('#interests').removeClass('hidden')
    false

  showPreferences: (e)->
    e.preventDefault
    @addActive( $('.preferences-nav') )
    @$el.find('.form-container').addClass('hidden')
    @$el.find('#preferences').removeClass('hidden')
    false

  addActive: (element)->
    @$el.find('.nav-td').removeClass('active')
    element.addClass('active')

  #form events
  removeInInterests: (event)->
    clone = $(event.target).parent()
    $(event.target).parent().remove()
    clone.find('.close').remove()
    clone.addClass('draggable')
    clone.removeClass('current')
    @$el.find('.avaliables').append(clone)
    values = @$el.find('#user_interest_list').val()
    values = values.replace( clone.find('.cval').text()+',', '' )
    values = values.replace( clone.find('.cval').text(), '' )
    @$el.find('#user_interest_list').val(values)
    @initUi()


  addValue: ($uiElement)->
    values = @$el.find('#user_interest_list').val()
    el_val = $uiElement.find('.cval').text()
    index  = values.indexOf(el_val);
    if index == -1
      if values == ''
        values = el_val
      else
        values = values + ", " + el_val
    console.log values
    @$el.find('#user_interest_list').val( values )

  initUi: ()->
    that = @

    @$el.find('.draggable').draggable 
      #containment: "#current_user_interest_list"
      revert: "invalid"

    @$el.find('#current_user_interest_list').droppable 
      drop: (event, ui) ->
        clone = $(ui.draggable).clone()
        that.addValue( clone )
        clone.html( clone.html() + '<button type="button" class="close ui-dr-inline">&#215;</button>')
        clone.addClass('current')
        clone.removeClass('draggable')
        clone.attr('style', '')
        $(this).append(clone)
        $(ui.draggable).remove()

  initGoogleMaps: ()->
    mapOptions =
      center: new google.maps.LatLng(startLat, startLng)
      zoom: startZoom
      disableDefaultUI: true

    map = new google.maps.Map(document.getElementById("user-location-map"), mapOptions)

    input = (document.getElementById("user_location"))
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
      $('#user_loc_lat').val place.geometry.location.lat()
      $('#user_loc_lng').val place.geometry.location.lng()
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




