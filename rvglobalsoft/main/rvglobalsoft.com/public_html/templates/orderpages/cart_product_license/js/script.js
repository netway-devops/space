var aCart       = {};


$(document).ready( function () {
    
    $('#ipaddress').change( function () {
        
    });
    
    if (step == 3) {
        $('#ipaddress').prop('readonly', true);
        verifyShoppingCart();
    }
    
});

function verifyShoppingCart ()
{
    /* --- validate existed in cart --- */
    $.get(caUrl + '?cmd=productlicensehandle&action=getCurrentOrderItem', function (data) {
        var codes   = queryResult(data);
        aCart       = codes.RESULT[0];
        
        if (aCart.product != '') {
            $('#product').val(aCart.product);
            $('#productId').val(aCart.productId);
            $('#ipaddress').val(aCart.ipaddress);
            $('#formAddCart').find('input[name="CartIndex"]').val(''+ aCart.CartIndex +'');
            
            var isEmpty     = $('#ipaddress').val();
            if (isEmpty == '') {
                $('#ipaddress').prop('readonly', false);
            }
            
            verifyProductLicense(aCart.product, aCart.ipaddress);
            
        }
        
    });
}

function loadProductInfo (productName)
{
    $.get(caUrl + '?cmd=productlicensehandle&action=productInfo&product='+ productName, function (data) {
        $('#productModalContent').html(data);
    });

}

function verifyProductLicense (product, ip)
{
    // Main
    $('#verify').show();
    $('.verifyMessage').show();
    $('#verifyMessage').html('');
    
    // Next
    $('.orderType').hide();
    $('.serverType').hide();
    $('.billingCycle').hide();
    $('.additionalProduct').hide();
    
    $.post(caUrl + '?cmd=productlicensehandle&action=verifyLicense', {
        product     : product,
        ip          : ip
    }, function (data) {
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        
        if (result == 'BLANKIP' || result == 'NOMODULE' || result == 'NOTAVAILABLE') {
            $('#verifyMessage').html('<span class="text-error">'+ codes[result] +'</span>').show();
        }
        
        $('#verify').hide();
        
        if (result == 'AVAILABLE') {
            $('.verifyMessage').hide();
            licenseAvailable(product, codes);
        }
        
    });
    
}

function licenseAvailable (product, codes)
{
    $('input[name="order_type"]').val(codes.AVAILABLE);
    $('#orderType').html('<span class="text-success">'+ codes.AVAILABLE +'</span>');
    $('.orderType').show();
    
    if (codes.hasOwnProperty('TYPE')) {
        $('input[name="server_type"]').prop('checked', false);
        var sType       = aCart.hasOwnProperty('serverType') ? aCart.serverType : codes.TYPE;
        $('input[name="server_type"][value="'+ sType +'"]').prop('checked', true);
        $('.serverType').show();
    }
    
    getBillingCycle();
}

function getBillingCycle ()
{
    
    $('.billingCycle').hide();
    $('.additionalProduct').hide();
    
    var product     = $('input[name="product"]').val();
    var stype       = $('input[name="server_type"]:checked').val();
    
    $('.serverType').addLoader();
    $('#continueProcess').hide();
    $.post(caUrl + '?cmd=productlicensehandle&action=getBillingCycle', {
        product     : product,
        type        : stype
    }, function (data) {
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        
        if (result == 'success') {
            $('#productId').val(''+ codes.PRODUCTID +'');
            
            var bc  = codes.BILLINGCYCLE;
            var sel = codes.RECURRING;
            $('#billingCycle').find('option').remove().end();
            $.each(bc, function(i, items) {
                $.each(items, function(j, item) {
                    $('#billingCycle').append('<option value="'+ j +'" '+ ((j == sel) ?' selected="selected" ':'')+'>'+ item +'</option>');
                });
            });
            
            $('.billingCycle').show();
            
            addToShoppingCart();
            displayAdditionalProduct();
            
        }
        
        $('#preloader').remove();
    });
    
}

function changeBillingCycle ()
{
    $('.additionalProduct').hide();
    $('#continueProcess').hide();
    $.get(caUrl + '?cmd=productlicensehandle&action=getCurrentCartIndex', function (data) {
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        if (result == '') {
            result  = $('#formAddCart').find('input[name="CartIndex"]').val();
        }
        if (result != '') {
            $.get(caUrl + '?cmd=cart&cart=edit&order='+ result, function () {
                $.get(caUrl + '?cmd=productlicensehandle&action=getSubProduct', function (data) {
                    var codes   = queryResult(data);
                    var result  = codes.RESULT[0];
                    updateShoppingCart(result);
                });
            });
        }
    });
    displayAdditionalProduct();
}

function addToShoppingCart ()
{
    var product         = $('#product').val();
    var productId       = $('#productId').val();
    var billingCycle    = $('#billingCycle').val();
    var ipaddress       = $('#ipaddress').val();
    var serverType      = $('input[name="server_type"]:checked').val();
    
    /* --- validate existed in cart --- */
    $.post(caUrl + '?cmd=productlicensehandle&action=isExistedInCart', {
        product     : product,
        productId   : productId,
        ipaddress   : ipaddress,
        serverType  : serverType
    }, function (data) {
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        
        if (result == 'FALSE') {
            var f   = codes.FALSE[0];
            
            $('#formAddCart').find('input[name="id"]').val(''+ productId +'');
            $('#formAddCart').find('input[name="cycle"]').val(''+ billingCycle +'');
            
            if (f.hasOwnProperty('idx')) {
                $.get(caUrl + '/cart?cart=clear&order='+ f.idx, function (data) {
                    $('#orderFormArea').addLoader();
                    $('#formAddCart')[0].submit();
                });
            } else {
                $('#orderFormArea').addLoader();
                $('#formAddCart')[0].submit();
            }
            
        } else {
            $.get(caUrl + '?cmd=productlicensehandle&action=getSubProduct', function (data) {
                var codes   = queryResult(data);
                var result  = codes.RESULT[0];
                updateShoppingCart(result);
            });
        }
        
    });
    
}

function updateShoppingCart (subproduct)
{
    var productId       = $('#productId').val();
    var billingCycle    = $('#billingCycle').val();

    var subproduct    = typeof subproduct !== 'undefined' ? subproduct : {};
    var subproducts         = {};
    var subproducts_        = '';
    var subproducts_cycles  = {};
    var subproducts_cycles_ = '';
    if (subproduct.length) {
        $.each(subproduct, function(i, val) {
            subproducts[val]        = 1;
            subproducts_            += '&subproducts['+ val +']=1';
            subproducts_cycles[val]    = billingCycle;
            subproducts_cycles_     += '&subproducts_cycles['+ val +']='+ billingCycle;
        });
    }
    
    $.post(caUrl + '?cmd=productlicensehandle&action=customfieldData', {
        productId   : productId,
    }, function (data) {
        var codes   = queryResult(data);
        var result  = codes.RESULT[0];
        
        var custom_ = codes.RESULT_STRING;
        
        // --- add --- 
        $.post(caUrl + '?cmd=cart&step=3', {
            action      : 'addconfig',
            custom      : result,
            subproducts : subproducts,
            subproducts_cycles  : subproducts_cycles,
            cycle       : billingCycle,
        }, function (data) {
            if(typeof(simulateCart) == 'function') {
                //simulateCart('#cart3');
                ajax_update('?cmd=cart&step=3&action=addconfig&'+ custom_ + subproducts_ + subproducts_cycles_ 
                    +'&cycle='+ billingCycle, {'simulate':'1'},'#cartSummary');
            }
            
            // --- add to AppSettings - Cart --- 
            $.post(caUrl + '?cmd=cart&step=4', {}, function () {
                $.get(caUrl + '?cmd=cart', {}, function () {
                    
                    // --- add order type ---
                    var cartIndex       = $('#formAddCart').find('input[name="CartIndex"]').val();
                    var orderType       = $('input[name="order_type"]').val();
                    
                    var subOrderType    = {};
                    $('input[name="additional_product[]"]').each( function (idx) {
                        var name        = $(this).val();
                        var id          = $('input[name="additional_product_id['+ name +']"]').val();
                        var type        = $('input[name="additional_product_order_type['+ name +']"]').val();
                        subOrderType[id]    = type;
                    });
                    
                    $.post(caUrl + '?cmd=productlicensehandle&action=addOrderType', {
                        index       : cartIndex,
                        type        : orderType,
                        sub         : subOrderType
                    }, function (data) {
                        $('#continueProcess').show();
                        
                    });
                    
                });
            });
            
        });
        
    });
}

function displayAdditionalProduct ()
{
    $('.additionalProduct').show();
    verifyAdditionalProducts();
}

function verifyAdditionalProducts ()
{
    var ip          = $('#ipaddress').val();
    $.get(caUrl + '?cmd=productlicensehandle&action=getSubProduct', function (data) {
        var code    = queryResult(data);
        var aSub    = code.RESULT[0];
    
        
        var loading     = '<span><img src="'+ systemUrl +'templates/netwaybysidepad/img/ajax-loading2.gif" align="left" /> &nbsp; Validating</span>';
        $('input[name="additional_product[]"]').each( function (idx) {
            var product     = $(this).val();
            
            $(this).prop('disabled', true);
            $('#additionalVerify'+ product +'').html(loading);
            
            $.post(caUrl + '?cmd=productlicensehandle&action=verifyLicense', {
                product     : product,
                ip          : ip
            }, function (data) {
                var codes   = queryResult(data);
                var result  = codes.RESULT;
                
                if (result == 'BLANKIP' || result == 'NOMODULE' || result == 'NOTAVAILABLE') {
                    $('#additionalVerify'+ product +'').html('<span class="text-error">'+ codes[result] +'</span>').show();
                }
                
                if (result == 'AVAILABLE') {
                    $('input[name="additional_product_order_type['+ product +']"]').val(codes.AVAILABLE);
                    $('#additionalVerify'+ product +'').html('<span class="text-success">Available for '+ codes.AVAILABLE +'</span>');
                    getAdditionalBillingCycle(product, aSub);
                }
                
            });
        });
        
    });
}

function getAdditionalBillingCycle (product, aSub)
{
    var stype       = $('input[name="server_type"]:checked').val();
    
    $.post(caUrl + '?cmd=productlicensehandle&action=getBillingCycle', {
        product     : product,
        type        : stype
    }, function (data) {
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        
        $('#additionalBillingCycle'+ product +'').html();
        if (result == 'success') {
            $('#additionalProductId_'+product+'').val(''+ codes.PRODUCTID +'');
            $('input[name="additional_product[]"][value="'+ product +'"]').prop('disabled', false);
            
            $.each(aSub, function (k,v) { if (v == codes.PRODUCTID) {
                $('input[name="additional_product[]"][value="'+ product +'"]').prop('checked', true);
                return false; 
            } });
            
            var bc  = codes.BILLINGCYCLE[0];
            var x   = $('#billingCycle').val();
            $.each(bc, function (k, v) {
                if (k == x) {
                    $('#additionalBillingCycle'+ product +'').html(''+ v +'');
                }
            });
        }
            
    });
    
}

function additionalToShoppingCart ()
{
    var subproduct       = [];
    $('#continueProcess').hide();
    $('#additionalFormArea').addLoader();
    $('input[name="additional_product\[\]"]').each( function () {
        if ($(this).is(':checked')) {
            subproduct.push($('#additionalProductId_'+ $(this).val() +'').val());
        }
    });
    
    $.get(caUrl + '?cmd=productlicensehandle&action=getCurrentCartIndex', function (data) {
        var codes   = queryResult(data);
        var result  = codes.RESULT;
        if (result == '') {
            result  = $('#formAddCart').find('input[name="CartIndex"]').val();
        }
        if (result == 'undefined') {
            $.get(caUrl + '?cmd=productlicensehandle&action=getLatestCartIndex', function (data) {
                var codes   = queryResult(data);
                var result  = codes.RESULT;
                $.get(caUrl + '?cmd=cart&cart=edit&order='+ result, function () {
                    updateShoppingCart(subproduct);
                });
            });
        } else {
            $.get(caUrl + '?cmd=cart&cart=edit&order='+ result, function () {
                updateShoppingCart(subproduct);
            });
        }
        
        $('#preloader').remove();
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
