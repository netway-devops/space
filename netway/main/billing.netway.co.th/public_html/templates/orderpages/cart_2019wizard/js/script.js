$(function () {
    $('#cartCarousel').slick({
        infinite: false,
        slidesToShow: 4,
        slidesToScroll: 1,
        arrows: true,
        dots: true,
        responsive: [{
            breakpoint: 1200,
            settings: {
                slidesToShow: 2,
                dots: true,
                arrows: false
            }
        }, {
            breakpoint: 768,
            settings: {
                slidesToShow: 1,
                dots: true,
                arrows: false
            }
        }]
    });
});
var delayTimer;

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
    $('.dom-period').each(function () {
        $(this).val($(s).val());
    });
    $('.dom-period').eq(0).change();
}

function simulateCart(forms) {
    $('#cartSummary').addLoader();
    ajax_update('?cmd=cart&step=' + step + '&' + $(forms).serialize(), {'simulate': '1'}, '#cartSummary');
}

function changeCycle(forms) {
    $(forms).append('<input type="hidden" name="ccycle" value="true"/>').submit();
    return true;
}

function add_ns(elem) {
    var limit = 10,
        tr = $(elem).parents('tr').first(),
        button = $('.add_ns'),
        id = tr.children().last().children().first().data('id'),
        clone = tr.clone(),
        new_id = id + 1,
        ip = $('input[name="nsip' + id + '"]').parents('tr').first(),
        new_ip = $('input[name="nsip' + new_id + '"]').parents('tr').first();

    if (id < limit) {
        clone = prepare_ns(clone, id);
        if (new_id === limit)
            clone.children().last().children().last().remove();
        tr.after(clone);
        button.remove();
        if (ip.length > 0 && new_ip.length <= 0) {
            var cloneip = ip.clone();
            cloneip = prepare_ns(cloneip, id);
            ip.after(cloneip);
        }
    }
}

function prepare_ns(clone, id) {
    var input = clone.children().last().children().first(),
        text = clone.children().first().html(),
        new_id = id + 1,
        name = input.prop('name');
    input.data('id', new_id);
    input.prop('name', name.replace(id, new_id));
    input.prop('value', '');
    text = text.replace(id, new_id);
    clone.children().first().html(text);

    return clone;
}

function toggleCard(item) {
    $('.owndomain_card_toggler').not(item).prop('checked', false);
    $('.items .item-body').hide();
    if ($(item).is(':checked')) {
        $(item).closest('.item').find('.item-body').show();
    }
}

function on_submit_domain_update() {
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
    return true;
    return false;
}