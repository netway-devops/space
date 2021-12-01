function tooltip(max,min,ui){
    var tooltip = $(ui.handle).parents('.slider').find('.tooltip');
    ui.value = min > ui.value ? min : ui.value;
    tooltip.find('.slider-value').text(ui.value);
    var slider = $(ui.handle).parents('.slider').find('.slider-background'),
    arrow = $(ui.handle).parents('.slider').find('.tooltip-arrow'),
    height = tooltip.height(),
    top = (slider.height() * (max - ui.value)) / (max - min) - (height/2 - 14) ,
    atop = top + (height/2-2);
 
    if(top < 0){
        top = 0;
    }
    else if(top + height - 30 > 271){
        top = 271-height+30;
    }  
    
    arrow.css({top:atop});
    tooltip.css({top:top});
}
var bootstrapcondisions = [];
function conditioncheck(a){
    if(typeof a == 'function'){
        bootstrapcondisions.push(a);
    }else if(a == undefined){
        for(var i =0; i < bootstrapcondisions.length; i++){
            bootstrapcondisions[i]();
        }
    }
}
function dragv(e,ui){

    var data = $(ui.helper).data('draggable'),
    slider = $(ui.helper).prevAll('.slider-background'),
    arrow = $(ui.helper).prev('.tooltip-arrow'),
    dragtop = data.position.top;
    
    arrow.css({top:dragtop + $(ui.helper).height()/2 -15});
    
    var top = arrow.position().top,
    percent = (slider.height() - top )/ slider.height(),
    min = slider.slider( "option" , 'min' ),
    max = slider.slider( "option" , 'max' ),
    value =  ((max-min) * percent) + min ;
    slider.slider("value" , value );

    if(ui.position.top < 0)
        data.position.top = 0;
    if($(ui.helper).height() + ui.position.top > 301){
        data.position.top = 301-$(ui.helper).height();
    }
}

function tooltiph(max,min,ui){
    var tooltip = $(ui.handle).parents('.slider-horizontal').find('.tooltip');
    ui.value = min > ui.value ? min : ui.value;
    tooltip.find('.slider-value').text(ui.value);
    var slider = $(ui.handle).parents('.slider-horizontal').find('.slider-background'),
    arrow = $(ui.handle).parents('.slider-horizontal').find('.tooltip-arrow'),
    width = tooltip.width(),
    left = slider.width() - (slider.width() * (max - ui.value)) / (max - min) - ((width-10)/2) -3,
    aleft = left + (width/2-3);
  
    if(left < -10){
        left = -10;
    }
    else if(left + width - 30 > 500){
        left = 500-width+30;
    }  

    arrow.css({left:aleft});
    tooltip.css({left:left});
}

function dragh(e,ui){

    var data = $(ui.helper).data('draggable'),
    slider = $(ui.helper).prevAll('.slider-background'),
    arrow = $(ui.helper).prev('.tooltip-arrow'),
    drag = data.position.left;

    arrow.css({left:drag + $(ui.helper).width()/2 -9});
    
    var left = arrow.position().left,
    percent = (slider.width() - left )/ slider.width(),
    min = slider.slider( "option" , 'min' ),
    max = slider.slider( "option" , 'max' ),
    value = max - ((max-min) * percent) + min ;
    slider.slider("value" , value );

    if(ui.position.left < -10)
        data.position.left = -10;
    if($(ui.helper).width() + ui.position.left > 530){
        data.position.left = 530-$(ui.helper).width();
    }
}

function tabbme(el) {
	$(el).parent().find('button').removeClass('active');
	$('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
	$('#options div.'+$(el).attr('rel')).show().find('input[type=radio]').attr('checked','checked');
    $(el).addClass('active');
}

function simulateCart(forms, domaincheck) {
	$('.loadergif').css({visibility:'visible'});
    var cart = [];
    cart[0] = $('#cart0').serialize();
    cart[1] = $('#cart1').serialize();
    cart[2] = $('#cart2').serialize();
    cart[3] = $('#cart3').serialize();
    cart[4] = $('#gatewaylist').serialize();
    cart[5] = $('.cartD').serialize();
    
    query = '';
    for(var i = 0; i<6; i++){
        if(cart[i].length){
            if(query.length > 0){query += '&';}
            query += cart[i];
        }
    }
	var urx = '?cmd=cart';
	if(domaincheck) urx += '_domainupdate=1';
	ajax_update(urx,query,'#refreash');
    if(forms == 'gatewaylist'){
        ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id='+$('#gatewaylist').children('select').val(), '', '#gatewayform',true)
    }
}

function on_submit() {
	if($("input[value='illregister']").is(':checked')) {
		//own
		ajax_update('index.php?cmd=checkdomain&action=checkdomain&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val()+'&'+$('.tld_register').serialize(),{
			layer:'ajax',
			sld:$('#sld_register').val()
			},'#updater2',true);
	} else if ($("input[value='illtransfer']").is(':checked')) {
		//transfer
		ajax_update('index.php?cmd=checkdomain&action=checkdomain&transfer=true&sld='+$('#sld_transfer').val()+'&tld='+$('#tld_transfer').val()+'&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val(),{
			layer:'ajax'
		},'#updater2',true);
	} else if ($("input[value='illupdate']").is(':checked')) {
		ajax_update('index.php?cmd=cart&domain=illupdate&sld_update='+$('#sld_update').val()+'&tld_update='+$('#tld_update').val(),{
			layer:'ajax'
		},'#refreash');
		$('.load-img').show();
	} else if ($("input[value='illsub']").is(':checked')) {
		ajax_update('index.php?cmd=cart&domain=illsub&sld_subdomain='+$('#sld_subdomain').val(),{
			layer:'ajax'
		},'#refreash');
		$('.load-img').show();
	}
	return false;
}
function onsubmit_2() {
	$('.load-img').show();
	ajax_update('index.php?cmd=cart&'+$('#domainform2').serialize(),{
		layer:'ajax'
	},'#refreash');
	return false;
}

function mainsubmit(formel) {
	var v=$('select[name="gateway"]').val();
	if(v) {
		$(formel).append("<input type='hidden' name='gateway' value='"+v+"' />");	
	}
	if($('input[name=domain]').length > 0 && $('input[name=domain]').attr('type') != 'radio')
		$(formel).append("<input type='hidden' name='domain' value='"+$('input[name=domain]').val()+"' />");
	return true;
}

function applyCoupon() {
	ajax_update('?cmd=cart&addcoupon=true',$('#promoform').serializeArray(),'#refreash');
	return false;
}

function removeCoupon() {
	
	ajax_update('?cmd=cart',{
		removecoupon:'true'
	},'#refreash');
	return false;
}

var customization = false;
function customize(el){
    if(!$(el).hasClass('active')){
        $(el).fadeOut();
        $('.slider-horizontal .slider-background').each(function(){
            var el = this;
            setTimeout(function(){
                tooltiph($(el).slider('option','max'),$(el).slider('option','min'),{value:$(el).slider('option','value'), handle: $(el).find('.ui-slider-handle')});
                fix_state();
            },60);
        });
        $('.customizer2, .customizer').fadeIn(); 
        customization = true;
        $(el).addClass('active');
    }
    else{
        $('.customizer2, .customizer').fadeOut();
        customization = false;
        $(el).removeClass('active');
    } 
}
function setcustomvisible(submit){
    if(customization || submit){
        customization = true;
        $('.customizer2, .customizer').show(); 
        $('.btn.btn-primary').addClass('active').hide();
        fix_state();
    }else{
        $('.customizer2, .customizer').hide(); 
        $('.btn.btn-primary').removeClass('active').show();
    }
}
function fix_state(){
    if(typeof states != 'undefined'){
        var old = $("select[name=country]").val();
        $("select[name=country] option").each(function(){
            if(typeof states[this.value] == 'undefined'){
                $("select[name=country]").val(this.value).change().val(old).change();
                return false;
            }
        });
    }
}
function changecycle(a,b){
    $('.btn.dropdown-toggle.cycles').find('.btn-value').text(b).end().next('input').val(a);
    simulateCart();
    return false;
}
function changecurrency(id){
    $('input[name="currency"]').val(id);
    $('#cart0').append('<input name="action" type="hidden" value="changecurr"><input name="currency" type="hidden" value="'+id+'">');
    $('#cart0').submit();
    return false;
}