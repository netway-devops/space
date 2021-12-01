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
    
    buttons_center_fix();
    flyingSidemenu();
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
    $('#sidemenu').height($('#floater').height());
    $(window).scroll(function(){
        var t=$(window).scrollTop()-$('#sidemenu').offset().top;
        var maxi  =$('#contener').height()-$('#floater').height()-15;
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
/*$(window).load(function(){
    var height = $('.servers').height();
    $('.servers .column').each(function(index){
			var current = $(this).outerHeight();
			if(height-current > 0){
               $(this).css('margin-top', height-current);
            }
	}); 
});
$(document).ready(function(){
	
	$('.column').each(function(i){
        if(i % 4 < 2) $(this).find('ul li dl').addClass('left'); else $(this).find('ul li dl').addClass('right')
    })
	$('.column ul li').hover(function(){
            var h = $(this).find('dl').css({visibility:'hidden', display:'block'}).height(),
            w = $(this).find('dl').outerWidth(true);
            if($(this).parents('.column').offset().left < w && $(this).find('dl').hasClass('left')){
                $(this).find('dl').removeClass('left').addClass('right');
            }else if( ($(this).parents('.column').offset().left + $(this).parents('.column').width() + w) > $(document).width() && $(this).find('dl').hasClass('right')){
                $(this).find('dl').removeClass('right').addClass('left');
            }
            console.log([w, $(this).parents('.column').offset().left,  $(this).parents('.column').width(), $(document).width()]);
			$(this).find('dd').css({'top':(-h/2 + 20)+'px'}).end().find('dl').css({visibility:'visible', display:'none'}).fadeIn();
            
		}, function(){
			$(this).find('dl').hide();
	});

	$('.column-header').click(function(){
		$('.column-header').css({
			'border': 'solid 2px #fff',
			'border-bottom': 'solid 2px #d4d4d4',
			'box-shadow': 'none'
		});
		$(this).css({
			'border': 'solid 2px #91c03d',
			'box-shadow': '0 0 5px 0 #91c03d'
			})
	});

    var lim = 0;
    $('#planfeat li').each(function(li){
        $('.packdescr').eq(li % 4).append($(this).html())
    });
    $('.ribbon').each(function(){
        var hbg = $(this).find('.ribbon-bg').position(),
            ht = $(this).find('.ribbon-t').position();
        $(this).find('.ribbon-bg').height(ht.top - hbg.top - 5);
    });

})*/
