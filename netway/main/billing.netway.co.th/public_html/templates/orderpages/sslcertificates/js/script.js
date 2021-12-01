function shortenSeparators(){
    $('#progress-indicator .step > div:last-child').each(function(){
        var contentw = 0;
        $(this).children().each(function(){
            contentw += $(this).outerWidth(true)
        })
        $(this).width(contentw+1).css({
            margin:'auto'
        });
    });
    $('#progress-indicator .step').each(function(){
        var wid = $(this).children(':last').width(),
        totwid = $(this).width();
        $(this).children('.line').width( (totwid - wid) /2 );
    });
}

function step1(){
    
    $('.products-view').css('min-height', $('.products').outerHeight());
    $('.products a').click(function(){
        $('.products li').removeClass('selected');
        
        var index = $(this).parent().addClass('selected').index();
        $('.products-view .product:visible').fadeOut('fast', function(){
            $('.products-view .product').eq(index).fadeIn();
        });
        
        return false;
    });
}


var step2 = {
    ShowCsrBox : function(show) {
        if(!show) {
            $('#wtcsr').fadeOut('fast',function(){
                $('#cn').focus();
                $('#csrplace').fadeIn();
            });
        } else {
            $('#csrplace').fadeOut('fast',function(){
                $('#csrbox').focus();
                $('#wtcsr').fadeIn();
            }); 
        }
    },
    EnableSubmit : function(so) {
        if(so) {
            $('#btn_submit').removeClass('disabled');
        } else {
            $('#btn_submit').addClass('disabled');
        }
    },
    submitmform : function(el) {
        if($(el).hasClass('disabled'))
            return false;
        if(jQuery.trim($('#csrbox').val())=='') {
            $('#nocsr input').attr('checked','checked').prop('checked', true);
        }
        $('#mform').submit();
        return false;
    },
    init : function(){
        $('#cn').keyup(function(){
            if($(this).val()!='') {
                step2.EnableSubmit(true);
            } else {
                step2.EnableSubmit(false);
            }
        });

        $('#csrbox').change(function(){
            $(this).parent().addLoader();
            $('.close').click();
            $.post('?cmd=cart&do=checkcsr',{
                csr:$(this).val()
            },function(data){
                $('#preloader').hide();
                if(data.response.error) {
                    if($('#errors .alert').length){
                        $('#errors .alert').html('<a class="close">×</a>').append(data.response.error+'<br />');
                    }else
                        $('#errors').append('<span >'+data.response.error+'</span>');
                    reBind();
                    $('#errors').clone(true).attr('id', 'errors2').insertAfter('.step-csr-input');
                    $('#errors2').slideDown();
                    $('#cn').val("");
                    step2.EnableSubmit(false);
                }else if (data.response.CN) {
                    $('#cn').val(data.response.CN);
                    for(var proper in data.response) {
                        if($('#i_'+proper).length) {
                            $('#i_'+proper).val(data.response[proper]);
                        }
                    }
                    step2.EnableSubmit(true);
                }
            });
        });
        $('#nocsr .clicky').click(function(){
            var ee=$(this).parent().find('input');
            var ea=$('#nocsr input[name=yescsr]');
            if(ee.attr('name')=='yescsr') {
                ea=$('#nocsr input[name=nocsr]');
            }
            if(!ee.is(':checked')) {
                if(ee.attr('name')=='yescsr') {
                    step2.ShowCsrBox(ee.is(':checked'));
                } else {
                    step2.ShowCsrBox(!ee.is(':checked'));
                }
                ee.attr('checked','checked');
                ea.removeAttr('checked');
            }
        });
        $('#nocsr input').click(function(){
            var checked= $(this).is(':checked');
            if($(this).attr('name')=='yescsr') {
                step2.ShowCsrBox(!checked);
                var sec = $('#nocsr input[name=nocsr]');
            } else {
                step2.ShowCsrBox(checked);
                var sec = $('#nocsr input[name=yescsr]');
            }
            if(checked) {
                sec.removeAttr('checked').prop('checked',false);
            } else {
                sec.attr('checked','checked').prop('checked',true);
            }
        });
    }
};

var step3 = {
    init: function(){
        $('.tipsing').tipsy({
            gravity: 'w',
            html:true
        });
    },
    sh_els: function (el) {
        if($(el).is(':checked')) {
            $('#bcontact').slideUp();	
            $('#biltech').slideDown();
        } else {
            $('#bcontact').slideDown();	
            $('#biltech').slideUp();
        }
    },
    submitmform: function (el) {
        $('#mform').submit();
        return false;
    }
}

function step5(){
    $('td').filter(function() {
        return $.trim($(this).text()) === '' && $(this).children().length == 0
    }).height(5).css('line-height','0px')
    
    $('.step-gateway').height($('.step-order-sum').height());
    reform_ccform();
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
}
function tabbme(el) {
    $(el).parent().find('button').removeClass('active');
    $('#options div.slidme').hide().find('input[type=radio]').removeAttr('checked');
    $('#options div.'+$(el).attr('rel')).show().find('input[type=radio]').attr('checked','checked');
    $(el).addClass('active');
}
function fixHeightsDelay() {
    setTimeout(function(){
        $('#right').height($('#cart_sum').height()+20);
    },450);
}
function flyingSidemenu() {
    setTimeout(function(){
        $('#right').height($('#floater').height());
        $(window).scroll(function(){
            var t=$(window).scrollTop()-$('#right').offset().top;
            var maxi  =$('.content').height()-$('#floater').height()-15;
            if(t>maxi)
                t=maxi;
            if(t<0)
                t=0;
            $('#floater').animate({
                top:t+"px"
            },{
                queue: false, 
                duration: 300
            });
        });
    },450);
}
function simulateCart(forms) {
    $('#cartSummary').addLoader();
    ajax_update('?cmd=cart&do=4'+'&'+$(forms).serialize(),{
        'simulate':'1'
    },'#cartSummary');
}
function changeCycle(forms) {
    $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
    return true;
}

function applyCoupon() {
    var f = $('#promoform').serialize();
    $('#cartSummary').addLoader();
    ajax_update('?cmd=cart&addcoupon=true&do=4'+'&'+f,{},'#cartSummary');
    return false;
}

function removeCoupon() {
    $('#cartSummary').addLoader();
    ajax_update('?cmd=cart&removecoupon=true&do=4',{},'#cartSummary');
    return false;
}
function reform_ccform(html){
    $('#gatewayform').find('.wbox').attr('class','white-box').find('.wbox_header strong').unwrap().wrap('h3').after('<div class="strike-line"></div>');
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
function checkout(){
    if($("#c_notes").val()=="{$lang.c_tarea}")$("#c_notes").val("");
    $('#gateway_form').val($('input[name="gate"]:checked').val());
    return true;
}