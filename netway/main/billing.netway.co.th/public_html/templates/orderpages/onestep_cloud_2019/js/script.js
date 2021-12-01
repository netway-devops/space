// stickySummaryBlock
//      val 2; always fixed to bottom
//      val 1; fixed by default, but, if last section in orderpage is visible then it will be at the end of orderpage displayed as normal `display: block` | @deprecated !
//      val 3; always displayed by default as normal `display: block` after last section in orderpage | @deprecated !
var stickySummaryBlock = 2;

var active = false;
$(document).ready(function (e) {
    var products = $('.cart-product'),
        in_stock = products.not('.outofstock');

    in_stock.click(function (e) {
        if ($(this).hasClass('selected')) return false;
        $('.cart-product').not($(this)).removeClass('selected');
        $(this).addClass('selected');
        changeProduct($(this).attr('data-value'));
        if (scrollToConfig) {
            $('html, body').animate({ scrollTop: $(".orderpage-configuration").offset().top - 100}, 1000);
        }
        e.stopImmediatePropagation();
        return false;
    });
    if(in_stock.length && !products.filter('.selected').length) {
        in_stock.first().trigger('click');
    } else {
        simulateCart();
        parseSummaryBlockSize();
    }
    $('#domainTab a').click(function () {
        $(this).tab('show');
        return false;
    });
    $(window).scroll(function () {
        parseSummaryBlockSize();
    });
    $(window).resize(function () {
        parseSummaryBlockSize();
    });
    $('.navbar .btn-toggler').click(function () {
        setTimeout(function () {
            parseSummaryBlockSize();
        }, 300)
    });
    var isSafari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);
    if (isSafari) {
        var css = '.template_2019 .orderpage#orderpage{margin-bottom:150px}',
            head = document.head || document.getElementsByTagName('head')[0],
            style = document.createElement('style');
        head.appendChild(style);
        style.appendChild(document.createTextNode(css));
    }
    preparePrice();
});

function preparePrice() {
    var self = $('.orderpage-summary_bcycle select'),
        cycle = self.val(),
        card_prices = $('.card-subtitle');

    card_prices.show();
    card_prices.find('.product-price, .product-cycle').hide();

    $(card_prices).each(function () {
        var card = $(this),
            pr = card.find('.product-price.cycle-' + cycle),
            cc = card.find('.product-cycle.cycle-' + cycle);
        if (pr.length && cc.length) {
            pr.show();
            cc.show();
        } else {
            card.find('.product-price').eq(0).show();
            card.find('.product-cycle').eq(0).show();
        }
    });
}

function parseSummaryBlockSize() {
    var lastBlock = $('#orderpage-lastblock');
    var summBlock = $('#orderpage-summary');
    if (lastBlock.length && summBlock.length) {
        var summBlockH = parseInt($(summBlock).height());
        var docViewTop = parseInt($(window).scrollTop());
        var docViewBottom = docViewTop + $(window).height();
        var elemTop = parseInt($(lastBlock).offset().top);
        var elemBottom = elemTop + $(lastBlock).height();
        var sb = $('.sidebar');
        var sbWidth = parseInt($(sb).width());
        var sbMleft = parseInt($(sb).css('margin-left'));
        var sm = $('.section-main');
        var smWidth = parseInt($(sm).width());
        var sf = $('.footer-content');
        switch (parseInt(stickySummaryBlock)) {
            case 1:
                if ((elemBottom <= docViewBottom)) {
                    $(summBlock).removeClass("orderpage-summary-sticky").css({'margin-left': 0});
                } else {
                    $(summBlock).addClass("orderpage-summary-sticky").css({'margin-left': sbWidth + sbMleft});
                }
                break;

            case 2:
                $(summBlock).addClass("orderpage-summary-sticky").css({'margin-left': sbWidth + sbMleft});
                break;

            case 3:
                $(summBlock).removeClass("orderpage-summary-sticky").css({'margin-left': 0});
                break;
        }
        $(summBlock).find(".orderpage-summary-content").css({'width': smWidth});
        $(summBlock).find(".orderpage-summary-details").hide().css({'width': smWidth});
        $(summBlock).find(".orderpage-summary-details-info").css({'width': smWidth});
    }
}

function toggle_items(item) {
    var items = $(item).closest('.item').find('.items');
    if ($(item).is(':checked'))
        $(items).show();
    else
        $(items).hide();
}

function toggle_client(item) {
    $(item).closest('.toggle-forms').find('.toggle-forms-body').html('').hide();
    if ($(item).is(':checked'))
        $(item).closest('.item').find('.toggle-forms-body').show();
    else
        $(item).closest('.item').find('.toggle-forms-body').hide();
}

function addClasses() {
    $('select').removeClass('form-control').addClass('form-control');
}

function changeProduct(pid) {
    $('#updater').addLoader();
    $.post('?cmd=cart', {
        id: pid
    }, function (data) {
        _updateCart(data);
    });
    if (pid) {
        history.pushState(null, null, updateURLParameter(window.location.href, 'id', pid));
    }
}

function updateURLParameter(url, param, paramVal){
    var newAdditionalURL = "";
    var tempArray = url.split("?");
    var baseURL = tempArray[0];
    var additionalURL = tempArray[1];
    var temp = "";
    if (additionalURL) {
        tempArray = additionalURL.split("&");
        for (var i=0; i<tempArray.length; i++){
            if(tempArray[i].split('=')[0] != param){
                newAdditionalURL += temp + tempArray[i];
                temp = "&";
            }
        }
    }

    var rows_txt = temp + "" + param + "=" + paramVal;
    return baseURL + "?" + newAdditionalURL + rows_txt;
}

function setAction(el) {
    var href = $(el).attr('href');
    $('.tab-pane').find('input[name=domain]').removeAttr('checked').prop('checked', false).parents('.tab-pane').hide();
    $(href).find('input[name=domain]').attr('checked', 'checked').prop('checked', true).parents('.tab-pane').show();
    $('#domoptions22').hide();
}

function _updateCart(data) {
    data = parse_response(data);
    $('#updater').html(data);
    $('#cartforms').find('#preloader').remove();
    addClasses();
    initNavtabs();
    bindSimulateCart();
    $('.cart_items_check').each(function () {
        toggle_items($(this));
    }).change(function () {
        toggle_items($(this));
    });
    parseSummaryBlockSize();
    parseSectionsCounters();
    preparePrice();
    if ($('.domain-tld').length > 0) {
        new PerfectScrollbar('.domain-tld');
    }
}

function parseSectionsCounters() {
    setTimeout(function () {
        var num = 1;
        $('.cart-products-scount_js').each(function () {
            var sh = true;
            if ($(this).closest('.option-val').length) {
                if ($(this).closest('.option-val').css('display') == 'none') {
                    sh = false;
                }
            }
            if (sh !== false) {
                $(this).html(num);
                num ++;
            }
        });
    }, 300);
}

function simulateCart(cart) {
    var form = $('#cartforms');
    $(form).addLoader();
    var data = form.serializeArray();
    data.push({name:'cycle', value:$('[name="cycle"]').val()});
    $.post('?cmd=cart', data, function (response) {
        _updateCart(response);
    });
}

function bindSimulateCart() {
    $('.bindcart_js').each(function () {
        $(this).find('input, select, textarea').change(function () {
            var attr = $(this).attr('onchange') == undefined && $(this).attr('onclick') == undefined;
            if (attr)
                simulateCart();
        });
    });
    $('.domain-tab').find('button.btn[type="submit"]').click(function (e) {
        var attr = $(this).attr('onchange') == undefined && $(this).attr('onclick') == undefined;
        if (attr) {
            simulateCart();
            e.preventDefault();
        }
    });
}

function tryToCopyUpdateDomain() {
    if ($('#iwantupdate_cart').is(':checked')) {
        var item = $('.iwantupdate_cart_select option:selected');
        var sld = item.attr('data-sld');
        var tld = item.attr('data-tld');
        $('input[name="sld_update"]').val(sld);
        $('input[name="tld_update"]').val(tld);
    } else if ($('#iwantupdate_myaccount').is(':checked')) {
        var item = $('.iwantupdate_myaccount_select option:selected');
        var wipe = /^[-\.]+|[-\.]+$|^((?!xn).{2})--|[!@#$€%^&*()<>=+`~'"\[\\\/\],;| _]|^w{1,3}$|^w{1,3}\./g;
        var domain = item.attr('data-domain').trim().toLowerCase().replace(wipe, '$1');
        var dot = (domain + '.').indexOf('.');
        var parts = [domain.slice(0, dot), domain.slice(dot + 1)];
        var sld = parts[0];
        var tld = parts[1] ? '.' + parts[1].replace(wipe, '') : '';
        $('input[name="sld_update"]').val(sld);
        $('input[name="tld_update"]').val(tld);
    }
}

function submitOrder() {
    tryToCopyUpdateDomain();
    var form = $('#cartdetails');
    $(form).append('<input type="hidden" name="make" value="order">');
    $(form).append('<input type="hidden" name="step" value="order">');
    $(form).find('[name="autosubmited"]').remove();
    $(form).submit();
    return false;
}

function domainCheck() {
    var action = $("input[name=domain]:checked").val(),
        url = '?cmd=checkdomain&action=checkdomain&product_id=' + $('#product_id').val() + '&product_cycle=' + $('#product_cycle').val(),
        param = {layer: 'ajax'},
        target = '#updater2';
    switch (action) {
        case 'illregister':
            url += '&' + $('.tld_register').serialize();
            param.sld = $('#sld_register').val();
            break;
        case 'illtransfer':
            param.sld = $('#sld_transfer').val();
            param.tld = $('#tld_transfer').val();
            param.transfer = 'true';
            break;
        case 'illupdate':
            url = '?cmd=cart&domain=illupdate';
            tryToCopyUpdateDomain();
            param.sld_update = $('#sld_update').val();
            param.tld_update = $('#tld_update').val();
            target = '#updater';
            break;
        case 'illsub':
            url = '?cmd=cart&domain=illsub';
            param.sld_subdomain = $('#sld_subdomain').val();
            target = '#updater';
            break;
    }
    $('#domoptions11').addLoader();
    $.post(url, param, function (data) {
        $(target).html(parse_response(data));
        $('#domoptions11').find('#preloader').remove();
        initNavtabs();
        bindSimulateCart();
        if ($('.domain-tld').length > 0) {
            new PerfectScrollbar('.domain-tld');
        }
    });
    return false;
}

function applyCoupon() {
    $('#updater').addLoader();
    $.post('?cmd=cart&addcoupon=true', $('input[name=promocode]').serializeArray(), function (data) {
        _updateCart(data);
    });
    return false;
}

function removeCoupon() {
    $('#updater').addLoader();
    $.post('?cmd=cart', {removecoupon: 'true'}, function (data) {
        _updateCart(data);
    });
    return false;
}
function toggleCard(item) {
    $('.owndomain_card_toggler').not(item).prop('checked', false);
    $('.items .item-body').hide();
    if ($(item).is(':checked')) {
        $(item).closest('.item').find('.item-body').show();
    }
}