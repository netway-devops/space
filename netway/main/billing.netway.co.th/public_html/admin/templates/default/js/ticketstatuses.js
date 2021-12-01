$(document).ready(function () {
    console.log('redy');
    $('#colorSelector').ColorPicker({
        onSubmit: function (hsb, hex, rgb, el) {
            $(el).val(hex);
            $(el).ColorPickerHide();
        }, onChange: function (hsb, hex, rgb) {
            $('#colorSelector').css('backgroundColor', '#' + hex);
            $('#colorSelector_i').val(hex);
        },
        livePreview: true, color: '000000'}
    );
    $("#grab-sorter").dragsort({dragSelector: "a.sorter-handle", dragBetween: true, dragEnd: saveOrder, placeHolderTemplate: "<li class='placeHolder'><div></div></li>"});
});
function saveOrder() {
    var sorts = $('#serializeit').serialize();
    ajax_update('?cmd=configuration&action=ticketstatuses&' + sorts, {});
}
;
function newTStatus() {
    console.log('newTStatus');
    
    $('#blank_state').hide();
    $('#new_status').show()
        .find('input[name=status]').val('')
        .prop('disabled', false)
        .removeAttr('disabled')
        .filter('[type=hidden]').remove();
    
    $('.submitme').hide().filter('.add').show();
    var color = '000000',
        options = 2;
    
    $('#colorSelector').ColorPickerSetColor(color)
        .css('background-color', '#' + color);
    
    $('#colorSelector_i').val(color);
    $('#new_status input[name="options[]"]').each(function () {
        $(this).prop('checked', !!(parseInt($(this).val()) & options));
    })
}
function editTStatus(status, color, options) {
    console.log('editTStatus');
    
    $('#blank_state').hide();
    var formbox = $('#new_status'),
        inp = formbox.find('input[name=status]:first'),
        hidden = formbox.find('input[name=status][type=hidden]');
    
    inp
    if(!hidden.length){
        hidden = inp.clone().prop('type', 'hidden').attr('type', 'hidden');
        hidden.insertAfter(inp);
    }

    formbox.show();
    inp.val(status).prop('disabled', true).attr('disabled', 'disabled');
    hidden.val(status);
    
    $('#colorSelector').ColorPickerSetColor(color)
        .css('background-color', '#' + color);
    
    $('#colorSelector_i').val(color);
    
    $('.submitme').hide().filter('.edit').show();
    $('#new_status input[name="options[]"]').each(function () {
        $(this).prop('checked', !!(parseInt($(this).val()) & options));
    })
}