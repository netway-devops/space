var template = $('#multiinput-item-template').html();

$(function () {
    handleCountMultipleInput();
});
function handleCountMultipleInput() {
    $('.multiinput-box').each(function () {
        var par = $(this);
        var max = parseInt($(par).attr('data-max'));
        var cur = parseInt($(par).find('.multiinput-box-item').length);
        if (max && max != undefined && max != 0 && max != '') {
            var btn = $(par).find('.multiinput_addInput');
            if (cur >= max || max === 1) {
                $(btn).hide();
            } else {
                $(btn).show();
            }
        }
        if (cur === 1) {
            $(par).find('.multiinput-box-item').first().find('.multiinput_removeInput').hide();
        } else {
            $(par).find('.multiinput-box-item').first().find('.multiinput_removeInput').show();
        }
    });
}
function onchangeMultipleInput(el) {
    $(document).trigger('hbcart.changeform', [el]);
    $(el).on('change', function () {
        if (typeof(simulateCart) == 'function') simulateCart($(el).closest('.multiinput-box').attr('data-formid'));
    });
    handleCountMultipleInput();
}
function addMultiInput(el) {
    var par = $(el).closest('.multiinput-box');
    var itoptname = par.attr('data-itname');
    var itcopyof = par.attr('data-copyof');
    var id = 'custom_field_' + itcopyof;
    var cls = 'custom_field_' + itcopyof;
    var tpl = template;
    tpl = tpl.replace(/__itname/g, itoptname);
    $(par).find('.multiinput_addInput').before(tpl);
    handleCountMultipleInput();
}
function removeMultiInput(el) {
    $(el).closest('.multiinput-box-item').remove();
    handleCountMultipleInput();
}