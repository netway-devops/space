var firsttimeblock = true;
var cloudslider = {};
var svgprop = {
    R : 175,
    offsetx : 32,
    offsety : 157,
    barwidth: 16,
    portion: 194,
    rotation: 118
};

$(function(){   
    var paper = Raphael($('.slider-bg')[0]);
    $(paper.canvas).css({
        position:'absolute'
    }).addClass('svgcanvas');
    cloudslider = {
        paper: paper,
        bg:false, 
        points:[]
    };
    var current = packages.indexOf($('#pidi').val());
    current = current < 0 ? 1 : current+1;
    var path = _setSlider(packages.length-current, packages.length-1);
    $('.slider-handle').css({
        left: path[2][1]+ ( path[1][6]-path[2][1] )/2, 
        top:  path[2][2]+ ( path[1][7]-path[2][2] )/2
    });
    
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

    $('.slider-handle').draggable({
        containment: "parent",    
        drag:function(event, ui) {
            var tot = (packages.length-1)*50;
            var angle = Math.atan2( ui.position.left - (svgprop.offsetx+svgprop.R/2), ui.position.top - svgprop.offsety );
            if(angle > -0.75 && angle < 2.75){
                var val = Math.ceil( tot-(((angle + 0.75) / 3.5)*tot) );
                var path = _setSlider(val, tot, Math.ceil(val/50));
                val = Math.ceil(val/50);
            }else if( angle > 2.75 || angle < -2.65){
                var val = 0;
                var path = _setSlider(0,1);
            }else{
                var val = packages.length-1;
                var path = _setSlider(val,val);
            }
            var css = {
                left: path[2][1]+ ( path[1][6]-path[2][1] )/2, 
                top:  path[2][2]+ ( path[1][7]-path[2][2] )/2
            };

            ui.position.top=css.top;
            ui.position.left=css.left;
            cloudslider.product = packages[packages.length-val-1];
        
        },
        stop:function() {
            changeProduct(cloudslider.product);
        }
    });
    slidersToggles();
    $(document).delegate('#updater2 input[type=submit]', 'click', function(){
        submitDomains();
        return false;
    });
//$('.slider-shadow').click()
});

$(window).load(function(){
    toggleAlign();
});

function _setSlider(val, total, point){
    var pv = point || val;
    
    var path = get_gauge(val, total || packages.length-1, svgprop.R, svgprop.offsetx, svgprop.offsety);
    if(cloudslider.bg == false){
        cloudslider.bg = cloudslider.paper.path(path).attr({
            'fill':'#1061B2', 
            'stroke-width':0
        });
        for(var i =2; i<=packages.length; i++){
            var path2 = get_gauge(packages.length-i, packages.length-1, svgprop.R, svgprop.offsetx, svgprop.offsety);
            cloudslider.points[i] = cloudslider.paper.circle(path2[2][1]+ ( path2[1][6]-path2[2][1] )/2 , path2[2][2]+ ( path2[1][7]-path2[2][2] )/2, 2.5);
            cloudslider.points[i].attr({
                'fill':'#4a87c4', 
                'stroke-width':0
            }).glow({
                width:3, 
                offsety:1, 
                opacity:0.1
            });
        }
    }else{
        cloudslider.bg.attr({
            path: path
        });  
    }
    
    for(var i = 0; i <= packages.length; i++){
        if(cloudslider.points[packages.length-i] == undefined)
            continue;
        if(i >= pv){
            cloudslider.points[packages.length-i].hide();
        }else{
            cloudslider.points[packages.length-i].show();
        }
    }
    return path;
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

function afterAjax(){
    slidersToggles();
    toggleAlign();
}

function bindSimulateCart(){
    $('[name^=addon], [name^=subproduct], [name=ostemplate], [name=domain], [name=cycle]','#cartforms, .billing-bg').filter(function(){
        return !$(this).parents('#domoptions11').length
    }).bind('change',function(){
        var attr = $(this).attr('onchange') == undefined && $(this).attr('onclick') == undefined;
        if(attr) simulateCart();
    });
}

function toggleAlign(){
    var maxw = 0,
    el = 0;
    $('.server-option-middle').each(function(i){
        maxw+=23;
        if($(this).width()+1 >= maxw){
            maxw=$(this).width()+1;
            el = i;
        }
    }).each(function(i){
        var offset = 23*(el-i) ;
        $(this).width( maxw-offset);
    })
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

function tabbme(el) {
    $(el).parent().find('button').removeClass('active');
    $('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
    $('#options div.'+$(el).attr('rel')).show().find('input[type=radio]').attr('checked','checked');
    $(el).addClass('active');
}

function simulateCart(forms, domaincheck) {
    /*
        Sends configuration data on each change made in forms and updates order prices/summary tab
         */
    var urx = '?cmd=cart',
    form = $('input, select, textarea','#cartforms, .billing-bg').filter(function(){
        if($(this).parents('#domoptions11, .toggle-slider.domains').length) return false;
        return true
    });
    if(domaincheck) urx += '&_domainupdate=1&';
    $('.ajax-overlay:last').show();
    $('.summary-bg').addClass('half-opacity');
    ajax_update(urx, form.serializeArray(), '#update');
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
    if(target == '#updater2'){
        var ajax = $('<span class="ajax-overlay overlay2"></span>').appendTo($(target).html('<br><br>')).show();
    }
    ajax_update(url,param,target);

    return false;
}

function reform_ccform(html){
    $('<h4>'+$('#gatewayform').find('.wbox_header strong').text().replace(/:/, '')+'</h4>').replaceAll($('#gatewayform .wbox_header')).parent().addClass('page-section');
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

function submitDomains() {
    /*
        Handle second step of domain
         */
    $('.ajax-overlay:last').show();
    ajax_update('index.php?cmd=cart&'+$('input, select, textarea','#updater2').serialize(),{
        layer:'ajax'
    },'#update');
    return false;
}

function mainsubmit(formel) {
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
    $('.client-toggle .active-toggle').removeClass('active-toggle').siblings().addClass('active-toggle');
}


function slidersToggles(){
    $('.setup-arrow-up, .setup-arrow-down').each(function(i){
        var a = Math.ceil(i/2) - (i%2),
            b = (i%2) == 1 ? -1 : 1;
        var el = $('.slider-horizontal input').eq(a);
        $(this).mousedown(function(event){
            start_changer(sliders[a].step*b, sliders[a].min, sliders[a].max, el, 600);
            return false;
        }).mouseup(function(event){
            stop_changer(el);
            return false;
        }).click(function(){
            return false;
        });
    });
}

function start_changer(step, min, max, el, inteval){
    clearTimeout($(el).data('changer2'));
    $(el).data('changer2', false);
    var text = $(el).siblings('.server-option-box').find('p span');
    var value = step + parseInt(text.text()), stop = false;
    if(value > max){
        stop = true;
        value = max;
    }
    if(value < min){
        stop = true;
        value = min;
    }
    
    text.text(value);
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
    $(el).val($(el).siblings('.server-option-box').find('p span').text())
    clearTimeout($(el).data('changer'));
    $(el).data('changer', false);
    var timeout = setTimeout(function(){
        $(el).change();
    }, 800);
    $(el).data('changer2', timeout);
    
}
function applyCoupon() {
    var f = $('#couponcde').val();
    ajax_update('?cmd=cart&addcoupon=true&promocode='+f,{},'#update');
    return false;
}

function removeCoupon() {
    ajax_update('?cmd=cart&removecoupon=true',{},'#update');
    return false;
}

$(document).bind('fieldLogicLoaded', function(event, fl){
    $.fieldLogic.getContainer = function(cond){
        return $(cond.target).parents('tr, .slider-horizontal').eq(0);
    };
});