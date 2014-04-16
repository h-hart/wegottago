// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.draggable
//= require bootstrap
//= require ckeditor/init
//= require active_admin
//= require plugins/jcrop/jquery.Jcrop
//= require image_croper
//= require jquery-fileupload/basic
//= require photo-uploader
//= require select2
//= require home
//= require underscore
//= require backbone
//= require gotta_go
//= require_tree ./models
//= require_tree ../templates
//= require_tree ./views
//= require activity_map
//= require activity
//= require bootstrap-datepicker
//= require jq_bootstrap_validation
//= require plugins/jquery.timer
//= require user_online
//= require_self

function readURL(input){
   $(input).closest('.file_upload').find('.file-label').html($(input).val());
 }
$(document).ready(function() {
  $('#edit_user #user_location').keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
});

$(function() {
  $('.interests-list').on('click', '.interest-item.new', function(){
    var myArr = [];
    myArr.push($(this).text());
    old_val = $('#user_interest_list').val();
    $('#user_interest_list').val(myArr + ',' + old_val);
    if ($('#user_interest_list').val().split(',').length > 4) {
      $('.btn.btn-pink.set-interests').removeAttr('disabled');
    }
    $(this).removeClass('new').addClass('chosen');
    $(this).find('.glyphicon').removeClass('glyphicon-plus').addClass('glyphicon-ok');
  }).on('click', '.interest-item.chosen', function(){
    var new_list = $('#user_interest_list').val().replace($(this).text()+',', '')
    $('#user_interest_list').val(new_list)
    $(this).removeClass('chosen').addClass('new')
    if ($('#user_interest_list').val().split(',').length < 5) {
      $('.btn.btn-pink.set-interests').attr('disabled', true);
    }
    $(this).find('.glyphicon').removeClass('glyphicon-ok').addClass('glyphicon-plus');
  });
  $('.categories-list').on('click', '.category-image.sign-up', function(e){
    e.stopPropagation();
    $('.interests-list').hide();
    $('.interests-wizard-block').show();
    $(this).parent().next().show().css({top: $(this).offset().top - 185});
  });
  $('.interests-list').click(function(e){
    e.stopPropagation();
  }).on('click', '.close-interests', function(){
    $('.interests-list').hide();
  });
  $(document).click(function(){
    $('.interests-list, .interests-wizard-block.make-dark').hide();
  });
});
