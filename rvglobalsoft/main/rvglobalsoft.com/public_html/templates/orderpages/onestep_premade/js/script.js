$(document).ready(function(){
    
    if($('#slides .definied-plan').length>3) {
        //divide slides to groups of 4
        var i=0;
        for(i=0;i<$('#slides .definied-plan').length/3;i++) {
            $('#slides .definied-plan').slice(i*3,(i*3)+3).wrapAll('<div class="slide"></div>').parent().append('<div class="clear"></div>');
        }
        $('#slides').slides({
            generatePagination: true,
            generateNextPrev: false,
            container:'definied-plans-list',
            paginationClass:'slides_pagination',
            start: 1
        });
    } 
    
    $('.slides_pagination').width($('.slides_pagination').children().length * 14);
    $('img').one('load', function(){
        $('.definied-plan img').each(function() {
            var width = $(this).width();
            var height = $(this).height();
            var height = Math.floor(height/2)*-1;
		
            $(this).css({
                'width': width,
                'top':'50%',
                'margin-top': height
            });
        });
    });
   
    $('.definied-plan').hover(function(){
        $(this).children('.definied-plan-hover').css('display', 'block');
    }, function(){
        $('.definied-plan-hover').css('display', 'none');
    });	
	
   $('.cart-switch span').click(function(){
        if($(this).hasClass('active'))
            return false;
        var act = $('.cart-switch span.active'),
        ths = $(this);
        $(ths).addClass('pre-active');
        $('.cart-switch div').css(act.position())
        .width(act.width())
        .height(act.removeClass('active').height())
        .show()
        .animate(ths.position(),'fast','swing',function(){
            ths.addClass('active');
            ths.removeClass('pre-active');
            $('.cart-switch div').hide();
            return false;
        });
    });
    
    $('.definied-plan-hover').click(function(){
        actPremade(this);
        var rel = parseInt($(this).attr('rel'));
        rel = isNaN(rel) || rel < 1? 1 : rel;
        setSliderTo(rel);
    });

    $('.select-plan-point-1, .select-plan-point-2, .select-plan-point-3, .select-plan-point-4').click(function(){
        $('.select-plan-line').children().children().remove();
        $(this).prepend('<span></span>');
    });
});
function actPremade(that){
    $('.definied-plan').css('border', 'solid 2px #fff');
    if($(that).length){
       $('.about-plan-details').css('display', 'none');
        var plan = $(that).parent().attr('id');
        $(that).parent().css('border', 'solid 2px #8fbd3d');
        $('#about-'+plan).css('display', 'block'); 
    }
}
function rebind_after_ajax(){
    $('.addToServer, .reduce').mousedown(function(event){
        var el = $(this).siblings('input:last');
        start_changer(parseInt($(this).attr('step')), 1, 500, el, 600);
        return false;
    });
    $('.addToServer, .reduce').mouseup(function(event){
        var el = $(this).siblings('input:last');
        stop_changer(el);
        return false;
    });
    $('.addToServer, .reduce').click(function(){
        return false;
    });
     $('.payment-period-select span').click(function(){
         $(this).parent().toggleClass('opened');
        $('.payment-period-list').toggle();
    });
    $('.payment-period-list p').click(function(){
        $('#cycle2').val($(this).attr('rel'));
        simulateCart();
        return false;
    });
    if($('#checkout:visible').length){
        $('#configuration').hide();
    }
}
var paper = null;
function start_changer(step, min, max, el, inteval){
    clearTimeout($(el).data('changer2'));
    $(el).data('changer2', false);
    var value = step + parseInt($(el).siblings('.s1').children('.slider_value').text()), stop = false;
    if(value > max){
        stop = true;
        value = max;
    }
    if(value < min){
        stop = true;
        value = min;
    }
    
    $(el).siblings('.s1').children('.slider_value').text(value);
    if(stop){
        $(el).val(value).change();
        $(el).data('changer',null);
        return false;
    }
    var timeout = setTimeout(function(){
        inteval = inteval * 0.7 < 20 ? (step >0? step++:step--) : inteval * 0.8;
        start_changer(step, min, max, el, inteval);
    }, inteval);
    $(el).data('changer',timeout);
}

function stop_changer(el){
    $(el).val($(el).siblings('.s1').children('.slider_value').text())
    clearTimeout($(el).data('changer'));
    $(el).data('changer', false);
    var timeout = setTimeout(function(){
        $(el).change();
    }, 800);
    $(el).data('changer2', timeout);
    
}

function pop_slider(){
    var textel = $('.slider-text-box'),
    width = 830,//textel.width(),
    divider = textel.children().length,
    perelw =  Math.floor(width/divider);
    textel.children().width(perelw);
    
    var septel = $('.slider-separators-box');
    width = septel.width();
    divider = septel.children().length;
    perelw =  Math.round((width/divider)/2);
    septel.children().width((width/divider));
    septel.children().each(function(){
        $(this).children().css({
            marginLeft:'10%', 
            marginRight:'10%'
        });
        var i=0;
        while($(this).height() > 14 && i++ < 100){
            var mrg = parseFloat($(this).children().eq(0).css('margin-right'));
            $(this).children().css({
                marginLeft:(mrg-0.5)+'px', 
                marginRight:(mrg-0.5)+'px'
            });
        }
    });

    $('.slider-text-box span').click(function(){
        setSliderTo($(this).index() + 1);
        return false;
    });
    paper = Raphael($('.slider-top')[0]);
    $(paper.canvas).css({
        position:'absolute', 
        left:0, 
        top:0
    }).addClass('svgcanvas');

    paper.path([["M", 0, 13.5], ["L", 38.5, 0], ["L", 843.78, 0], ["L", 882, 13]]).attr({
        'stroke-width':0, 
        fill:'#ffffff'
    });
    paper.path([["M", 0, 13], ["L", 38, 0], ["L", 62, 0], ["L", 26, 13]]).attr({
        'stroke-width':0, 
        fill:'#0B79CC'
    });
    divider = $('.slider-separators-box span').length;
    var divider2 = divider*10;
    $('#slider').slider({
        range: "min",
        value: 0,
        min: 1,
        max: divider2,
        step: 1,
        start: function(event, ui){
            slider($('#slider').slider('value'),(divider2))
        },
        slide: function(event, ui){
            slider($('#slider').slider('value'),(divider2))
        },
        stop: function(event, ui){
            slider($('#slider').slider('value'),(divider2))
        },
        change:function(){
            var value = $('#slider').slider('value'),
            step = divider2/(divider/5);
            var index = Math.floor((value-step/2) / step);
            index = index < 0 ? 0 : index;
            changeProduct($('.product_id').eq(index).val());
            actPremade($('.definied-plan-hover[rel='+(index+1)+']'));
            slider(value,(divider2));
            
        }
    });
    var selected = $('.slider-text-box .selected').index();
    setSliderTo(selected+1);
}
function setSliderTo(x){
    if(x == undefined || x < 1)
        x = 1;
    var divider = $('.slider-text-box span').length;
    var divider2 = $('.slider-separators-box span').length*10;
    var value = (divider2/divider) * x - (divider2/divider) /2;
    $('#slider').slider('value', value );
//slider(value, divider2);
}
function slider(i,x){
    draw_path(i,x, '#0B79CC');
    $('.slider-bg-blue-scalable').css('width', 825 * (i/x));
}
var svgobj = {};
function draw_path(v,m,fill){
    var h = 150, w = 825, ww = w*(v/m), ay=13, ax=24, by=0, bx=60,
    x = Math.sqrt( Math.pow(w/2 - ww,2) + Math.pow(h,2)),
    xx = (x * (by-ay)) / h,
    c = Math.sqrt(Math.pow( xx,2) - Math.pow(by-ay,2)),
    path = [['M',ax,ay],['L',bx,by],['L',ax + ww + (ww > w/2 ? -c : c),by],['L',ax+ww,ay]];
    if(svgobj[fill] == undefined){
        svgobj[fill] = paper.path(path).attr({
            'stroke-width':0, 
            fill:fill
        });
    }else{
        svgobj[fill].attr({
            path:path
        });
    }
}
function mainsubmit(formel) {
    return true;
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
    $('.payment').addClass('ajax');
    var cart = [];

    cart[0] = $('#cart3').serialize();
    cart[1] = $('#gatewaylist').serialize();
    cart[2] = $('.cartD').serialize();
    
    query = '';
    for(var i = 0; i<3; i++){
        if(cart[i].length){
            if(query.length > 0){
                query += '&';
            }
            query += cart[i];
        }
    }
    var urx = '?cmd=cart';
    if(domaincheck) urx += '_domainupdate=1';
    $.post(urx,query, function(data){
        data = parse_response(data);
        $('#update').html(data);
    })
    if(forms == 'gatewaylist'){
        $.post('?cmd=cart&action=getgatewayhtml&gateway_id='+$('#gatewaylist').children('select').val(), {}, function(data){
            data = parse_response(data);
            $('#gatewayform').html(data);
        })
    }
    
}
var firstset = true;
function changeProduct(pid) {
    
    if(!firstset)
    $('#errors').slideUp('fast', function () {
        $(this).find('span').remove();
    });
    firstset = false;
    $('#update').addClass('ajax');
    $.post('?cmd=cart', {
        id: pid
    }, function (data) {
        var r = parse_response(data);
        $('#update').html(r);
        $('#update').removeClass('ajax');
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
function reform_ccform(html){
    $('#gatewayform').find('.wbox').find('.wbox_header').unwrap().find('strong').unwrap().wrapInner('<h2 class="openSansLightItalic">').find('h2').unwrap().append('<span></span>');
}
function pop_ccform(valu){
    $('#gateway_form').val(valu);
    $.post('?cmd=cart&action=getgatewayhtml&gateway_id='+valu, '', function(data){
        var data = parse_response(data);
        if(data.length){
            $('#gatewayform').html(data);
            reform_ccform();
            $('#gatewayform').slideDown();
        }else $('#gatewayform').slideUp('fast', function(){$(this).html('')});
    });
}

