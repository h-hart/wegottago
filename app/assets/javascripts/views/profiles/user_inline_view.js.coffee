class GottaGo.Views.UserInline extends Backbone.View

  editAboutTemplate:   JST['profiles/edit_about']
  showAboutTemplate:   JST['profiles/show_about']
  editlowdownTemplate: JST['profiles/edit_lowdown']
  showlowdownTemplate: JST['profiles/show_lowdown']

  initialize: ()->
    if @options.scroll
      @scrollToInterests(@$el.click)

  el: '.user-info-section'

  events:
    'click a.edit'        : 'editAbout'
    'focusout .edit-area' : 'updateAbout'
    'click .save'         : 'updateAbout'
    'click .edit-lowdown' : 'editLowdown'
    'click .save-lowdown' : 'updateLowdown'
    'click #interests'    : 'scrollToInterests'

  # profile events

  scrollToInterests: (e)->
    e.preventDefault
    $("html, body").animate
      scrollTop: $('#interests-section').offset().top
    , 200
    $('#interests-section').css "background-color": "#F8F8F8"
    $('#interests-section').animate
      "background-color": "white"
    , 1000
    false

  editAbout: (e)->
    e.preventDefault
    @swapTo 'edit'
    false

  editLowdown: (e)->
    e.preventDefault
    @swapTo 'edit_lowdown'
    false

  updateAbout: (e)->
    @model.set about: @$el.find('.edit-area').val()
    @model.save {}
    @swapTo 'text'
    @

  updateLowdown: (e) ->
    @model.set relationship_status: @$el.find('#relation').val()
    @model.set have_kids:           @$el.find('#have-kids').val()
    @model.set wants_kids:          @$el.find('#wants-kids').val()
    @model.set ethnicity:           @$el.find('#ethnicity').val()
    @model.set body_type:           @$el.find('#body-type').val()
    @model.set height:              @$el.find('#height').val()
    @model.set faith:               @$el.find('#faith').val()
    @model.set smoke:               @$el.find('#smoke').val()
    @model.set drink:               @$el.find('#drink').val()
    @model.save {}
    @swapTo 'update_lowdown'
    false

  swapTo: (type) ->
    switch type
      when 'text'
        @$el.find('#user-blur').html( @showAboutTemplate( { about: @$el.find('#user-blur .edit-area').val() } ))
      when 'edit'
        @$el.find('#user-blur').html( @editAboutTemplate( { about: @$el.find('#user-blur p').text() } ))
      when 'edit_lowdown'
        data =
          relation:   @$el.find('#relation-value').text()
          have_kids:  @$el.find('#have-kids-value').text()
          wants_kids: @$el.find('#wants-kids-value').text()
          ethnicity:  @$el.find('#ethnicity-value').text()
          body_type:  @$el.find('#body-type-value').text()
          height:     @$el.find('#height-value').text()
          faith:      @$el.find('#faith-value').text()
          smoke:      @$el.find('#smoke-value').text()
          drink:      @$el.find('#drink-value').text()

        @$el.find('#user-lowdown').html( @editlowdownTemplate( data ) )
      when 'update_lowdown'
        data =
          relation:   @$el.find('#relation').val()
          have_kids:  @$el.find('#have-kids').val()
          wants_kids: @$el.find('#wants-kids').val()
          ethnicity:  @$el.find('#ethnicity').val()
          body_type:  @$el.find('#body-type').val()
          height:     @$el.find('#height').val()
          faith:      @$el.find('#faith').val()
          smoke:      @$el.find('#smoke').val()
          drink:      @$el.find('#drink').val()

        @$el.find('#user-lowdown').html( @showlowdownTemplate( data ) )
      else
        alert "Ubdefined swap"




