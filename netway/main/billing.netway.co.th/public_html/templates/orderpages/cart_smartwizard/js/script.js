$(function() {
    $('.menu-pattern .menu ul .active-menu').next('li').addClass('afterefect').end().prev('li').addClass('prevefect');
    center_category_list();
    if ($('#add-domain > div:visible').length == 0) {
        $('#add-domain > div:first').show();
    }
    $('.arrow-box').click(function() {
        var self = $(this)
        //$(this).next('.domain-box').css('display','block');
        if (self.is('.arrow-up')) {
            self.parents('.option-box').next('.option-hidden-content').slideUp();
            self.prev('a').text('Open');
            self.removeClass('arrow-up');
        } else {
            self.parents('.option-box').next('.option-hidden-content').slideDown();
            self.prev('a').text('Close');
            self.addClass('arrow-up');
        }
    });
    $('.cart-switch span').click(function() {
        if ($(this).hasClass('active'))
            return false;
        var act = $('.cart-switch span.active'),
            ths = $(this);
        $(ths).addClass('pre-active');
        $('.cart-switch div').css(act.position())
            .width(act.width())
            .height(act.removeClass('active').height())
            .show()
            .animate(ths.position(), 'fast', 'swing', function() {
                ths.addClass('active');
                ths.removeClass('pre-active');
                $('.cart-switch div').hide();
                return false;
            });
    });

});
$(window).load(function() {
    center_category_list();
});
function simulateCart(forms) {
    $('.ajax-indicator, .ajax-indicator-dark').show();
    ajax_update('?cmd=cart&step=' + _get('step') + '&' + $(forms).serialize(), {'simulate': '1'}, '#cartSummary');
}
function center_category_list() {
    var pos = 0;
    $('.hosting-types li').removeClass('edge').each(function() {
        if ($(this).position().top > pos) {
            pos = $(this).position().top;
            if ($(this).prev().length)
                $(this).prev().addClass('edge');
        }
    });
}
var step1 = {
    on_submit: function() {
        if ($("input[value='illregister']").is(':checked')) {
            //own
            ajax_update('?cmd=checkdomain&action=checkdomain&product_id=' + $('#product_id').val() + '&product_cycle=' + $('#product_cycle').val() + '&' + $('.tld_register').serialize(), {
                layer: 'ajax',
                sld: $('#sld_register').val()
            }, '#updater', true);
        } else if ($("input[value='illtransfer']").is(':checked')) {
            //transfer
            ajax_update('?cmd=checkdomain&action=checkdomain&transfer=true&sld=' + $('#sld_transfer').val() + '&tld=' + $('#tld_transfer').val() + '&product_id=' + $('#product_id').val() + '&product_cycle=' + $('#product_cycle').val(), {
                layer: 'ajax'
            }, '#updater', true);
        } else if ($("input[value='illupdate']").is(':checked') || $("input[value='illsub']").is(':checked')) {

            return true;
        }
        return false;
    }
}
function insert_singupform(el) {
    $.get('?cmd=signup&contact&private', function(resp) {
        resp = parse_response(resp);
        var pref = $(el).attr('name');
        //$(el).removeAttr('name').attr('rel', pref);
        $(resp).find('input, select, textarea').each(function() {
            $(this).attr('name', pref + '[' + $(this).attr('name') + ']');
        }).end().appendTo($(el).siblings('.sing-up'));
    });
}
function remove_domain(domain, msg) {
    $('.domain-row-' + domain).addClass('shownice');
    if (confirm(msg)) {
        $('.domain-row-' + domain).remove();
        $('#cartSummary').addLoader();
        ajax_update('?cmd=cart&step=2&do=removeitem&target=domain', {
            target_id: domain
        }, '#cartSummary');
        if ($('.domain-row').length < 1) {
            window.location = '?cmd=cart';
        }
    }

    $('.domain-row-' + domain).removeClass('shownice');
    return false;
}
function bulk_periods(s) {
    $('.dom-period').each(function() {
        $(this).val($(s).val());
    });
    $('.dom-period').eq(0).change();

}
function change_period(domain) {
    var newperiod = 1;
    newperiod = $('#domain-period-' + domain).val();
    $('#cartSummary').addLoader();
    ajax_update('?cmd=cart&step=2&do=changedomainperiod', {
        key: domain,
        period: newperiod
    }, '#cartSummary');
    return false;
}

function changeCycle(forms) {
    $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
    return true;
}

function reform_ccform(html) {
    $('#gatewayform').find('.wbox').removeAttr('class').prepend('<h3 class="openSansBold">' + $('#gatewayform .wbox_header strong').text() + '</h3><div class="contact-underline"><span class="underline-title-bold"></span></div>');
    $('#gatewayform .wbox_header').remove();
}

function pop_ccform(valu) {
    $('#gateway_form').val(valu);
    $.post('?cmd=cart&action=getgatewayhtml&gateway_id=' + valu, '', function(data) {
        var data = parse_response(data);
        if (data.length) {
            $('#gatewayform').html(data);
            reform_ccform();
            $('#gatewayform').slideDown();
        } else
            $('#gatewayform').slideUp('fast', function() {
                $(this).html('')
            });
    });
}

$(document).bind('fieldLogicLoaded', function(event, fl) {
    $.fieldLogic.getContainer = function(cond) {
        return $(cond.target).parents('.option-row').eq(0);
    };
});