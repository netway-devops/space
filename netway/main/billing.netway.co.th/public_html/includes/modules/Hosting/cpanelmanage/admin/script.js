$(function () {
   $('.check-all').on('change', function () {
       if ($(this).prop('checked')) {
           $('.to-check').prop('checked', true);
       } else {
           $('.to-check').prop('checked', false);
       }
   });

   $('.do-check, .do-check-all').on('click', function () {
       $('#task-progress').css('min-height', '20px').addLoader();
       $("html, body").animate({
           scrollTop: $(
               'html, body').get(0).scrollHeight
       }, 2000);
       var params = $(this).parents('form').serializeArray(),
           action = $(this).data('action');
       $.post('?cmd=cpanelmanage&action=' + action, params, function (result) {
           $('#task-progress').html(result);
       });
   });
});