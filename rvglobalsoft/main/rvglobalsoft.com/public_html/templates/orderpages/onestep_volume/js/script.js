var _oSettings = {
    rotation: 140,
    volR: 107,
    pointR: 147,
    portion: 260,
    xOff: 0,
    yOff: 0,
    labels: [],
    pins: [],
    active: 0
},
_oSmall = {slider:[]};

function _mainSlider() {
    var points = $('.plan_'),
            poincontainer = $('.m-slider-fix'),
            pins = poincontainer.children('.plan-point'),
            max = points.length;

    _oSettings.xOff = poincontainer.width() / 2;
    _oSettings.yOff = poincontainer.height() / 2;

    var pin = $('<div class="plan-point"></div>').css({position: 'absolute'});

    points.each(function(i) {
        _setLabel(i, max, $(this));
    }).each(function(i) {
        if (pins.eq(i).length) {
            var p = pins.eq(i);
        } else {
            var p = pin.clone().appendTo(poincontainer)
        }
        p.css(_oSettings.pins[i]);
        $(this).css(_oSettings.labels[i]);
    });
}

function _smallSlider(){
    $('.small-slider-box').each(function(){
        var that = $(this),
        conf = _oSmall.slider[that.prevAll('.small-slider-box').length];
        
        $('.small-slider', that).slider({min: conf.min ,max: conf.max , value: conf.value, step: conf.step, 
            range:"min", animate: true,
            change: function(event, ui) {
                $(this).next('input').val(ui.value).change();
                //simulateCart();
            },
            slide: function( event, ui ) {
                _smallSliderMove(ui, this, conf);
                $(this).prev('p').text(ui.value);
            },
            stop: function(event, ui) {
                //_smallSliderMove(ui, this, conf);
                $(this).prev('p').text(ui.value);
            }
        });
        _smallSliderMove(conf, $('.small-slider', that), conf);
    });
}

function _smallSliderMove(ui, slider, conf){
    var that = $(slider), 
        handle = $('.small-slider-handle', slider),
        W = that.width(),
        H = that.height(),
        R = (W/2) * 0.7;
    handle.animate({
        'text-indent': ui.value
    }, {
        queue: false,
        step: function() {
            var that = $(this),
                value = parseInt(that.css('text-indent')),
                alpha = (_oSettings.portion / (conf.max - 1)) * value,
                a = (_oSettings.rotation + alpha) * (Math.PI / 180),
                x = W/2 + R * Math.cos(a) - handle.width()/2,
                y = H/2 + R * Math.sin(a) - handle.height()/2;
            var rot_rad = a - Math.PI / 2,
                s1 = rot_rad > Math.PI ? '-1' : '1';
            that.css({
                left: x,
                top: y,
                '-webkit-transform': 'rotate(' + rot_rad + 'rad)',
                '-moz-transform': 'rotate(' + rot_rad + 'rad)',
                '-ms-transform': 'rotate(' + rot_rad + 'rad)',
                '-o-transform': 'rotate(' + rot_rad + 'rad)',
                'transform': 'rotate(' + rot_rad + 'rad)',
                'box-shadow': s1+'px 0px white'
            });
        }
    }, 'fast');
}
function _setLabel(i, max, that) {
    var alpha = (_oSettings.portion / (max - 1)) * i,
            R = _oSettings.pointR,
            a = (_oSettings.rotation + alpha) * (Math.PI / 180),
            x = _oSettings.xOff + R * Math.cos(a),
            y = _oSettings.yOff + R * Math.sin(a);

    _oSettings.pins[i] = {top: y - 3.5, left: x - 3.5, a: a};

    var w = that.width(), h = that.height(),
            lw = w * 0.8, lh = h, lr = R,
            hookx = _oSettings.xOff + lr * Math.cos(a),
            hooky = _oSettings.yOff + lr * Math.sin(a),
            xPos = hookx - (lh * Math.sin(a + Math.PI)) * Math.sin(Math.PI) + (lw * Math.cos(a + Math.PI)) * Math.cos(Math.PI),
            yPos = hooky + (lw * Math.cos(a + Math.PI)) * Math.sin(Math.PI) + (lh * Math.sin(a + Math.PI)) * Math.cos(Math.PI);

    var poincontainer = $('.m-slider-fix');

    _oSettings.labels[i] = {top: yPos - (h / 2), left: xPos - (w / 2)};
}
function _pointHandle(i, changeProduct) {
    var max = $('.plan_').length,
            alpha = (_oSettings.portion / (max - 1)) * i;
    _moveHandle((_oSettings.rotation + alpha) * (Math.PI / 180));
    if(!changeProduct)
        _changeProduct();
}
function _moveHandle(radians) {
    var handle = $('.main-slider-handle'),
            xOff = handle.width() / 2,
            yOff = Math.floor(handle.height() / 2),
            max = _oSettings.pins.length,
            lowb = _oSettings.pins[0].a,
            highb = _oSettings.pins[max - 1].a,
            labels = $('.plan_'),
            pins = $('.plan-point');

    radians = lowb > radians ? lowb : (highb < radians ? highb : radians);
    for(var i = max-1; i>=0; i--){
        var part = i>0 ? _oSettings.pins[i].a - _oSettings.pins[i-1].a : _oSettings.pins[i].a,
            lim = _oSettings.pins[i].a - part*0.35;
    
        if(lim <= radians){
            _oSettings.active = i;
            break;
        }
    }
    handle.animate({
        'text-indent': radians * 1000
    }, {
        queue: false,
        step: function() {
            var that = $(this),
                    rad = parseFloat(that.css('text-indent').replace(/[^\d\.\,\-]/g, '')) / 1000,
                    x = _oSettings.xOff + _oSettings.volR * Math.cos(rad) - xOff,
                    y = _oSettings.yOff + _oSettings.volR * Math.sin(rad) - yOff;
            var rot_rad = rad - Math.PI / 2,
                    s2 = (rot_rad > 0.25*Math.PI && rot_rad <= 0.75*Math.PI) || (rot_rad > 1.25*Math.PI && rot_rad <= 1.75*Math.PI) ? '0' : (rot_rad >= 0.75*Math.PI ? '-1':'1' )  ,
                    s1 = (rot_rad > 0.75*Math.PI && rot_rad <= 1.25*Math.PI ) || rot_rad > 1.75*Math.PI || rot_rad <= 0.25*Math.PI ? '0' : (rot_rad > 0.75*Math.PI ? '-1':'1' )
            
            that.css({
                left: x,
                top: y,
                '-webkit-transform': 'rotate(' + rot_rad + 'rad)',
                '-moz-transform': 'rotate(' + rot_rad + 'rad)',
                '-ms-transform': 'rotate(' + rot_rad + 'rad)',
                '-o-transform': 'rotate(' + rot_rad + 'rad)',
                'transform': 'rotate(' + rot_rad + 'rad)',
                'box-shadow': s1+'px '+s2+'px 0px rgba(0, 0, 0, 0.5) inset'
            });
            for(var i = max-1; i>=0; i--){
                var part = i>0 ? _oSettings.pins[i].a - _oSettings.pins[i-1].a : _oSettings.pins[i].a,
                    lim = _oSettings.pins[i].a - part*0.35;
                
                if(lim > rad){
                    labels.eq(i).removeClass('active-point');
                    pins.eq(i).removeClass('active-point');
                }else{
                    labels.eq(i).addClass('active-point');
                    pins.eq(i).addClass('active-point');
                    for(var x = 0; x<i; x++){
                        pins.eq(x).removeClass('active-point');
                        labels.eq(x).removeClass('active-point');
                    }
                    break;
                }
            }
        }
    }, 'fast');
}

function _controlls(e) {
    if (typeof e.offsetX === "undefined" || typeof e.offsetY === "undefined" || !$(e.target).is('.m-slider-fix').length) {
        var targetOffset = $('.m-slider-fix').offset();
        e.offsetX = e.pageX - targetOffset.left;
        e.offsetY = e.pageY - targetOffset.top;
    }
    var mPos = {x: e.offsetX, y: e.offsetY};
    var y = mPos.y - _oSettings.yOff,
            x = mPos.x - _oSettings.xOff,
            atan = -Math.atan2(x, y) + Math.PI / 2,
            radius = x >= 0 ? 2 * Math.PI + atan : atan;
    _moveHandle(radius);
}
function _changeProduct() {
    var actv = $('.plan_ .plan-rel').eq(_oSettings.active);
    if(actv.length){
        changeProduct(actv.attr('rel'));
    }else{
        actv = $('.plan-rel[rel]').eq(0);
        _pointHandle(actv.parent().prevAll('.plan_').length, true);
        changeProduct(actv.attr('rel'));
    }
}
function changeProduct(pid) {
    if($('#product_id').val() == pid)
        return;
    $('#errors').slideUp('fast', function () {
        $(this).find('span').remove();
    });

    _oSmall.slider = [];
    $.post('?cmd=cart', {
        id: pid
    }, function (data) {
        var r = parse_response(data);
        $('#update').html(r);
        $('#update').removeClass('ajax');
        _smallSlider();
        _themeNarowSwitch(true);
        bindSimulateCart();
    });
}

function _themeNarowSwitch(instant){
    if(typeof theme == 'undefined')
        return false;
    if(theme.uiState.sidemenu){
        $('#cont > .orderpage').addClass('sidepad-on');
        if(instant === true){
            $('#update .promo-column').hide();
            $('.main-slider').css({marginLeft:'150px'});
        }else{
            $('#update .promo-column').fadeOut('fast');
            $('.main-slider').animate({marginLeft:'150px'},{queue:false});  
        }
    }else{
        $('#cont > .orderpage').removeClass('sidepad-on');
        $('#update .promo-column').fadeIn('fast');
        $('.main-slider').animate({marginLeft:'0px'},{queue:false, duration: 'fast', easing :'swing'});
    }
        
}

$('section').removeClass('overlay-nav');
$(window).load(function() {
    _mainSlider();
    var selected = $('.plan-rel').filter('[rel='+$('#product_id').val()+']').parent().prevAll('.plan_').length;
    _oSettings.volR = $('.m-slider-fix').width() * 0.4;
    _pointHandle(selected);
});

$(function() {
    _mainSlider();
    _smallSlider();
    var $container = $('.m-slider-fix');

    var selected = $('.plan-rel').filter('[rel='+$('#product_id').val()+']').parent().prevAll('.plan_').length;

    _oSettings.volR = $('.m-slider-fix').width() * 0.4;
    _pointHandle(selected);
    
    _themeNarowSwitch();
    $('.topbar button').click(_themeNarowSwitch);

    bindSimulateCart();
    
    if($('#checkbox-tos').length){
        $('#checkbox-tos').click(function(){
            if($(this).is(':checked'))
                $('.checkout-button').removeClass('disabled').removeAttr('disabled');
            else
                $('.checkout-button').addClass('disabled').attr('disabled', 'disabled');
        })
    }else{
        $('.checkout-button').removeClass('disabled').removeAttr('disabled');
    }
    
    $container.mousedown(function(e) {
        e.originalEvent.preventDefault();
        _controlls(e);
        $(document).bind('mousemove.voldrag',_controlls).bind('mouseup.voldrag',function(e){
             $(document).unbind('.voldrag').find('body').removeClass('grabbing');
             //_controlls(e);
             _changeProduct();
        }).find('body').addClass('grabbing');
    })
});

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
    $.post('?cmd=cart&addcoupon=true',$('#promoform').serializeArray(), _updateCart);
    return false;
}

function removeCoupon() {	
    $.post('?cmd=cart',{
        removecoupon:'true'
    },_updateCart);
    return false;
}

function clientForm(login){
    if($(login).val() == '1'){
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
function tabbme(el) {
    $(el).parent().find('button').removeClass('active');
    $('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
    $('#options div.'+$(el).attr('rel')).show().find('input[type=radio]').attr('checked','checked');
    $(el).addClass('active');
}

function _updateCart(data){
    data = parse_response(data);
    $('#orderSummary').html($(data).filter('#orderSummary').html());
    $('.promo-column').html($(data).find('.promo-column').html());
    bindSimulateCart();
}

function simulateCart(forms, domaincheck) {
    /*
        Sends configuration data on each change made in forms and updates order prices/summary tab
         */
    var urx = '?cmd=cart',
    form = $('input, select, textarea','#cartforms, .billing-box, .small-slider-top-layer').filter(function(){
        if($(this).parents('#domoptions11, .toggle-slider.domains').length) return false;
        return true
    });
    if(domaincheck) urx += '&_domainupdate=1&';
    $('.ajax-overlay:last').show();
    $('.summary-bg').addClass('half-opacity');
    $.post(urx, form.serializeArray(), _updateCart);
}
function bindSimulateCart(){
    $('[name=ostemplate], [name=domain], [name=cycle]','#cartforms, .billing-box').filter(function(){
        return !$(this).parents('#domoptions11').length
    }).bind('change',function(){
        var attr = $(this).attr('onchange') == undefined && $(this).attr('onclick') == undefined;
        if(attr) simulateCart();
    });
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

$(document).bind('fieldLogicLoaded', function(event, fl){
    $.fieldLogic.getContainer = function(cond){
        return $(cond.target).parent().parent() ;
    };
});