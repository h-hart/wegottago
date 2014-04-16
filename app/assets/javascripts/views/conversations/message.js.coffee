class GottaGo.Views.Message extends Backbone.View

  el: '#messages'

  events:
    'submit .ajax-message': 'sendMessage'
    'click #cancel-conversation': 'canselConversation'


  initialize: ()->
    @initSelect()
    height = 0
    @$el.find("#messages-list").children().each (index, e) ->
      height += $(e).height()

    @$el.find("#messages-list").scrollTop parseInt(height) * 2

  sendMessage: (e)->
    # it is more comfortable to user simple $.post here
    # instead of backbone model. Because we need to render
    # haml partial on success.
    e.preventDefault
    $.post($(e.target).attr('action'), $(e.target).serialize(), null, "script")
    false

  canselConversation: (e)->
    e.preventDefault()
    @$el.find('#new_message textarea#body').val('')
    false

  initSelect: ()->
    @$el.find('#mult_select').val([ @getParamByName('receiver_id') ]).select2 
      formatResult: @selectFormat,
      formatSelection: @selectFormat,
      escapeMarkup: (m)-> 
        m

  # Format definition form select2
  selectFormat: (user) ->
    user = JSON.parse( user.text )
    "<p class='user-select'>"    +
    "<img src='"+user.image+"'/>"+
    "<span>"+user.name+"</span>" +
    " </p>"

  getParamByName: (name) ->
    name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]")
    regex = new RegExp("[\\?&]" + name + "=([^&#]*)")
    results = regex.exec(location.search)
    (if not results? then "" else decodeURIComponent(results[1].replace(/\+/g, " ")))






