
// Create variables (in this scope) to hold the API and image size
function initializeJcrop(){
  var jcrop_api,
      boundx,
      boundy,
      $uncroped = $('#image').find('#uncroped');
  
  $($uncroped).Jcrop({
    onChange:    updateInputs,
    setSelect:   searchSelections(),
    aspectRatio: 200 / 200,
    bgOpacity:   0.5
  },function(){
    // Use the API to get the real image size
    var bounds = this.getBounds();
    boundx = bounds[0];
    boundy = bounds[1];
    // Store the API in the jcrop_api variable
    jcrop_api = this;

    // Move the preview into the jcrop container for css positioning
  });
}

function searchSelections (){
  if ( typeof $('#inivals').data('x') === 'undefined' ){
    return [ 5, 5, 200, 200 ];
  }else{
    return [
      $('#inivals').data('x'),
      $('#inivals').data('y'),
      $('#inivals').data('w'),
      $('#inivals').data('h')
    ];
  }
}

function updateInputs(c){
  $('#user_crop_x').val(c.x);
  $('#user_crop_y').val(c.y);
  $('#user_crop_w').val(c.w);
  $('#user_crop_h').val(c.h);
}