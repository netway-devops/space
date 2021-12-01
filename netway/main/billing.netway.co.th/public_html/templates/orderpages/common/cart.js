var COMMONJS = COMMONJS || $('script[src*="cart.js"]:last');
function _get(name){
    var results = new RegExp('[\\?&]' + name + '=([^&#]*)').exec(COMMONJS.attr('src')) || 0;
    return results[1] || 0;
}
function simulateCart(forms) {
	$('#cartSummary').addLoader();
	ajax_update('?cmd=cart&step='+_get('step')+'&'+$(forms).serialize(),{'simulate':'1'},'#cartSummary');
}
function applyCoupon() {
	var f = $('#promoform, #cart1, #cart2, #cart3').serialize();
	$('#cartSummary').addLoader();
	ajax_update('?cmd=cart&addcoupon=true&step='+_get('step')+'&'+f,{},'#cartSummary');
	return false;
}
function changeCycle(forms) {
	$(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
	return true;
}
function removeCoupon() {
	$('#cartSummary').addLoader();
    var f = $('#cart1, #cart2, #cart3').serialize();
	ajax_update('?cmd=cart&removecoupon=true&step='+_get('step')+'&'+f,{},'#cartSummary');
	return false;
}
/* moved to singup form - ajax.singup.tpl
$(function(){
    $('document').delegate('#field_country, #state_input, #state_select','change',function(){
        var that = this;
        $.post('?cmd=cart&action=regionTax', {country:$('#field_country').val(), state: $('#state_select:visible').length > 0 ? $('#state_select').val() : $('#state_input').val() }, function(data){
            if(data == 1){
                $(that).parents('form').append('<input type="hidden" name="autosubmited" value="true" />').submit();
                console.log($(that).parents('form'));
                //location.reload();
            } 
        })
    });
})
*/
