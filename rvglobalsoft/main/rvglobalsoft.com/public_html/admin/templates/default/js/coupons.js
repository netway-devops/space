function sh_(what, ins) {
    if ($(ins).is(':checked')) {
        $(what).show();
        $('#cycles').show();

    } else {
        $(what).hide();
        if (!$('#products').is(':visible') && !$('#upgrades').is(':visible') && !$('#addons').is(':visible') && !$('#domains').is(':visible')) {
            $('#cycles').hide();
        }
    }
}

function randomCode(target) {
    var length = 20;
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    pass = "";
    for (x = 0; x < length; x++) {
        i = Math.floor(Math.random() * 62);
        pass += chars.charAt(i);
    }
    $(target).val(pass);
    return false;
}

function client_check(vals) {
    if (vals == 'existing') {
        $('#specify').show();
    } else
        $('#specify').hide();

}

var applycode = $('#apply_code').val();

function recurring_check(vals) {
    if (vals == 'setupfee') {
        $('#cycle_code').val('once').find('option:last').prop('disabled', true).attr('disabled', 'disabled').parents('tr').eq(0).ShowNicely();
    } else if (applycode == 'setupfee')
        $('#cycle_code option').prop('disabled', false).removeAttr('disabled').parents('tr').eq(0).ShowNicely();
    applycode = vals;
}

function check_i(element) {
    var td = $(element).parent();
    if ($(element).is(':checked'))
        $(td).find('input.config_val').removeAttr('disabled');
    else
        $(td).find('input.config_val').attr('disabled', 'disabled');
}

$(document).ready(function () {
    var proRel = $('[name=apply_products], [name=apply_categories], [name=apply_domains]', '#toggles');

    proRel.on('change', function () {
        var checked = proRel.filter(":checked").length > 0;
        var coupCart = $('#coupon_type').val() === 'cart';
        $('#cycles').toggle(checked);
        $('[name=apply_forms]', '#toggles')
            .prop('disabled', !checked || !coupCart)
            .trigger('change');
    });

    $('#toggles').on('change', '[data-toggle]', function () {
        $(this.dataset.toggle).toggle(this.checked && !this.disabled);
    }).find('[data-toggle]').trigger('change');

    $('#applicable [data-chosen]').chosenedge({
        width: "100%",
        search_contains: true,
    });

    $('#cycle_code').change(function () {
        var val = $(this).val();
        var target = $('#increase_in_days');
        if (val == 'once') {
            target.hide();
            $('input[name=increase_in_days_check]').removeAttr('checked');
            $('input[name=increase_in_days]').attr('disabled', 'disabled').val(0);
        } else {
            target.show();

        }
    });

    $('#coupon_type').change(function () {
        var val = $(this).val();

        $('.coupon-type-invoice').toggle(val === 'invoice');
        $('.coupon-type-cart').toggle(val === 'cart');

        proRel.trigger('change');
    }).trigger('change');
});