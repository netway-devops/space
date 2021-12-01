$(document).ready( function () {
    $('.orderbox').hide();
    verifyProductLicense(false , 'Server');
    
    $('label:contains("Server")').parent().find('input').keypress( function (e) {
        var code    = e.keyCode || e.which;
        
        if(code == 13) { //Enter keycode
            verifyProductLicense(false , 'Sever');
            return false;
        }
        
    });
    
    $('label:contains("Server")').parent().find('input').change( function () {
        verifyProductLicense(false , 'Server');
        return false;
    });
    
    $('label:contains("Public")').parent().find('input').keypress( function (e) {
        var code    = e.keyCode || e.which;
        
        if(code == 13) { //Enter keycode
            verifyProductLicense(false , 'Public');
            return false;
        }
        
    });
    
    $('label:contains("Public")').parent().find('input').change( function () {
        verifyProductLicense(false , 'Public');
        return false;
    });
    
    $('#cart3').submit( function () {
        if (verifyProductLicense(false , 'Server') && verifyProductLicense(false , 'Public')){
            $('#cart3')[0].submit();
        } else {
            return false;
        }
        
    });
    
});

function verifyProductLicense (force , ip_type)
{
    var ip          = $('label:contains("Server")').parent().find('input').val();
    var pb_ip       = $('label:contains("Public")').parent().find('input').val();
    
    $('.verifyMessage').remove();
    $('#cart3').addLoader();
    if(ip_type == 'Server' ){
    		if(pb_ip == ''){
    			pb_ip = '-';	
    		}
    }
    
    $.post(caUrl + '?cmd=productlicensehandle&action=verifyLicense', {
        ip          : ip ,
        pb_ip		: pb_ip ,
        ip_type		: ip_type
    }, function (data) {
        console.log(data);
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        
        if (result == 'BLANKIP' || result == 'INVALIDIP' || result == 'NOMODULE' || result == 'NOTAVAILABLE') {
        	if(ip_type == 'Server'){
        		$('.verifyMessage').remove();
            	$('label:contains("Server")').parent().append('<div class="alert verifyMessage"><span class="text-error">'+ codes[result] +'</span></div>');
           		$('#pb_ip').attr( "style","display:none" );
            }else if(ip_type == 'Public'){
            	$('.verifyMessage').remove();
            	$('label:contains("Public")').parent().append('<div class="alert verifyMessage"><span class="text-error">'+ codes[result] +'</span></div>');
            }
            $('#preloader').remove();
            $('.orderbox').hide();
            return false;
        }
        
        if (result == 'AVAILABLE') {
        	currentIp   = ip;
        	 if(ip_type == 'Public'){
            	if (codes.hasOwnProperty('PRIVATEIP') && codes.PRIVATEIP.toString() == 'TRUE') {
			        $('#pb_ip').removeAttr( "style" );
			        $('.verifyMessage').remove();
			        $('label:contains("Public")').parent().find('input').val('');
			    	$('label:contains("Public")').parent().append('<div class="alert verifyMessage"><span class="text-error">The Public IP Address is invalid.</span></div>');
            	}else{
			    	$('label:contains("Public")').parent().append('<div class="alert verifyMessage"><span class="text-success">Available for: '+ codes[result] +'</span></div>');
			    	$('.orderbox').show();
			    }
            }else{
            	if(codes.hasOwnProperty('PRIVATEIP') && codes.PRIVATEIP.toString() == 'FALSE'){
			    	$('#pb_ip').attr( "style","display:none" );
			    	$('label:contains("Public")').parent().find('input').val(currentIp);
			    	$('label:contains("Server")').parent().append('<div class="alert verifyMessage"><span class="text-success">Available for: '+ codes[result] +'</span></div>');
			    	$('.orderbox').show();
			    }else{
			    	$('.verifyMessage').remove();
			    	$('label:contains("Server")').parent().append('<div class="alert verifyMessage"><span class="text-success">Available for: '+ codes[result] +'</span></div>');
			    	$('#pb_ip').removeAttr( "style" );
			    	$('label:contains("Public")').parent().find('input').val('');
			    	$('.orderbox').hide();
			    }
            }
        }
        
        if (force) {
            $('#cart3')[0].submit();
        } else {
            $('#preloader').remove();
            return true;
        }
    });
}


function queryResult (data)
{
    var codes   = {};
    if (data.indexOf("<!-- {") == 0) {
        codes   = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
    }
    return codes;
}
