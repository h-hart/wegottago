$(function() {

  var timer_my_status = $.timer(function() {
    $.get("/conversations/update-status", function( data ) {});
  });

  var timer_other_users = $.timer(function() {
    $(".message-user-status").each(function(){
      var obj = $(this);
      var id = obj.attr('rel');

      $.get("/conversations/get-status/"+id, function( data ) {        
        if (data.status == true) 
          obj.show();
        else
          obj.hide();
      });
    });
  });

  if ($(".message-user-status").length <= 0) return false;
  timer_my_status.play();
  timer_my_status.set({ time : 30000, autostart : true }); //30 sec

  timer_other_users.play();
  timer_other_users.set({ time : 15000, autostart : true }); // 15 sec

});





