
(function($) {
    $.fn.extend({
        qtyControl : function(options) {
            var defaults = {
                upHandle: false,
                downHandle: false,
                step: 1,
                max: null,
                min: null,
                onstep: null,
                change:null
            };
            options = $.extend(defaults, options);
            
            var newValue = function(element, m) {
                var curr = parseFloat(element.val()),
                add = parseFloat(options.step)*m,
                max = options.max === null ? 0 : parseFloat(options.max),
                min = options.min === null ? 0 : parseFloat(options.min);
                
                if ( (options.max === null || curr+add <= max) && (options.min === null || curr+add >= min) ) {
                    element.val(curr+add);
                    if(typeof options.onstep == 'function')
                        options.onstep(element, curr+add);
                }else if(options.max === null || curr+add > max){
                    element.val(max);
                }else{
                    element.val(min);
                }
            };
            
            var bindHandle = function(that, type) {
                var element = that.find(type ? options.upHandle : options.downHandle),
                space = '.qtyControl'+(type ? 'up' : 'down');

                element.bind("mousedown"+space, function() {
                    var interval = null,
                    multint = 0,
                    mult = 1;
                    
                    newValue(that,(type ? 1 : -1));
                    var timeout = setTimeout(function() {
                        interval = setInterval(function() {
                            newValue(that,(type ? 1*mult : -1*mult));
                            mult = Math.pow(10, Math.floor(multint/100))
                            multint++;
                        }, 80);

                        $(document).bind("mouseup"+space, function() {
                            clearInterval(interval);
                            $(document).unbind("mouseup"+space).change();
                        });
                    }, 400);
                
                    element.bind("mouseup"+space+" mouseout"+space, function() {
                        clearTimeout(timeout);
                        clearInterval(interval);
                        element.unbind("mouseup"+space+" mouseout"+space);
                        that.change();
                        if(typeof options.change == 'function')
                            options.change(that, that.val());
                    });
                });
            };
            
            return this.each(function(){
                var that = $(this);
                bindHandle(that,false);
                bindHandle(that,true);
            });
        }
    });
})(jQuery);

$(function(){
    popSlider();
    bindForms($('.radio, .checkbox'));
    wrapSingupForms();
    bindSimulateCart();
    flyingSidemenu();
    $('#continue_step').attr('href',window.location.href.replace(/#.*$/,'')+'#step1');
    $('.billing-slider div div').click(function(){
        $('.active-billing').removeClass('active-billing');
        $(this).addClass('active-billing');
        $('#select_cycle').val($(this).attr('rel')).change();
    })
    $(document).delegate('#updater2 input[type=submit]', 'click', function(){
        submitDomains();
        return false;
    });
    $('.slider-box input').each(function(){
        var that = $(this);
        that.qtyControl({
            upHandle: '+ div + div + div .button-up', 
            downHandle: '+ div + div + div .button-down', 
            max: that.attr('max'), 
            min: that.attr('min'), 
            step: that.attr('step'),
            onstep: function(elem, val){
                elem.next('.slider-bg').children().slider('value', val);
            },
            change: function(elem, val){
                elem.next('.slider-bg').children().slider('value', val);
            }
        });
    });
    $(window).scroll(flyingSidemenu);
})

$(window).load(function(){
    $('.slider-box > .clearfix').each(function(){
        var inswid = 0
        $(this).children().each(function(){inswid += $(this).outerWidth(true);}).end().width(inswid);
    });
});

function flyingSidemenu(instant) { 
    if(!$('#summary:visible').length){
        return;
    }
    var top = $(window).scrollTop(),
    bottom = top + $(window).height(),
    start = $('#summary').offset().top,
    height = $('#floating').outerHeight(),
    left = $('.left-side:visible').outerHeight(true)-100;

    var t = bottom - (start + height);
    if(bottom < (start + height) || left < height)
        t=0;
    else if(height+t > left)
        t = left - height;
    if(!instant){
        $('#floating').animate({
            marginTop:t+"px"
        },{
            queue: false, 
            duration: 300
        });
    }else{
        $('#floating').css({
            marginTop:t+"px"
        });
    }
    
}

$(window).on('hashchange',function() {
    set_cart_step(location.hash);
});

function set_cart_step(hash, instant){
    var to = 0;
    if(hash.substr(0,5) == '#step'){
        to = parseInt(hash.substr(5));
    }
    var steps = $('.step_'),
    current = steps.filter(':visible');
    
    if(to < 0 || !steps.eq(to).length)
        to = 0;
    if(instant == undefined || !instant){
        if(to == 0)
            $('#summary').fadeOut();
        
        current.fadeOut('slow', function(){
            if(to > 0)
                $('#summary').fadeIn();
            steps.eq(to).fadeIn();
            flyingSidemenu();
            $('.select-list-fix select:visible').trigger('update');
        });
    }else{
        if(to > 0)
            $('#summary').show();
        else
            $('#summary').hide();
        current.hide();
        steps.eq(to).show();
        flyingSidemenu();
        $('.select-list-fix select:visible').trigger('update');
    }

    if(steps.length-1 == to){
        $('#continue_text').hide().next().show();
    }else{
        $('#continue_text').show().next().hide();
    }
    var diag = $('.diagram');
    $('.diagram div').removeClass('active').removeClass('last').filter(function(){
        return $(this).index() < (to+1)*2
    }).addClass('active').last().addClass('last');
    $('.diagram-label span').removeClass('active').removeClass('last').filter(function(){
        return $(this).index() < (to+1)
    }).addClass('active').last().addClass('last');
}
function continue_step(to){
    
    var steps = $('.step_'),
    current = steps.filter(':visible'),
    btn = false;

    if(to == undefined){
        to = current.next('.step_').index()-1;
        btn=true;
    }

    if((to < 0 || !steps.eq(to).length ) && !btn)
        return false;
    else if(btn && to < 0){
        //console.log(current.index(),window.location.href.replace(/#.*$/,'')+'#step'+(current.index()-1));
        $('#orderform').attr('action',window.location.href.replace(/#.*$/,'')+'#step'+(current.index()-1)).submit()
        return false;
    }
    
    if(!btn){
        //set_cart_step('#step'+to);
        window.location = window.location.href.replace(/#.*$/,'')+'#step'+to;
    }
        
    $('#continue_step').attr('href',window.location.href.replace(/#.*$/,'')+'#step'+to);
}

function popSlider(){
    $('.slider-box').each(function(i){
        var that = $(this),
        inp = that.children('input'),
        slider = that.find('.slider-bg div'),
        showbox = that.find('.slider-value span'),
        min = parseInt(inp.attr('min')),
        max = parseInt(inp.attr('max')),
        value = parseInt(inp.val()),
        step  = parseInt(inp.attr('step')),
        id = inp.attr('rel');
        
        slider.slider({
            min: min ,
            max: max , 
            value: value, 
            step:step, 
            range:"min", 
            animate: true, 
            orientation: "vertical",
            change: function(event, ui) {
                showbox.text(ui.value)
            },
            slide: function( event, ui ) {
                showbox.text(ui.value)
            },
            stop: function(event, ui) { 
                showbox.text(ui.value);
                inp.val(ui.value).trigger('change');
            }
        });
        slider.find('.ui-slider-range').wrap('<div class="ui-slider-range-mask"></div>');
    });
}

function bindForms(elements){
    elements.each(function(){
        var that = $(this),
        check = that.find('input[type=radio], input[type=checkbox]').eq(0).unbind('.xform').bind('change.xform',function(event){
            var check = $(this);
            if(check.is('[type=radio]')){
                if(check.is(':checked')){
                    $('.radio input[name="'+check.attr('name')+'"]').parents('.radio').not(that).removeClass('checked');
                    that.addClass('checked');
                }
            }else
                check.is(':checked') ? that.addClass('checked') : that.removeClass('checked');
            //console.log(event);
            //simulateCart();
        }).trigger('change.xform');
        that.bind('click.xform',function(e,b){
            if($(e.target).is(check) || $(e.target).attr('for') != undefined)
                return;
            //check.is(':checked') ? check.prop('checked',false).removeAttr('checked') : check.prop('checked',true).attr('checked','checked');
            check.trigger('click');
            //simulateCart();
        });
    });
    
}

function wrapSingupForms(){
    $('.new-client select').wrap('<div class="select-list-fix"></div>');
    $('.select-list-fix select').customSelect({
        customClass:'black-select'
    });
}

function wrapCustomForms(){
    $('.config-field select').wrap('<div class="select-list-fix"></div>');
    $('.select-list-fix select').customSelect({
        customClass:'black-select'
    });
    $('.config-field input[type=checkbox]').wrap('<div class="checkbox" style="clear:left;"></div>');
    $('.config-field input[type=radio]').wrap('<div class="radio" style="clear:left;"></div>');
}
function wrapDomainCustomForms(){
    $('.config-fieldtld select').wrap('<div class="select-list-fix"></div>');
    $('.select-list-fix select').customSelect({
        customClass:'black-select'
    });
    $('.config-fieldtld input[type=checkbox]').wrap('<div class="checkbox" style="clear:left;"></div>');
    $('.config-fieldtld input[type=radio]').wrap('<div class="radio" style="clear:left;"></div>');
}

function tabbme(el) {
    if(!$(el).is(':checked'))
        return;

    $('div.slidme').hide();
    $('#'+$(el).val()).show();
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
    handle = domain_handle;
    switch(action){
        case 'illtransfer':
            param.sld=$('#sld_transfer').val();
            param.tld=$('#tld_transfer').val();
            param.transfer='true';
            break;
        case 'illupdate':
            url='?cmd=cart&domain=illupdate';
            param.sld_update=$('#sld_update').val();
            param.tld_update=$('#tld_update').val();
            handle = update_handle;
            break;
        case 'illsub':
            url='?cmd=cart&domain=illsub';
            param.sld_subdomain=$('#sld_subdomain').val();
            handle = update_handle;
            break;
       case 'illregister':
       default:
            url+='&'+$('.tld_register').serialize();
            param.sld=$('#sld_register').val();
            break;
    }
    $('#updater2').show().addLoader();
    $.post(url,param,handle);
    //ajax_update(url,param,target);

    return false;
}

function domain_handle(data){
    var data = parse_response(data);

    $('#updater2').html(data).find('th').each(function(){
        $(this).html('<h5>'+$(this).text()+'</h5>');
    });
    
    bindForms($('#updater2').find('.td1'));
    $('#updater2').find('select').wrap('<div class="select-list-fix"></div>').customSelect({
        customClass:'black-select'
    });
}

function update_handle(data){
    data = cart_update(data);
    $('#updater2').html('');
    $('#domoptions11').fadeOut('fast', function(){
        $('#domoptions22').fadeIn();
    });
    $('#domoptions22').html( $(data).find('#domoptions22').html() );
}

function submitDomains() {
    /*
    Handle second step of domain
    */
    $('.ajax-overlay:last').show();
    $.post('index.php?cmd=cart&'+$('input, select, textarea','#updater2').serialize(),{
        layer:'ajax'
    },function(data){
        $('#updater2').html('');
        $('#domoptions11').fadeOut('fast', function(){
            $('#domoptions22').fadeIn()
        });
        data = cart_update(data);
        $('#domoptions22').html( $(data).find('#domoptions22').html() )
        wrapDomainCustomForms();
    });
    return false;
}

function clientForm(login){
    if($(login).val()!='1'){
        $('#clientform').html('').removeClass('new-client').addClass('existing-client').addLoader();
        ajax_update('?cmd=login',{
            layer:'ajax'
        },'#clientform'); 
    }else{
        $('#clientform').html('').addClass('new-client').removeClass('existing-client').addLoader();
        $.post('?cmd=signup',{
            layer:'ajax'
        },function(data){
            var content = $(parse_response(data));
            content.find('.chzn-select').removeClass('chzn-select');
            $('#clientform').html(content);
            wrapSingupForms();
        }); 
        
    }
}

function reform_ccform(html){
    var form = $($('#gatewayform').html());
    if(!form.find('.wbox_header').length)
        return;
    $('#gatewayform').html('<h3>'+form.find('.wbox_header strong').text().replace(/:/, '')+'</h3>')
    .append('<div class="underline-title"><div class="underline-bolder"></div></div>')
    .append('<div class="gateway-forms">'+form.find('.wbox_content').html()+'</div>')
    .append(form.filter('style'));
    $('#gatewayform').find('select').wrap('<div class="select-list-fix"></div>').customSelect({
        customClass:'black-select'
    });
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

function simulateCart(id,domaincheck) {
    /*
        Sends configuration data on each change made in forms and updates order prices/summary tab
         */
    
    setTimeout(function(){
        var urx = '?cmd=cart',
        form = $('input, select, textarea','.step_0,.step_2,.cartD');
        if(domaincheck) urx += '&_domainupdate=1&';
        $('.ajax-loader:last').css('visibility','visible');
        $('.summary-bg').addClass('half-opacity');
        $.post(urx, form.serializeArray(), cart_update);
    }, 100)
    
//ajax_update(urx, form.serializeArray(), '#update');
}
function bindSimulateCart(){
    $('[name^=addon], [name^=subproduct], [name=ostemplate], [name=domain], [name=cycle]','.step_0,.step_2').unbind('change.cart').bind('change.cart',function(){
        var attr = $(this).attr('onchange') == undefined && $(this).attr('onclick') == undefined;
        if(attr) simulateCart();
    });
}

function applyCoupon(form) {
    $.post('?cmd=cart&addcoupon=true',$(form).serializeArray(), cart_update);
    return false;
}

function removeCoupon() {
    $.post('?cmd=cart',{
        removecoupon:'true'
    }, cart_update);
    return false;
}
function cart_update(data){
    var resp = parse_response(data),
    summ = $(resp).filter('#summary').html(),
    ctot = $('#summary').html(summ).find('.current-total').html();
    $('#current_total').html(ctot);
    flyingSidemenu(true);
    return resp;
}
