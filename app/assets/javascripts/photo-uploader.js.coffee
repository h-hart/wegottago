$ ->
  $(".jupload").fileupload
    dataType: "script"
    send: (e, data) ->
      $('#image-container').append($('#loading').clone())
    done: (e, data) ->
      $('#image-container').find('#loading').remove();
      initializeJcrop();
      $('a.hidden, input[type=submit].hidden').removeClass('hidden');

