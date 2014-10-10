//social begin
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/all.js#xfbml=1";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0],p=/^http:/.test(d.location)?'http':'https';if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=p+'://platform.twitter.com/widgets.js';fjs.parentNode.insertBefore(js,fjs);}}(document, 'script', 'twitter-wjs');
//social end

$(function() {
  var themesArr = new Array();
  var currentThemeKey = 0;

  // Activity join begin
  $('#activity-join').click(function() {
    var id = $(this).attr('rel');
    $.get("/activity-join/"+id, function( data ) {
      var type = $('#activity-join').attr('data');
      if (1 == type) {
        $('#activity-join').html('I’m going');
        $('#activity-join').attr('data', '2');
      }
      else {
        $('#activity-join').html('Join');
        $('#activity-join').attr('data', '1');
      }
    });
  });
  //Activity join end

  // Activity curious begin
  $('#activity-curious').click(function() {
    var id = $(this).attr('rel');
    $.get("/curiosity/"+id, function( data ) {
      var type = $('#activity-curious').attr('data');
      if (1 == type) $('#activity-curious').attr('data', '2').html('I’m Curious');
      else $('#activity-curious').attr('data', '1').html('Curious?');
    });
  });
  //Activity curious end

  // Comment begin
  $('.comment-field textarea').keypress(function(e) {
    if(e.which == 13) {
      e.preventDefault();
      var id_val = $('.comment-field textarea').attr('rel');
      var comment_val = $('.comment-field textarea').val();
      $('.comment-field textarea').val('');

      if ($.trim(comment_val).length > 0) {
        $.post( "/comments", {id: id_val, comment: $.trim(comment_val)}, function( data ) {
          loadAllComments();
        });
      }
    }
  });

  function loadAllComments() {
    var id = $('.comment-field textarea').attr('rel');
    if (typeof id === "undefined") return false;
    $.get("/comments/"+id, function( data ) {
      $('#activity-tab .comments-list').html('');
      $.each( data, function( key ) {
        $('#activity-tab .comments-list').append(
          "<div class='clearfix comment'>"+
            "<div class='col-md-2'>"+
              "<img src='"+data[key].avatar+"'>"+
            "</div>"+
            "<div class='col-md-10'>"+
              "<div class='row'>"+
                "<div class='commenter'>"+data[key].name+"</div>"+
                "<div class='status'>"+((data[key].joined)?"joined this activity":"is not joined this activity")+"</div>"+
              "</div>"+
              "<div class='row'>"+
                "<div class='text'>"+data[key].text+"</div>"+
              "</div>"+
            "</div>"+
          "</div>");
      });
    });
  }

  loadAllComments();
  // Comment end

  

  //begin interesting tegs
  var selectFormat;

  selectFormat = function(tags) {
    tags = JSON.parse(tags.text);
    return "<p class='tags-select'>" + "<span>" + tags.name + "</span>" + " </p>";
  };

  $('#activity_interest_tag_list').select2({
    formatResult: selectFormat,
    formatSelection: selectFormat,
    escapeMarkup: function(m) {
      return m;
    }
  });
  //end interesting tegs

  //begin show location
  $('.postActivity #activity_location').click(function() {
    $('#ChooseLocation').modal('show');
    if (false !== map) return true;
    setTimeout(initializeForm, 1000);
    setTimeout(function(){
      $("#pac-input").focus();
      $('.pac-container').css({'z-index':'1500'});
    }, 2000);
  });
  //end show location

  //begin click for View activity
  $('.view-activity').click(function() {
    var link = $(this).attr('data');
    window.location.href = link;
  });
  //end click for View activity

  //begin Date picker
  var dataField = $('.postActivity #activity_date').datepicker({
    format: 'DD, M dd, yyyy',
    startDate: new Date(),
  }).on('changeDate', function(ev) {

    var date = $('.postActivity #activity_date').val();
    date = encodeURIComponent(date);
    $.get("/activities/end-time/"+date, function( data ) {
      $('.activity_time .inline-radions').html(data);
    });

    dataField.hide();
  }).data('datepicker');
  //end Date picker

  //begin only posetive numbers
  $('#activity_people_number').keyup(function(e) {
    var obj = $('#activity_people_number');
    var val = obj.val();

    if (val.length == 0) val = 1;
    val = val.replace(/[^0-9]/, "");
    if (val <= 0) val = 1;
    
    obj.val(val);
  });
  //end only posetive numbers

  $('#activityStep2').click(function() {
    showStep2();
  });

  $('#activityStep1').click(function() {
    showStep1();
  });

  function verificateActivityForm() {
    var errorNum = 0;
    showStep2();

    if (!verificateActivityFormField("#activity_title") ) {
      showStep1();
      ++errorNum;
    }

    if (!verificateActivityFormField("#activity_personal_quote") ) {
      showStep1();
      ++errorNum;
    }

    if (!verificateActivityFormField("#activity_date") ) {
      showStep1();
      ++errorNum;
    }

    if (!verificateActivityFormField("#activity_location") ) {
      showStep1();
      ++errorNum;
    }

    if (!verificateActivityFormField("#activity_details") ) {
      showStep1();
      ++errorNum;
    }

    if (!verificateActivityFormField("#activity_people_number") ) ++errorNum;

    return (errorNum>0)? false : true;
  }

  $('#activitySave').click(function() {
    if (verificateActivityForm() ) {
       create_activity.submit();
    }
  });

  $('body').on('click', '.themeItem img', function() {
    currentThemeKey = $(this).attr('rel');
    showTheme();
  });

  $('.postActivity .arrow-left').click(function() {
    lastKey = themesArr.length - 1;
    if (--currentThemeKey < 0) currentThemeKey = lastKey;
    showTheme();
  });

  $('.postActivity .arrow-right').click(function() {
    lastKey = themesArr.length - 1;
    if (++currentThemeKey > lastKey) currentThemeKey = 0;
    showTheme();
  });

  $('body').on('click', '.themeCatItem', function() {
    var catId = $(this).attr('rel');
    $(".themeCatItem").removeClass("themeCatChosen");
    $(this).addClass("themeCatChosen");
    loadThemes(catId);
  });

  $('#PostActivity').on('show.bs.modal', function(e) {
    if (e.target.id == "PostActivity") loadThemeCategories();
  });

  $('#theme_image').fileupload({
    add: function (e, data) {
      var fileType = data.files[0].name.split('.').pop(), allowdtypes = 'jpeg,jpg,png,gif';
      if (allowdtypes.indexOf(fileType) < 0) {
          alert('Invalid file type, aborted');
          return false;
      }
      loader();
      data.submit();
    },
    done: function(e, data) {
      loadThemeCategories(50000);
      loader(false);
    },
    fail: function(e, data) {
      alert('Upload failed');
    }
  });

  function showTheme() {
    $( ".postActivity img" ).attr('src', themesArr[currentThemeKey]['src']);
    $( "#activity_theme_id").val(themesArr[currentThemeKey]['id']);
    highlightCurrentTheme();
  }

  function highlightCurrentTheme() {
    $('.themeItem img').parent().css({backgroundColor: "#EEEEEE"})
    $('.themeItem img[rel="'+currentThemeKey+'"]').parent().css({backgroundColor: "#EEEEEE"});
  }

  function showThemeList() {
    var prepareHTML = '';
    $.each( themesArr, function( key ) {
      prepareHTML += '<div class="themeItem">'+
                  '<img src="'+themesArr[key]['listSrc']+'" rel="'+key+'" />'+
                  '</div>';
    });
    $( ".chooseTheme .themeList" ).html(prepareHTML);
  }

  function loadThemes(catId) {
    currentThemeKey = 0;
    themesArr = new Array();
    $.get("/theme/"+catId, function( data ) {

      $.each( data, function( key ) {
        themesArr[key] = new Array();
        themesArr[key]['id'] = data[key].id;
        themesArr[key]['src'] = data[key].image.url;
        themesArr[key]['listSrc'] = data[key].image.list.url;
      });
      showThemeList();
      showTheme();
    });
  }

  function loadThemeCategories(currentThemeCat) {
    $.get("/theme_category", function( data ) {
      if (typeof currentThemeCat === "undefined") currentThemeCat = data[0].id;
      var prepareHTML = '';
      $.each( data, function( key ) {
        prepareHTML += '<div class="themeCatItem" rel="'+data[key].id+'">'+data[key].name+'</div>';
      });
      $( ".chooseTheme .themeCatList" ).html(prepareHTML);
      $('.themeCatItem[rel="'+currentThemeCat+'"]').addClass("themeCatChosen");

      loadThemes(currentThemeCat);
    });
  }

  function loader(hide) {
    if (typeof hide !== "undefined") {
      $(".chooseTheme .loader-img img").css({visibility:"hidden"});
    }
    else {
      $(".chooseTheme .loader-img img").css({visibility:"visible"});
    }
  }

  function showStep2() {
    $('.activityFormPart1').hide();
    $('.activityFormPart2').show();
  }

  function showStep1() {
    $('.activityFormPart2').hide();
    $('.activityFormPart1').show();
  }

  function verificateActivityFormField(name) {
    $(name).parent().children(".error").remove();
    
    if ($.trim($(name).val()).length === 0) {
      $(name).parent().addClass("has-error").append('<div class="error">Field is empty.</div>');
      return false;
    }
    else {
      $(name).parent().removeClass("has-error").children(".error").remove();
    }
    return true;
  }

});


$(document).ready(function(){

  // hide .back-top first
  $(".back-top").hide();

  // fade in .back-top
  $(function () {
    $(window).scroll(function () {
      if ($(this).scrollTop() > 100) {
        $('.back-top').fadeIn();
      } else {
        $('.back-top').fadeOut();
      }
    });

    // scroll body to 0px on click
    $('.back-top a').click(function () {
      $('body,html').animate({
        scrollTop: 0
      }, 800);
      return false;
    });
  });

});