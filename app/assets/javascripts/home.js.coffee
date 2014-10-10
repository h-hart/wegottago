# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
(($) ->
  $("#finish-user-wizard").click ->
    window.location = "/"
  $('.edit-profile-button').tooltip()

  $ ->
    Slideshow = 
      images: $('.email-capture .background .image')
      init: ->
        Slideshow.current = Slideshow.images.find('visible').prevAll().length
        Slideshow.last = Slideshow.images.length - 1
        setInterval Slideshow.next, 10000
      next: ->
        $(Slideshow.images[Slideshow.current]).removeClass 'visible'
        Slideshow.current++;
        if Slideshow.current > Slideshow.last
          Slideshow.current = 0
        $(Slideshow.images[Slideshow.current]).addClass 'visible'
    
    Slideshow.init()
    
    Activities =
      activities: [
        'Hiking'
        'Biking'
        'Sailing'
        'Surfing'
        'Skydiving'
        'On a road trip'
        'Play chess'
        'Play tennis'
        'Geocaching'
        'Grab a movie'
        'Organize a playdate'
        'To a gallery opening'
        'To spinning class'
        'Plan a trip'
        'Volunteer'
        'Dancing'
        'See a concert'
        'To a comedy club'
        'Start a business'
        'Have a Girls Night'
        'To a football game'
        'To a new restaurant'
        'Antiquing'
        'Play darts'
        'Find another player'
        'To a cooking class'
        'Join a book club'
        'Play Paintball'
        'Have coffee'
        'Play pool'
        'Play volleyball'
        'Waterskiing'
      ]
      span: $ '.email-capture .activity'
      next: ->
        Activities.span.addClass 'transparent'
        setTimeout ->
          index = Math.round (Math.random() * Activities.activities.length)
          Activities.span.text Activities.activities[index]
          Activities.span.removeClass 'transparent'
        , 160
      
    Activities.next()
    setInterval Activities.next, 3000
) jQuery
