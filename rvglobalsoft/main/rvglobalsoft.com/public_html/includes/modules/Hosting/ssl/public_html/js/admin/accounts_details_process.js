$('#for_order_complete').hide();
function doreset($field)
{
    if ($field == 'order_completed') {
        $('#code_certificate').val('');
        $('#code_ca').val('');
        $('#date_expire').val('');
    }
}

function doshow(id)
{
    $(id).show();
}

function completeorder()
{
	certificate = $('#code_certificate').val();
    code_ca = $('#code_ca').val();
    date_expire = $('#date_expire').val();
    order_id = $('#order_id').val();
    
    if (certificate == '') {
    	alert('หากต้องการ Active order จะต้องระบุ Certificate ของ Order นี้ด้วย');
    	return false;
    }
    if (date_expire == '') {
    	alert('จะต้องระบุวันหมดอายุของ Certificate ด้วย');
    	return false;
    }
    
    $('body').addLoader();
    $('#bt_autoclick').click();
}

function clickOptProcess()
{
	$('#for_order_complete').hide();
}