$(document).ready(()=>{
  $('.create-pdf').attr('disabled', 'disabled');
  $('.create-pdf').attr('data-toggle', 'modal');
  $('.create-pdf').attr('data-target', '#myModal');
  $('.file-name').keyup(function() {
    var empty = false;
    $('.file-name').each(function() {
      if ($(this).val() == '') {
        empty = true;
      }
    });

    if (empty) {
      $('.create-pdf').attr('disabled', 'disabled');
    } else {
      $('.create-pdf').removeAttr('disabled');
    }
  });

})
