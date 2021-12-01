var svgobj = [];
var svgprop = {
    R: 95,
    barwidth: 18,
    offsetx: 53,
    offsety: 100,
    portion: 298,
    rotation: -60,
};
$(window).load(function(){  
    fixHeaders();
});
var gaugecnditions = [];
function conditioncheck(a){
    if(typeof a == 'function'){
        gaugecnditions.push(a);
    }else if(a == undefined){
        for(var i =0; i < gaugecnditions.length; i++){
            gaugecnditions[i]();
        }
    }
}
$(document).ready(function(){
    conditioncheck();
    $('a[href]').each(function(){
        if($(this).attr('href').substr(0,4) != 'http')
            $(this).attr('href', $('#system_url').val()+$(this).attr('href'));
    });
    fixImg();
    $('#customize').click(function(){
        var t = $(this);
        t.parent().parent().height(t.parent().parent().height()).end().fadeOut(500, function(){
            t.hide().next().show().parent().fadeIn(500)
            });
        $('.step-1, #promocode').fadeOut(500, function(){
            $('.step-2, #promocode').fadeIn(500)
            });
        return false;
    });
    	
    $('.circle-slider').each(function(i){
        var paper = Raphael(this);
        var R = 100, offsetx = 50, offsety = 100;
        $(paper.canvas).css({
            position:'absolute'
        }).addClass('svgcanvas');
        svgobj[this.id] = {
            bg:false, 
            arrow:false
        };
        svgobj[this.id].bg = paper.path(get_gauge(180, 360, svgprop.R, svgprop.offsetx, svgprop.offsety)).attr({
            "fill": "url("+$('#system_url').val()+"templates/orderpages/onestep_gauge/img/gradient.png)",
            'stroke-width':0
        });
        paper.image($('#system_url').val()+'templates/orderpages/onestep_gauge/img/circle.png', 0, 0, 200, 200);
        //svgobj[this.id].arrow = paper.path("M100 32 L100 26").attr({'arrow-end':'block-wide-medium', 'stroke-width':2, stroke:'#0C88E5'});
        svgobj[this.id].arrow = paper.path([["M", R, 2*R-30],["M", R, 36],['L', R+5, 36],['L', R, 30], ['L', R-5, 36]]).attr({
            'stroke-width':0, 
            fill:'#0C88E5'
        });
    });
    $('.product-configuration .cart-switch span').click(function(){
        if($(this).hasClass('active'))
            return false;
        var act = $('.product-configuration .cart-switch span.active'),
        ths = $(this);
        $('.product-configuration .cart-switch div').css(act.position())
        .width(act.width())
        .height(act.removeClass('active').addClass('pre-active').height())
        .show()
        .animate(ths.position(),'fast','swing',function(){
            ths.addClass('active');
            act.removeClass('pre-active');
            $('.product-configuration .cart-switch div').hide();
            return false;
        });
    });
    setTimeout(fixHeaders, 500);
    fixAlternation();
    function getBGPos(){
        var str = $('.clicktrough').css('background-position');
        return {
            x:parseInt(str.substring(0, str.indexOf(' '))), 
            y:parseInt(str.substring(str.indexOf(' ')+1))
            };
    }
    $(document).ajaxStop(function(){
        fixImg();
        window.singup_image_reload = function singup_image_reload(){var d = new Date(); $('.capcha:first').attr('src', $('#system_url').val()+'?cmd=root&action=captcha#' + d.getTime());return false;}
    });
});
$('base').remove();
function fixImg(){
    $('.credit_card').each(function(){
       $(this).css('background-image', 'url("' +$(this).css('background-image').replace(/.*(templates.*\/)/, $('#system_url').val() + '\\$1') )
    });
    $('img').each(function(){
        var that = $(this),
        sysurl = $('#system_url').val();
        that.attr('src', sysurl+that.attr('src').replace(sysurl,''));
    });
}

function fixHeaders(){
    $('div.circle-header:visible div:not(.green)').each(function(i){
        $(this).text(i+1)
        });
    $('div.circle-header:visible h2').each(function(){
        var m = true, i=10; 
        while(i-- > 0 && m > 0 && $(this).position().top > $(this).nextAll('.hr').position().top) {
            m = parseInt($(this).css('margin-right'));
            $(this).css('margin-right', (m-1)+'px');
        }
    });
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
function bindCycleSwitch(){
    $('#cycleswitch span').click(function(){
        if($(this).hasClass('active'))
            return false;
        var act = $('#cycleswitch span.active'),
        ths = $(this);
        $('#cycleswitch div').css(act.position())
        .width(act.width())
        .height(act.removeClass('active').addClass('pre-active').height()).show()
        .animate(ths.position(),'fast','swing',function(){
            ths.addClass('active');
            act.removeClass('pre-active');
            $('#cycleswitch div').hide();
            $('input[name="cycle"]').val(ths.attr('rel'));
            simulateCart();
            return false;
        });
    });
}
function changecurrency(id){
    $('input[name="currency"]').val(id);
    $('#cart0').append('<input name="action" type="hidden" value="changecurr"><input name="currency" type="hidden" value="'+id+'">');
    $('#cart0').submit();
    return false;
}
function tabbme(el) {
    $(el).parent().find('button').removeClass('active');
    $('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
    $('#options div.'+$(el).attr('rel')).show().find('input[type=radio]').attr('checked','checked');
    $(el).addClass('active');
}

function simulateCart(forms, domaincheck) {
    conditioncheck();
    $('.ajax').show();
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
            if(query.length > 0){
                query += '&';
            }
            query += cart[i];
        }
    }
    var urx = '?cmd=cart';
    if(domaincheck) urx += '_domainupdate=1';
    ajax_update(urx,query,'#update');
    if(forms == 'gatewaylist'){
        $.post('?cmd=cart&action=getgatewayhtml&gateway_id='+$('#gatewaylist').children('select').val(), {}, function(data){
            data = parse_response(data);
            $('#gatewayform').html(data);
            fixAlternation();
            fixImg();
        })
    //ajax_update('?cmd=cart&action=getgatewayhtml&gateway_id='+$('#gatewaylist').children('select').val(), '', '#gatewayform',true)
    }
    
}
function fixAlternation(){
    var i = 0;
    $('.item, #gatewayform','.product-configuration').each(function(){
        if(!$(this).children().length)
            return;
        if(i%2 == 0 && !$(this).hasClass('even')){ 
            $(this).addClass('even')
        }else if(i%2 != 0 && $(this).hasClass('even')){
            $(this).removeClass('even');
        }
        i++;
    });
}

function applyCoupon() {
    ajax_update('?cmd=cart&addcoupon=true',$('#promoform').serializeArray(),'#update');
    return false;
}

function removeCoupon() {
	
    ajax_update('?cmd=cart',{
        removecoupon:'true'
    },'#update');
    return false;
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
        },'#update');
        $('.load-img').show();
    } else if ($("input[value='illsub']").is(':checked')) {
        ajax_update('index.php?cmd=cart&domain=illsub&sld_subdomain='+$('#sld_subdomain').val(),{
            layer:'ajax'
        },'#update');
        $('.load-img').show();
    }
    return false;
}
function onsubmit_2() {
    $('.load-img').show();
    ajax_update('index.php?cmd=cart&'+$('#domainform2').serialize(),{
        layer:'ajax'
    },'#update');
    return false;
}
function get_gauge(value, total, R, offsetx, offsety) {
    value = value < 0 ? 0 : (value > total ? value = total : value);
    var rotation = svgprop.rotation, 
    barw = svgprop.barwidth,
    alpha = svgprop.portion / total * value, path = [],
    a = (rotation+alpha) * (Math.PI / 180),
    x = (offsetx+R/2) - R * Math.cos(a),
    y = offsety - R * Math.sin(a),
    
    xm = (offsetx+R/2) - (R-barw) * Math.cos(a),
    ym = offsety - (R-barw) * Math.sin(a),
    
    xs = (offsetx+R/2) - R * Math.cos(rotation *(Math.PI / 180)),
    ys = offsety - R * Math.sin(rotation * (Math.PI / 180)),
    
    xsm = (offsetx+R/2) - (R-barw) * Math.cos(rotation *(Math.PI / 180)),
    ysm = offsety - (R-barw) * Math.sin(rotation * (Math.PI / 180));

    if (total <= value) 
        //path = [["M", xs,ys], ["A", R, R, 0, 1, 1, x, y],['L', offsetx+R/2,offsety]];
        path = [["M", xs,ys], ["A", R, R, 0, 1, 1, x, y], ['L', xm, ym], ["A", (R-barw), (R-barw), 0, +(alpha > 180), 0, xsm, ysm]];
    else if(value < 1)
        path = [["M", xs,ys], ["A", R, R, 0, 1, 1,xs,ys], ['L', xm, ym], ["A", (R-barw), (R-barw), 0, 1, 0, xsm, ysm]];
    else
        //path = [["M", xs,ys], ["A", R, R, 0, +(alpha > 180), 1, x, y],['L', offsetx+R/2,offsety]]
        path = [["M", xs,ys], ["A", R, R, 0, +(alpha > 180), 1, x, y],['L', xm, ym], ["A", (R-barw), (R-barw), 0, +(alpha > 180), 0, xsm, ysm]];
    return path;
};
var isDraged = true;

function circle_slider(max, min, ui, id, step){
    
    if(isDraged || step){
        
        path = get_gauge(ui.value-min, max-min, svgprop.R, svgprop.offsetx, svgprop.offsety);
        svgobj['circle_slider_'+id].bg.attr({
            path:path
        });
        var angle = Raphael.angle(path[1][6], path[2][2], path[1][6], path[1][7], path[2][1], path[2][2]),
        nangle = (path[1][6] > path[2][1] ? -angle+90 : -angle-90 );
        svgobj['circle_slider_'+id].arrow.transform("r"+nangle);
        $('#circle_slider_'+id+' .disc-val').text(ui.value);
    }else{
        $('#animtrap_'+id).css({
            position:'relative',
            left:$('#slider_'+id).slider("value") + 'px'
        }).animate({
            left:ui.value
            }, {
            queue:false,
            step: function(z,a){
                circle_slider(max,min,{value:Math.round(z)},id,1);
            }
        });
    }
}

function create_slider(min, max, step, value, id){
    circle_slider(max, min, {
        value:value
    }, id)
    $('#slider_'+id).slider({
        min: min ,
        max: max , 
        value: value, 
        step:step, 
        range:"min", 
        animate: true,
        start:  function(event, ui) {
            isDraged = $(event.originalEvent.target).hasClass("ui-slider-handle");
        },
        stop: function(event, ui) {
            if($('#custom_field_'+id).val() != ui.value)
                $('#custom_field_'+id).val(ui.value).trigger('change');
            else
                circle_slider(max,min,ui,id,0);
        },
        slide: function( event, ui ) {
            circle_slider(max,min,ui,id,0);
        },
        
    });    
}
$(document).bind('fieldLogicLoaded', function(event, fl){
    var old = $.extend({}, $.fieldLogic);
    $.fieldLogic.getContainer = function(cond){
        var ct = old.getContainer(cond);
            if(ct.parent().is('.item'))
                ct = ct.parent();
        return ct;
    };
    $.fieldLogic.setValue = function(cond){
        var target = $(this),
            value = cond.value,
            tval = parseFloat(target.val()),
            slider = $();
            
        if(target.nextAll('.slider-background').eq(0).length)
            slider = target.nextAll('.slider-background').eq(0);
        else if(target.nextAll('.slider').eq(0).children().length)
            slider = target.nextAll('.slider').eq(0).children();

        if (!isNaN(tval) && tval < parseFloat(value) && slider.length) {
            var val = parseFloat(slider.slider('value'));
            if (!isNaN(val) && val != value) {
                //var sl = slider.slider();
                slider.slider('value', value);
                slider.slider('option', 'slide').call(slider,null,{handle: slider.find('.ui-slider-handle'), value: value});
                //slider.prev().children().html('x '+ value);
            }
        }
        old.setValue.call($(this).filter('input, select, textarea'), cond);
        return true
    };
});