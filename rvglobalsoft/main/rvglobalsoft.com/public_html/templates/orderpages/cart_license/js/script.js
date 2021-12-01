var previous = '';
var now = '';
$(document).ready( function () {
	
    if (step == 3) {
        setInterval(function () {
            $('#errors').hide();
        }, 50);
        $('#sidemenu').hide();
        $('.subProducts, .controlPanelProduct, .additionalProduct').hide();
        
        var ip      = $('label:contains("Server")').parent().next().find('input').val();
        if (ip == '') {
            $('label:contains("Server")').parent().next().find('input').val(currentIp);
        }
        
        /*var pb_ip      = $('label:contains("Public")').parent().next().find('input').val();
        if (pb_ip == '') {
            $('label:contains("Public")').parent().next().find('input').val(currentIp);
        }*/
        
        initiateProcess();
        
        $('label:contains("Server")').parent().next().find('input').keypress( function (e) {
            var code    = e.keyCode || e.which;
            if(code == 13) { //Enter keycode
                initiateProcess();
                return false;
            }
        });
        
        $('label:contains("Public")').parent().next().find('input').keypress( function (e) {
            var code    = e.keyCode || e.which;
            if(code == 13) { //Enter keycode
                initiateProcess();
                return false;
            }
        });
        
        $('input[value="Continue"]').click(function(e){
        	e.preventDefault();
        	$('#cart3').addLoader();
        	var ip              = $('label:contains("IP")').parent().next().find('input').val();
        	$.post(caUrl + '?cmd=productlicensehandle&action=verifyLicense', {
                ip          : ip
            }, function (data) {
            	var codes   = queryResult(data);
                var result  = codes.RESULT;
                if(result != 'AVAILABLE') {
                	$('#verifyMessage').remove();
                    $('label:contains("IP")').parent().next().append('<span id="verifyMessage" class="text-error">'+ codes[result] +'</span>');
                    $('#preloader').remove();
                } else {
                	$('#cart3').submit();
                }
            });
        });
        
    }
    
});

function initiateProcess ()
{
    var ip              = $('label:contains("Server")').parent().next().find('input').val();
    var pb_ip           = $('label:contains("Public")').parent().next().find('input').val();
    
    if (ip == '') {
        $('.billingCycle, .continueProcess, .serverType, .orderType').hide();
    }
    
    $('label:contains("Server")').parent().next().find('input').change(function(){
    	now = $(this).val();
    	if(now != previous){
    		var ip          = $(this).val();
    		verifyProductLicense(ip , '' , 'Server');
    	} else {
    		console.log('not validate');
    	}
    }).focus(function(){
    	previous = $(this).val();
    });
/*
    	if(event.keyCode == 13){
        var ip          = $(this).val();
        
        verifyProductLicense(ip , '' , 'Server');
    	}
    });
    */
    
    $('label:contains("Public")').parent().next().find('input').change( function () {
    	var ip              = $('label:contains("Server")').parent().next().find('input').val();
        var pb_ip          = $(this).val();

        verifyProductLicense(ip , pb_ip , 'Public');
    });
    
    if(typeof $('#pb_ip').css('display') != 'undefined' && $('#pb_ip').css('display') != 'none'){
    	verifyProductLicense(ip , pb_ip , 'Public');
    } else if(ip != ''){
    	verifyProductLicense(ip , '' , 'Server');
    }
}

function verifyProductLicense (ip , pb_ip , ip_type)
{
    $('#verifyMessage').remove();
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
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        
        $('#verifyMessage').remove();
        
        if (result == 'BLANKIP' || result == 'INVALIDIP' || result == 'NOMODULE' || result == 'NOTAVAILABLE') {
            if(ip_type == 'Server'){
            	$('label:contains("Server")').parent().next().append('<span id="verifyMessage" class="text-error">'+ codes[result] +'</span>');
           		$('#pb_ip').attr( "style","display:none" );
            }else if(ip_type == 'Public'){
            	$('#verifyMessage').remove();
            	$('label:contains("Public")').parent().next().append('<span id="verifyMessage" class="text-error">'+ codes[result] +'</span>');
            }
            $('.billingCycle, .continueProcess, .serverType, .orderType, .additionalProduct, .controlPanelProduct').hide();
            $('#sidemenu').hide();
            $('#verifyMessage').remove();
            $('label:contains("IP")').parent().next().append('<span id="verifyMessage" class="text-error">'+ codes[result] +'</span>');
        }
        
        if (result == 'AVAILABLE') {
            
            $('#sidemenu').show();
            
            $('.billingCycle, .continueProcess, .serverType, .orderType').show();
            setupServerType(codes);
            setupOrderType(codes);
            if(typeof codes.RISKSCORE != "undefined"){
            	setupRiskScore(codes);
            }
            displayControlPanelProduct();
            displayAdditionalProduct();
            displayAdditionalProductPrice();
            displayCloudLinuxOptional();
            displayLiteSpeedOptional();
            notifyServerType(codes, ip);
            currentIp   = ip;
            
            if(ip_type == 'Public'){
            	if (codes.hasOwnProperty('PRIVATEIP') && codes.PRIVATEIP.toString() == 'TRUE') {
			        $('#pb_ip').removeAttr( "style" );
			        $('label:contains("Public")').parent().next().find('input').val('');
			    	$('#verifyMessage').remove();
			    	$('label:contains("Public")').parent().next().append('<span id="verifyMessage" class="text-error">The Public IP Address is invalid.</span>');
			    	$('.billingCycle, .continueProcess, .serverType, .orderType, .additionalProduct, .controlPanelProduct').hide();
            		$('#sidemenu').hide();
			    }
            }else{
            	if(codes.hasOwnProperty('PRIVATEIP') && codes.PRIVATEIP.toString() == 'FALSE'){
			    	$('#pb_ip').attr( "style","display:none" );
			    	$('label:contains("Public")').parent().next().find('input').val(currentIp);
			    }else{
			    	$('#pb_ip').removeAttr( "style" );
			    	$('label:contains("Public")').parent().next().find('input').val('');
			    }
            }
            
        } else {
            $('.billingCycle, .continueProcess, .serverType, .orderType').hide();
        }
        
        simulateCart('#cart3');
        
        $('#preloader').remove();
        
    });
    
}

function notifyServerType (codes, ip)
{
    var oNotify         = $.parseJSON('{'+ codes.NOTIFY +'}');
    
    if (! oNotify.hasOwnProperty('serverType')) {
        return ;
    }
    if (! oNotify.serverType || ! codes.hasOwnProperty(''+ oNotify.serverType +'')) {
        return ;
    }
    
    var pid             = codes[oNotify.serverType].toString();
    if (currentIp != ip && oNotify.serverType != codes.TYPE) {
        $('#cart3').addLoader();
        document.location       = '?cmd=cart&action=add&id='+ pid;
    }
}

function displayCloudLinuxOptional ()
{
    var cl          = ['(cPanel Server)','(Other Server)'];
    $('select[name="CloudLinux"]').html('');
    $.each(cl, function (index, value) {
        var obj     = $('strong:contains("'+ value +'")').parent().next().find('select option:selected');
        var chk     = $('strong:contains("'+ value +'")').parent().prev().find('input');
        var selected= chk.is(':checked') ? true : false;
        if (obj.length) {
            $('select[name="CloudLinux"]').append($('<option>', {
                value   : value,
                selected:selected,
                text    : value +' '+ obj.text()
            }));
        }
    });
    
}

function displayLiteSpeedOptional ()
{
    var ls          = ['for VPS','Ultra VPS','1-CPU','2-CPU','4-CPU','8-CPU'];
    $('select[name="LiteSpeed"]').html('');
    $.each(ls, function (index, value) {
        var obj     = $('strong:contains("'+ value +' Lease")').parent().next().find('select option:selected');
        var chk     = $('strong:contains("'+ value +' Lease")').parent().prev().find('input');
        var selected= chk.is(':checked') ? true : false;
        if (isDedicated() && (value == 'for VPS' || value == 'Ultra VPS')) {
            return true;
        }
        if (! isDedicated() && (value != 'for VPS' && value != 'Ultra VPS')) {
            return true;
        }
        if (obj.length) {
            $('select[name="LiteSpeed"]').append($('<option>', {
                value   : value,
                selected:selected,
                text    : value +' '+ obj.text()
            }));
        }
    });
    
}

function setupServerType (codes)
{
    if (codes.hasOwnProperty('DEDICATED')) {
        $('input[name="server_type[Dedicated]"]').val(codes.DEDICATED.toString());
    }
    if (codes.hasOwnProperty('VPS')) {
        $('input[name="server_type[VPS]"]').val(codes.VPS.toString());
    }
    if (codes.hasOwnProperty('TYPE')) {
        var stype   = $('label:contains("Server Type")').parent().next().find('input');
        if (stype.length && stype.val()) {
            codes.TYPE      = stype.val();
        }
        $('input[name="server_type['+codes.TYPE+']"]').prop('checked', true);
    }
}

function setupOrderType (codes)
{
    $('label:contains("Order Type")').parent().next().find('input').val(codes.AVAILABLE.toString());
    $('.orderType').find('td span').html(codes.AVAILABLE.toString());
}

function setupRiskScore (codes)
{
	$('label:contains("Risk Score")').parent().next().find('input').val(codes.RISKSCORE.toString());
}

function displayControlPanelProduct ()
{
    var show        = 0;
    $('.controlPanelProduct').hide();
    
    if (findAndHideSubProduct('cPanel')) {
        show++;
        verifyAdditionalProductLicense('cPanel');
    }
    
    if (findAndHideSubProduct('ISPmanager')) {
        show++;
        verifyAdditionalProductLicense('ISPmanager');
    }
    
    if (show) {
        $('.controlPanelProduct').show();
    }
}

function displayAdditionalProduct ()
{
    var show        = 0;
    $('.additionalProduct').hide();
    
    if (findAndHideSubProduct('CloudLinux')) {
        show++;
        verifyAdditionalProductLicense('CloudLinux');
    }
    
    if (findAndHideSubProduct('RVSkin')) {
        show++;
        verifyAdditionalProductLicense('RVSkin');
    }
    
    if (findAndHideSubProduct('RVSiteBuilder')) {
        show++;
        verifyAdditionalProductLicense('RVSiteBuilder');
    }
    
    if (findAndHideSubProduct('LiteSpeed')) {
        show++;
        verifyAdditionalProductLicense('LiteSpeed');
    }
    
    if (findAndHideSubProduct('Softaculous')) {
        show++;
        verifyAdditionalProductLicense('Softaculous');
    }
    
    if (show) {
        $('.additionalProduct').show();
    }
    
}

function verifyAdditionalProductLicense (product)
{
    var ip          = $('label:contains("Server")').parent().next().find('input').val();
    var pb_ip       = $('label:contains("Public")').parent().next().find('input').val();
    
    if(pb_ip == '' || pb_ip == '-') pb_ip = ip;
    
    $('.'+ product +' td:eq(2)').html(loading);
    
    $('.'+ product +' td:eq(0) input[value="'+ product +'"]').prop('disabled', false);
    $.post(caUrl + '?cmd=productlicensehandle&action=verifyLicense', {
        product     : product,
        ip          : ip,
        pb_ip		: pb_ip
    }, function (data) {
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        
        if (result == 'BLANKIP' || result == 'INVALIDIP' || result == 'NOMODULE' || result == 'NOTAVAILABLE') {
            $('.'+ product +' td:eq(2)').html('<span class="text-error">'+ codes[result] +'</span>');
        }
        
        if (result == 'AVAILABLE') {
            $('.'+ product +' td:eq(2)').html('<span class="text-success"> Available for '+ codes.AVAILABLE +'</span>');
        } else {
            $('.'+ product +' td:eq(0) input[value="'+ product +'"]').prop('disabled', true);
            chooseSubProduct(product, false);
        }
        
    });
    
}

function displayAdditionalProductPrice ()
{
    $('input[name="controlpanel"]').each( function (i) {
        var price       = getSubProductPrice($(this).val());
        $(this).parent().remove('.controlPanelPrice').append('<span class="controlPanelPrice"> '+ price +'</span>');
    });
    $('input[name="additional"]').each( function (i) {
        var product     = $(this).val();
        if (product == 'CloudLinux') {
            product     = extendProductCloudLinux(product);
            return true;
        }
        if (product == 'LiteSpeed') {
            product     = extendProductLiteSpeed(product);
            return true;
        }
        var price       = getSubProductPrice(product);
        $(this).parent().remove('.subProductPrice').append('<span class="subProductPrice"> '+ price +'</span>');
    });
}

function findAndHideSubProduct (product)
{
    var cp          = $('.subProducts').find('td:contains(" - '+ product +'")').parent().find('td:eq(0) input');
    if (cp.is(':checked')) {
        $('.'+ product + ' td:eq(0) input').prop('checked', true);
    }
    
    var cp          = $('.subProducts').find('td:contains(" - '+ product +'")');
    if (cp.length) {
        $('.'+ product).show();
        return 1;
    } else {
        $('.'+ product).hide();
        return 0;
    }
}

function changeControlPanel (obj)
{
    if (obj.val() == 'cPanel') {
        if (isDedicated()) {
            document.location       = '?cmd=cart&action=add&id=155';
        } else {
            document.location       = '?cmd=cart&action=add&id=157';
        }
    }
    
    chooseSubProduct('cPanel', false);
    chooseSubProduct('ISPmanager', false);
    
    $('input[name="controlpanel"][value!="'+ obj.val() +'"]').prop('checked', false);
    
    if (obj.is(':checked')) {
        chooseSubProduct(obj.val(), true);
        if ($('select[name="CloudLinux"]').length) {
            if (obj.val() == 'cPanel') {
                $('select[name="CloudLinux"] option[value="(cPanel Server)"]').prop('selected', true);
            } else {
                $('select[name="CloudLinux"] option[value="(Other Server)"]').prop('selected', true);
            }
            changeAdditionalProduct($('input[value=CloudLinux]'));
        }
    }
    
    simulateCart('#cart3');
}

function changeServerType (obj)
{
    $('#cart3').addLoader();

    if (productName == 'CloudLinux') {
        $('input[name^="server_type"]').prop('checked', false);
        obj.prop('checked', true);
        
        $('label:contains("Server Type")').parent().next().find('input').val(obj.attr('title'));
        
        $('input[name="controlpanel"]').prop('checked', false);
        $('input[name="additional"]').prop('checked', false);
        $('input[name^="subproducts"]').prop('checked', false);
        $('.controlPanelPrice').remove();
        $('.subProductPrice').remove();
        
        displayLiteSpeedOptional();
        displayAdditionalProductPrice();
        simulateCart('#cart3');
        $('#preloader').remove();
        
    } else {
        document.location   = '?cmd=cart&action=add&id='+ obj.val();
    }
}

function changeAdditionalProduct (obj)
{
    var product     = obj.val();
    if (product == 'CloudLinux') {
        chooseSubProduct(product, false);
        product     = extendProductCloudLinux(product);
    }
    if (product == 'LiteSpeed') {
        chooseSubProduct(product, false);
        product     = extendProductLiteSpeed(product);
    }
    
    if (obj.is(':checked')) {
        chooseSubProduct(product, true);
    } else {
        chooseSubProduct(product, false);
    }
    
    simulateCart('#cart3');
}

function extendProductCloudLinux (product)
{
    var cl      = $('select[name="CloudLinux"] option:selected').val();
    product     += ' '+ cl;
    return product;
}

function extendProductLiteSpeed (product)
{
    var ls      = $('select[name="LiteSpeed"] option:selected').val();
    product     += (ls == 'for VPS') ? ' '+ ls : ' for '+ ls;
    return product;
}

function isDedicated ()
{
    return $('input[name="server_type[Dedicated]"]').is(':checked');
}

function chooseSubProduct (product, checked)
{
    if (productName == 'CloudLinux') {
        switch(product) {
            case 'cPanel':{ product = isDedicated() ? 'cPanel License (for dedicated server)' : 'cPanel License (for vps server)'; break;}
            case 'ISPmanager':{ product = isDedicated() ? 'ISPmanager Business' : 'ISPmanager Lite'; break;}
            case 'RVSkin':{ product = isDedicated() ? 'RVSkin leased (for dedicated server)' : 'RVSkin leased (for vps server)'; break;}
            case 'RVSiteBuilder':{ product = isDedicated() ? 'RVSiteBuilder (for dedicated server)' : 'RVSiteBuilder (for vps server)'; break;}
            case 'Softaculous':{ product = isDedicated() ? 'Softaculous for Dedicated' : 'Softaculous for VPS'; break;}
        }
    }
    var cp          = $('.subProducts').find('td:contains(" - '+ product +'")').parent().find('td:eq(0) input');
    if (cp.length) {
        cp.prop('checked', checked);
    }
}

function getSubProductPrice (product)
{
    if (productName == 'CloudLinux') {
        switch(product) {
            case 'cPanel':{ product = isDedicated() ? 'cPanel License (for dedicated server)' : 'cPanel License (for vps server)'; break;}
            case 'ISPmanager':{ product = isDedicated() ? 'ISPmanager Business' : 'ISPmanager Lite'; break;}
            case 'RVSkin':{ product = isDedicated() ? 'RVSkin leased (for dedicated server)' : 'RVSkin leased (for vps server)'; break;}
            case 'RVSiteBuilder':{ product = isDedicated() ? 'RVSiteBuilder (for dedicated server)' : 'RVSiteBuilder (for vps server)'; break;}
            case 'Softaculous':{ product = isDedicated() ? 'Softaculous for Dedicated' : 'Softaculous for VPS'; break;}
        }
    }
    return $('.subProducts').find('td:contains(" - '+ product +'")').parent().find('td:eq(2) select option:selected').text();
}

function queryResult (data)
{
    var codes   = {};
    if (data.indexOf("<!-- {") == 0) {
        codes   = eval("(" + data.substr(data.indexOf("<!-- ") + 4, data.indexOf("-->") - 4) + ")");
    }
    return codes;
}
