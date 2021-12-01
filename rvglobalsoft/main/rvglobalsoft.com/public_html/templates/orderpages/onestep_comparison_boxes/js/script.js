$(document).ready(function(){
    $('.server-details').click(function(){
        $('.server-details').removeClass('selected');
        $(this).addClass('selected');
        changeProduct();
        return false;
    });
    $('.client-toggle').click(function(){
        var val = $('.client-toggle-button').css('left');
        //alert(val);
        if(val == '0px' || val == 'auto'){
            $('.client-toggle-button').animate({
                'left': 108
            },
            250
            );
            $('#new-client').removeClass('active-client').addClass('inactive-client');
            $('#registered-client').removeClass('inactive-client').addClass('active-client');
            ajax_update('index.php?cmd=login',{layer:'ajax'},'#updater',true);
        }
        if(val == '108px'){
            $('.client-toggle-button').animate({
                'left': 0
            },
            250
            );
            $('#new-client').removeClass('inactive-client').addClass('active-client');
            $('#registered-client').removeClass('active-client').addClass('inactive-client');
            ajax_update('index.php?cmd=signup',{layer:'ajax'},'#updater',true);
        }
    });
})
function mainsubmit() {
    /*
        Called when submitting order
    */
    var v=$('input[name="gateway"]:checked');
    if(v.length>0) {
        $('#formtail').append("<input type='hidden' name='gateway' value='"+v.val()+"' />");
    }
    if($('input[name=domain]').length > 0 && $('input[name=domain]').attr('type') != 'radio')
       $('#formtail').append("<input type='hidden' name='domain' value='"+$('input[name=domain]').val()+"' />");
    return true;
}
function on_submit() {
    /*
        This function handles domain form
    */
    if($("input[value='illregister']").is(':checked')) {
        ajax_update('index.php?cmd=checkdomain&action=checkdomain&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val()+'&'+$('.tld_register').serialize(),{
            layer:'ajax',
            sld:$('#sld_register').val()
            },'#updater2',true);
    } else if ($("input[value='illtransfer']").is(':checked')) {
        ajax_update('index.php?cmd=checkdomain&action=checkdomain&transfer=true&sld='+$('#sld_transfer').val()+'&tld='+$('#tld_transfer').val()+'&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val(),{
            layer:'ajax'
        },'#updater2',true);
    } else if ($("input[value='illupdate']").is(':checked')) {
        ajax_update('index.php?cmd=cart&domain=illupdate&sld_update='+$('#sld_update').val()+'&tld_update='+$('#tld_update').val(),{
            layer:'ajax'
        },'#configer');
        $('#load-img').show();
    } else if ($("input[value='illsub']").is(':checked')) {
        ajax_update('index.php?cmd=cart&domain=illsub&sld_subdomain='+$('#sld_subdomain').val(),{
            layer:'ajax'
        },'#configer');
        $('#load-img').show();
    }

    return false;
}
function onsubmit_2() {
    /*
        Handle second step of domain bulk register
    */
    $('#load-img').show();
    ajax_update('index.php?cmd=cart&'+$('#domainform2').serialize(),{
        layer:'ajax'
    },'#configer');
    return false;
}

function applyCoupon() {
    var f = $('#promoform').serialize();
    ajax_update('?cmd=cart&addcoupon=true&'+f,{},'#configer');
    return false;
}
function simulateCart(forms, domaincheck) {
    /*
        Sends configuration data on each change made in forms and updates order prices/summary tab
    */
    $('#load-img').show();
    $('.order-summary').addClass('half-opacity');
    var urx = '?cmd=cart&';
    if(domaincheck) urx += '_domainupdate=1&';
    ajax_update(urx,$('#cartform').serializeArray(),'#configer');
}
function bindSimulateCart(){
    $('input, select','#cartform').bind('change',function(){
        var attr = $(this).attr('onchange') == undefined && $(this).attr('onclick') == undefined;
        if(attr) simulateCart();
    });
}
function removeCoupon() {
    ajax_update('?cmd=cart&removecoupon=true',{},'#configer');
    return false;
}
    
function changeProduct() {
    /*
        Change product, and load its configuration options
    */
   $('#configer').addClass('half-opacity');
   var pid = $('.selected .server-button input').val();
    if(pid==$('#pidi').val())
        return;
    $('#pidi').val(pid);

    $('#errors').slideUp('fast',function(){
        $(this).find('span').remove();
    });
    $('#load-img').show();
    $.post('?cmd=cart',{
        id: pid
    },function(data){
        var r = parse_response(data);
        $('#configer').removeClass('half-opacity');
        $('#configer').html(r);
    });
}  
function equalHeight(){
    var h = 0;
    $('.server-params').each(function(){
        if($(this).height() > h)
        h = $(this).height()
    }).height(h);
}