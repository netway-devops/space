$(function(){
    $('#progress-indicator div.step').width( $('#progress-indicator').width() / $('#progress-indicator div.step').length);
    var column = $('.servers .column').height();
    $('.servers .column').each(function(){
        column = column < $(this).height() ? $(this).height() : column
    }).each(function(){
        if(column - $(this).height() > 0)
            $(this).css('margin-top', column - $(this).height() );
    });
    //.progress-line
    $('.step').each(function(i){
        if(i == 0) return true;
        if($('.progress-line div').length < i+1)
            var el = $('.progress-line div:first').clone();
        else 
            var el = $('.progress-line div').eq(i).detach();
        el.removeAttr('class');
        if($(this).hasClass('progress-done') || $(this).hasClass('progress-active'))
            el.addClass('active');
        el.width($(this).width() - 60).css({
            left: $(this).position().left - ($(this).width()/2) + 30
        })
        $('.progress-line').append(el);
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

    if(step > 0 && step < 4){
        flyingSidemenu();
    }
    buttons_center_fix();
    
});
$(window).load(function(){
    $('.additional-specs').each(function(){
        var maxw = 0;
        $(this).find('li').each( function(){
            var w = $(this).wrapInner('<span />').children().width();
            if(maxw < w)
                maxw = w;
        });
        $(this).width(maxw+10);
    });
    buttons_center_fix();
});
function buttons_center_fix(){
    $('.big-btn, .big-blue-btn').each(function(){
        var w = $(this).wrapInner('<span />').children().width();
        $(this).width(w).text($(this).text());
    });
}

var step1 ={ 
    on_submit:function () {
        if($("input[value='illregister']").is(':checked')) {
            //own
            ajax_update('?cmd=checkdomain&action=checkdomain&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val()+'&'+$('.tld_register').serialize(),{
                layer:'ajax',
                sld:$('#sld_register').val()
            },'#updater',true);
        } else if ($("input[value='illtransfer']").is(':checked')) {
            //transfer
            ajax_update('?cmd=checkdomain&action=checkdomain&transfer=true&sld='+$('#sld_transfer').val()+'&tld='+$('#tld_transfer').val()+'&product_id='+$('#product_id').val()+'&product_cycle='+$('#product_cycle').val(),{
                layer:'ajax'
            },'#updater',true);
        } else if ($("input[value='illupdate']").is(':checked') || $("input[value='illsub']").is(':checked')) {
	
            return true;
        }
        return false;
    }
}

function flyingSidemenu() {
    $('#sidemenu').height($('#floater_box').height());
    if(step == 2)
        return;
    $(window).scroll(function(){
        var t=$(window).scrollTop()-$('#sidemenu').offset().top;
        var maxi  =$('.left-column').height()-$('#floater_box').height()-15;

        if(t>maxi)
            t=maxi;
        if(t<0)
            t=0;

        $('#floater_box').animate({
            top:t+"px"
        },{
            queue: false, 
            duration: 300
        });
    });
}

function remove_domain(domain, msg) {
    $('.domain-row-'+domain).addClass('shownice');
    if(confirm(msg)) {
        $('.domain-row-'+domain).remove();
        $('#cartSummary').addLoader();
        ajax_update('?cmd=cart&step=2&do=removeitem&target=domain',{
            target_id:domain
        },'#cartSummary');
        if($('.domain-row').length<1) {
            window.location='?cmd=cart';
        }
    }

    $('.domain-row-'+domain).removeClass('shownice');
    return false;
}
function bulk_periods(s) {
    $('.dom-period').each(function(){
        $(this).val($(s).val());
    });
    $('.dom-period').eq(0).change();
                
}
function change_period(domain) {
    var newperiod=1;
    newperiod = $('#domain-period-'+domain).val();
    $('#cartSummary').addLoader();
    ajax_update('?cmd=cart&step=2&do=changedomainperiod',{
        key:domain,
        period:newperiod
    },'#cartSummary');
    return false;
}
function insert_singupform(el){
    $.get('?cmd=signup&contact&private',function(resp){
        resp = parse_response(resp);
        var pref = $(el).attr('name');
        //$(el).removeAttr('name').attr('rel', pref);
        $(resp).find('input, select, textarea').each(function(){
            $(this).attr('name', pref+'['+$(this).attr('name')+']');                       
        }).end().appendTo($(el).siblings('.sing-up'));
    });
}
function changeCycle(forms) {
    $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
    return true;
}

function reform_ccform(html){
    $('#gatewayform').find('.wbox').removeAttr('class').find('.wbox_header').html('<h3>'+$('#gatewayform .wbox_header strong').text()+'</h3>').attr('class','line-header clearfix');
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
$(document).bind('fieldLogicLoaded', function(event, fl){
    $.fieldLogic.getContainer = function(cond){
        return $(cond.target).parent().parent() ;
    };
});
