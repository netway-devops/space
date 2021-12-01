var borders = [];
$(function(){
	
	alignCloud();
    $('.slider-clouds li').each(function(i){
        var el = $(this);
        borders[i] = el.position().left+(el.width()/2)
    });
	$('#main-slider').slider({
		range: "min",
        value: 1,
        min: 1,
        max: $('.slider-clouds li').length*20,
        step: 1,
		slide: function(event, ui){ 
			setClouds(ui);
        },
        change: function(event, ui){ 
            setClouds(ui);
            var pid = $('.slider-clouds li.active-cloud:last').attr('rel');
            if(pid)
                changeProduct(pid);
        }
    }).addClass('large-slider-handle'); //Adding class with large slider handle and background without pattern
    setSlider($('.slider-clouds li[rel='+$('#pidi').val()+']').index());
	/*
	* Add New option button
	*/
	
	if($('#checkbox-tos').length){
        $('#checkbox-tos').click(function(){
            //checking if checkbox with terms of service is selected
            if($(this).is(':checked'))
                //Setting submit button to clickable 
                $('.checkout-button').removeClass('disabled').removeAttr('disabled');
            else
                $('.checkout-button').addClass('disabled').attr('disabled', 'disabled');
        })
    }else{
        $('.checkout-button').removeClass('disabled').removeAttr('disabled');
    }
    $(document).delegate('#updater2 input[type=submit]', 'click', function(){
        submitDomains();
        return false;
    });
})

function submitDomains() {
    $('.ajax-overlay:last').show();
    ajax_update('index.php?cmd=cart&'+$('input, select, textarea','#updater2').serialize(),{
        layer:'ajax'
    },'#update');
    return false;
}
function tabbme(el) {
    $(el).parent().find('button').removeClass('active');
    $('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
    $('#options div.'+$(el).attr('rel')).show().find('input[type=radio]').attr('checked','checked');
    $(el).addClass('active');
}

function setClouds(ui){
    var elements = Math.ceil(ui.value/20);
    var wid = $('.top-slider-bg').width(),
    count = $('.slider-clouds li').length*20,
    step = wid/count;
    for(var i=0; i<borders.length; i++){
        if(borders[i] > step*ui.value){
            elements = i;
            break;
        }
    }
    if(elements<1)
        elements = 1;
    $('.slider-clouds li').removeClass('active-cloud').filter(':lt('+elements+')').addClass('active-cloud');
}

function setSlider(to, event){
    if(event){
        if($(event.target).offset().left > event.clientX)
            to--;
    }
    if(to<1)
        to = 0;
    var slide = borders[to] / ($('.top-slider-bg').width()/($('.slider-clouds li').length*20));
    $('#main-slider').slider('value', Math.ceil(slide));
}

function clientForm(login){
    if(login){
        ajax_update('?cmd=login',{
            layer:'ajax'
        },'#clientform',true); 
        $('#clientform').removeClass('new-client').addClass('existing-client');
    }else{
        ajax_update('?cmd=signup',{
            layer:'ajax'
        },'#clientform',true); 
        $('#clientform').addClass('new-client').removeClass('existing-client');
    }
    $('.client-list .dropdown-toggle').html($('.client-list .dropdown-menu a').eq(login ? 1 : 0).text() + ' <span class="caret"></span>');
    return false;
}

function mainsubmit(formel) {
    $(formel).append('<input type="hidden" name="gateway" value="'+$('.payment-methods input[name=gateway]:checked').val()+'" />')
    return true;
}

function applyCoupon(form) {
    ajax_update('?cmd=cart&addcoupon=true',$(form).serializeArray(),'#update');
    return false;
}

function removeCoupon() {
	
    ajax_update('?cmd=cart',{
        removecoupon:'true'
    },'#update');
    return false;
}

function changeProduct(pid) {
    if($('#pidi').val() == pid)
        return;
    $('#errors').slideUp('fast', function () {
        $(this).find('span').remove();
    });

    
    $.post('?cmd=cart', {
        id: pid
    }, function (data) {
        var r = parse_response(data);
        $('#update').html(r);
        $('#update').removeClass('ajax');
    });
}
function bindSimulateCart(){
    $('[name^=addon], [name^=subproduct], [name=ostemplate], [name=domain], [name=cycle]','#cartforms, .billing-cycle').filter(function(){
        return !$(this).parents('#domoptions11').length
    }).bind('change',function(){
        var attr = $(this).attr('onchange') == undefined && $(this).attr('onclick') == undefined;
        if(attr) simulateCart();
    });
}
function simulateCart(forms, domaincheck) {
    /*
        Sends configuration data on each change made in forms and updates order prices/summary tab
         */
    var urx = '?cmd=cart',
    form = $('input, select, textarea','#cartforms, .billing-cycle').filter(function(){
        if($(this).parents('#domoptions11, .toggle-slider.domains').length) return false;
        return true
    });
    if(domaincheck) urx += '&_domainupdate=1&';
    $('.ajax-loader:last').css('visibility','visible');
    $('.summary-bg').addClass('half-opacity');
    $.post(urx, form.serializeArray(), function(data){
        var resp = parse_response(data);
       // $('#update').html(resp);
       $('#summarybox').html($('#summarybox',resp).html());
    });
    //ajax_update(urx, form.serializeArray(), '#update');
}
function domainCheck() {
    /*
        This function handles domain form
         */
    var action = $("input[name=domain]:checked").val(),
    url = '?cmd=checkdomain&action=checkdomain&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val(),
    param = {
        layer:'ajax'
    },
    target = '#updater2';
    switch(action){
        case 'illregister':
            url+='&'+$('.tld_register').serialize();
            param.sld=$('#sld_register').val();
            break;
        case 'illtransfer':
            param.sld=$('#sld_transfer').val();
            param.tld=$('#tld_transfer').val();
            param.transfer='true';
            break;
        case 'illupdate':
            url='?cmd=cart&domain=illupdate';
            param.sld_update=$('#sld_update').val();
            param.tld_update=$('#tld_update').val();
            target = '#update';
            break;
        case 'illsub':
            url='?cmd=cart&domain=illsub';
            param.sld_subdomain=$('#sld_subdomain').val();
            target = '#update';
            break;
    }
    if(target == '#updater2')
        $('<span class="ajax-loader"></span>').appendTo($(target).html(''));
    ajax_update(url,param,target);

    return false;
}

function reform_ccform(html){
    $('#gatewayform .wbox').attr('class', 'white-box').children('.wbox_header').attr('class', 'white-box-header')
    .children().contents().unwrap().wrap('<div class="white-box-header-bg"><h2 class="bold"></h2></div>').end().end()
    .append('<div class="white-box-header-img"></div>').end().children('.wbox_content').attr('class','white-container ccform')
    .wrap('<div class="white-container-bg"></div>');
}
function pop_ccform(valu){
    $('#gateway_form').val(valu);
    $.post('?cmd=cart&action=getgatewayhtml&gateway_id='+valu, '', function(data){
        var data = parse_response(data);
        if(data.length){
            $('#gatewayform').html(data);
            reform_ccform();
            $('#gatewayform').slideDown();
        }else $('#gatewayform').slideUp('fast', function(){
            $(this).html('')
        });
    });
}
function alignCloud(){
    var clouds = $('.slider-clouds'),
    wid = clouds.width(),
    count = clouds.children('li').length,
    part = Math.floor( (wid/count)*10 )/10;
    clouds.children('li').width( part ).children('span').css('left', part<=120?(part-120)/2:0);
}
$(document).bind('fieldLogicLoaded', function(event, fl){
    $.fieldLogic.getContainer = function(cond){
        return $(cond.target).parent().parent() ;
    };
});