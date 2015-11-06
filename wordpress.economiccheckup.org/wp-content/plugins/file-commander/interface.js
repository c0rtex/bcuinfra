jQuery(function($){

  // Prepare upload fields
  var empty_upload_field = $('.file_upload').clone();
  function add_upload_field_handler(){
    $('.file_upload')
    .unbind('change')
    .change(function(){
      // Search an empty file upload field
      if ($(".file_upload input:file[value='']").length < 1){
        // Copy the last upload field and append to bottom
        empty_upload_field.clone().insertAfter( $('.file_upload:last') );
        add_upload_field_handler();
      }
    });
  }
  add_upload_field_handler();
  
  // Display rename buttons
  $('.file-commander-interface .operation .rename').show().css('display', 'inline').find('a').click(function(){
    $('.rename-form').slideUp()
    $(this).parent().parent().next('.rename-form').slideDown();
    return False;
  });
  
  // Open HTTP Links in new window
  $('.operation .view a, .file>a').click(function(){
    window.open(this);
    return false;
  });
  
  // Warning before delete something
  $('.folder .operation .delete a').click(function(){
    return confirm(folder_deletion_confirmation);
  });
  $('.file .operation .delete a').click(function(){
    return confirm(file_deletion_confirmation);
  });


});
