$(document).ready(function () {
    $('form').each(function () {
       if ($(this).find('input[type="file"]').length) {
           $(this).attr('enctype', 'multipart/form-data');
       }
    });

    if (window.location.href.match('cart|signup')) {
        $("#field_country, #state_input, #state_select").change(function () {
            var self = $(this),
                state = $("#state_select:visible"),
                form = self.parents("form").eq(0),
                model = window.location.href.match('cart') ? 'cart' : 'signup';

            if(!form.length){
                return;
            }

            form.addLoader();
            $.post("?cmd="+model+"&action=regionTax", {
                country: $("#field_country").val(),
                state: state.length > 0 ? state.val() : $("#state_input").val()
            }, function (resp) {
                if (resp[0] == 1) {
                    var submit = form.find('[name=submit]');
                    form.append('<input type="hidden" name="autosubmited" value="true" />').unbind('submit').attr('onsubmit','')
                    if(submit.length)
                        submit.click();
                    else
                        form.submit();
                }else
                    $('#preloader').remove()
            })
        });
    }
    if (typeof $.fn.chosen == 'function')
        $(".chzn-select").chosen();
});
function singup_image_reload() {
    var d = new Date();
    $('.capcha:first').attr('src', '?cmd=root&action=captcha#' + d.getTime());
    return false;
}