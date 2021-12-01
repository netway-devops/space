var conditions = [], sliders =[], slideron = 0;
function conditioncheck(a){
    if(typeof a == 'function'){
        conditions.push(a);
    }else if(a == undefined && conditions.length){
        for(var i =0; i < conditions.length; i++){
            conditions[i]();
        }
        conditions = [];
    }
}
$(function(){
    $('#plan-tab td').click(function(){
        //Setting which row was clicked
        var row = $(this).parent().index('tr');
        //Setting which column was clicked
        var col = $(this).index('tr:eq('+row+') td');
		
        //if 1 of 5 column with plan was clicked
        if($(this).is('.bundle-td'))
            setBundle(col);
    })
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
    
    setBundle($('.active-col:eq(0)').index());
})

$(window).load(function(){
    dropdownForms();
    domainToggles();
})
function domainToggles(){
    var w = 0;
    $('.toggle-slider.domains > div').each(function(){
        w+=$(this).outerWidth(true);
    }).parent().width(w+5);
        
}
function simulateCart(forms, domaincheck) {
    /*
        Sends configuration data on each change made in forms and updates order prices/summary tab
    */
    //$('#load-img').show();
    //$('.order-summary').addClass('half-opacity');
    var urx = '?cmd=cart',
    form = $('input, select, textarea','#cartforms').filter(function(){
        if($(this).parents('#domoptions11, .toggle-slider.domains').length) return false;
        return true
    });
    if(domaincheck) urx += '&_domainupdate=1&';
    $('.ajax-overlay:last').show();
    //conditioncheck();
    ajax_update(urx, form.serializeArray(), '#configer');
}
	
function setBundle(col){
    col = col || 1;
    //Removing active column
    $('.active-col').removeClass('active-col');
    var tds = $('.bundle-'+(col-1)),
    rw = $('.ribbon-orderpage').outerWidth(true);
    //Setting active column
    tds.addClass('active-col');
    //Changing ribbon position

    $('.ribbon-orderpage').css('left', tds.eq(0).position().left + ( (tds.eq(0).outerWidth() - rw) /2) );
		
    //Setting text to display on ribbon
    $('.ribbon-middle').children('span').html(tds.eq(0).html())
    changeProduct(tds.eq(0).attr('id').substr(1));
}

function changeProduct(pid) {
    /*
        Change product, and load its configuration options
    */

    if(pid==$('#pidi').val())
        return;
    
    console.log('before')
    $('#pidi').val(pid);
    $('.additional-option-box').addClass('half-opacity');
    $('#errors').slideUp('fast',function(){
        $(this).find('span').remove();
    });
    $('.ajax-overlay:first').show();
    $.post('?cmd=cart',{
        id: pid
    },function(data){
        $.fieldLogic.reset();
        var r = parse_response(data);
        $('#configer').html(r).fieldLogic();
    });
}  

function dropdownForms(){
    $('#configer .dropdown .dropdown-toggle').each(function(){
        var w = 0,
        that = $(this);
        that.next('ul').each(function(){ 
            var ul = $(this),
            name = ul.attr('rel');
            w = ul.outerWidth() > w ? ul.outerWidth() : w;
            
            if(name != undefined && name.length && !$('select[name="'+name+'"].dropdown').length){
                var sel = ul.next('select').addClass('dropdown');//$('<select name="'+name+'" style="display:none;" '+change+' class="'+sclass+'"></select>').insertAfter(ul);
                var off = ul.find('.off');
                var itemtg = ul.attr('item-toggle');

                ul.find('a').each(function(){
                    var a = $(this),
                    val = a.attr('href');
                    if(val.length > 1){
                        //sel.append('<option value="'+val.substr(1)+'">'+a.text()+'</option>');
                        a.click(function(){
                            that.children('span').text(a.text()).click();
                            if(off.length)
                                off.parent().show();
                            if(itemtg)
                                toggle(itemtg );
                            sel.val(val.substr(1)).change();
                            
                            return false;
                        });
                        
                    } else if(a.hasClass('off')){
                        sel.append('<option value="">-</option>');
                        a.click(function(){
                            that.children('span').text(a.attr('rel') || a.text()).click();
                            a.parent().hide();
                            if(itemtg)
                                toggle(itemtg, true);
                            sel.val('').change();
                            return false;
                        });
                    }
                });
                sel.val(that.attr('href').substr(1));
                if(itemtg &&  that.attr('href') != undefined && that.attr('href').substr(1).length)
                    toggle(itemtg);
            }
        }).end().width(w > that.parents('.additional-option-box').width()-20 ? that.parents('.additional-option-box').width()-20 : w);
    }).bind('click', function(){
        var that = $(this);
        var w = that.parent().outerWidth(false),
        overwidth = false,
        ul = that.next();
        ul.each(function(){
            if($(this).outerWidth() > w){
                overwidth = true;
                return false;
            }
        });
        if(!overwidth)
            ul.removeClass('ower-width').width(w);
        else{
            ul.addClass('ower-width');
        }
    });
}

function toggleForms(){
    $('#configer .toggle-option-fix').parent().each(function(){
        var that = $(this),
        name = that.attr('rel'),
        sclass = 'custom_field_' + name.replace(/^custom\[(.*)\]$/,'$1'),
        change = that.attr('change-event') ? "": 'onchange="simulateCart()"';
        if(name != undefined && name.length && !$('input[name="'+name+'"]').length){
            var input = $('<input type="hidden" name="'+name+'" '+change+' class="'+sclass+'" />').appendTo(that);
            that.children('.toggle-option-fix').each(function(){
                var tog = $(this);
                $(this).click(function(){
                    if(tog.hasClass('active-toggle'))
                        return false;
                    $('.active-toggle').removeClass('active-toggle');
                    $(tog).addClass('active-toggle');
                    input.val(tog.attr('rel') || tog.text()).change();
                });
                if(tog.hasClass('active-toggle'))
                    input.val(tog.attr('rel') || tog.text());
            });
            
        }
    });
}
function sliderForms(){
    $('#configer .additional-option-box .slider-box').each(function(x){
        var i = x+slideron,
        slide = $(this),
        name = slide.attr('rel'),
        sclass = 'custom_field_' + name.replace(/^custom\[(.*)\]$/,'$1');
        if(sliders[i] != undefined && name != undefined && name.length && !$('input[name="'+name+'"]').length){
            var input = $('<input type="hidden" name="'+name+'" onchange="simulateCart()" value="'+sliders[i].value+'" class="'+sclass+'" />').appendTo(slide);
            slide.next('.qty-td').text(sliders[i].value);
            $('div',slide).slider({
                range: "min",
                animate: 300,
                value: sliders[i].value,
                min: sliders[i].min,
                max: sliders[i].max,
                step: sliders[i].step,
                slide: function(event, ui){  
                    slide.next('.qty-td').html(ui.value);  
                },
                change: function(event, ui){
                    slide.next('.qty-td').html(ui.value);  
                    input.val(ui.value).change();
                }
            });
        }
    });
}

function packageSliderChange(i, ui, send){
    var elem = $('#custom_field_'+sliders[i].id),
        val = elem.val();
        elem.val(ui.value);
    
    if(send && parseInt(val) != parseInt(ui.value)){
        simulateCart();
    }
        
}

function packageSliders(){
    $('.customize-td').each(function(i){
        var slider = $('.slider-box div',this);
        if(slider.length==0){
            $(this).next('.qty-td').text('-');
        }else if(slider.hasClass('ui-slider')){
            if(sliders[i] != undefined){
                slider.slider("option", { 
                    disabled: false,
                    //value: sliders[i].value,
                    min: sliders[i].min,
                    max: sliders[i].max,
                    step: sliders[i].step,
                    change: function(event, ui){
                        packageSliderChange(i, ui, false)
                    }
                }).slider("value", sliders[i].value).slider("option",{
                    change: function(event, ui){
                        packageSliderChange(i, ui, true)
                    }
                });
                $(this).attr('class','customize-td custom_field_'+sliders[i].id).next('.qty-td').text(sliders[i].value);
            }else{
                slider.slider("option",{
                    change: function(event, ui){
                        packageSliderChange(i, ui, false)
                    }
                }).slider("option", { 
                    disabled: true,
                    value:0
                });
                $(this).next('.qty-td').text('-');
            }
        }else{
            
            if(sliders[i] != undefined){
                slider.slider({
                    range: "min",
                    animate: 300,
                    value: sliders[i].value,
                    min: sliders[i].min,
                    max: sliders[i].max,
                    step: sliders[i].step,
                    slide: function(event, ui){  
                        $('#amount-'+i).html(ui.value);  
                    },
                    change: function(event, ui){
                        packageSliderChange(i, ui, true)
                    }
                });
                $(this).attr('class','customize-td custom_field_'+sliders[i].id).next('.qty-td').text(sliders[i].value);
            }else{
                slider.slider({
                    range: "min", 
                    animate: 300, 
                    min: 0, 
                    max: 1, 
                    step: 1, 
                    slide: function(event, ui){
                        $('#amount-'+i).html(ui.value);
                    }
                }).slider('disable');
                $(this).next('.qty-td').text('-');
            }
        }
    });
}
function tabbme(el) {
    $('#options div.slidme').hide();
    $('#'+$(el).attr('rel')).show();
}
function domainCheck() {
    /*
        This function handles domain form
    */
    var action = $("input[name=domain]").val(),
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
            target = '#configer';
            break;
        case 'illsub':
            url='?cmd=cart&domain=illsub';
            param.sld_subdomain=$('#sld_subdomain').val();
            target = '#configer';
            break;
    }
    ajax_update(url,param,target);

    return false;
}

function reform_ccform(html){
    $('<h1>'+$('#gatewayform').find('.wbox_header strong').text().replace(/:/, '')+'</h1>').replaceAll($('#gatewayform .wbox_header')).after('<div class="underline-title"><div class="underline-bold"></div></div>');
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
    },'#configer');
    return false;
}

function mainsubmit(formel) {
    return true;
}

function toggle(name, off){
    var inp = $('input[name="'+name+'"]').length;
    if(off != undefined && off && inp){
        $('input[name="'+name+'"]').remove();
    }else if(!inp){
        $('<input name="'+name+'" type="hidden" value="1" />').appendTo('#cartforms');
    }
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

function applyCoupon() {
    var f = $('#couponcde').val();
    ajax_update('?cmd=cart&addcoupon=true&promocode='+f,{}, '#configer');
    return false;
}

function removeCoupon() {
    ajax_update('?cmd=cart&removecoupon=true',{},'#configer');
    return false;
}

$(document).bind('fieldLogicLoaded', function(event, fl){
    var old = $.extend({}, $.fieldLogic);
    $.fieldLogic.getContainer = function(cond){
        var ct = old.getContainer(cond).not('.select-plan-bg');
            if(ct.parent().is('.additional-option-box'))
                ct = ct.parent();
        return ct;
    };
    $.fieldLogic.setValue = function(cond){
        return old.getContainer(cond).not('.select-plan-bg');
    };
    $.fieldLogic.getValue = function(cond){
        //console.log(this);
        return old.getValue.call($(this).filter('input, select, textarea'), cond);
    };
});