function execute_price_update() {
    var d = 0,
        id = $('#profile_id').val(),
        name = 'productsPriceAutoUpdate',
        nicename = 'Products Price update';
    $('#taskname span').text(nicename);
    $('#output').hide();
    $('#taskindicator').show();
    $.facebox({div: '#taskexec'});
    $.get("?cmd=configuration&action=executetask&task=" + name, {debug: 0, id: id}, function (data) {
        $('#facebox #output pre').text(data);
        $('#facebox #output').show();
        $('#facebox #taskindicator').hide();
        $('#taskindicator').hide()
    });
    return false;
}

function handlePlaceholderPrice(selectProdEl) {
    var option = $(selectProdEl).find(':selected');
    var row = $(selectProdEl).closest('tr');
    var type = $(row).find('.override_margin_handler_type').val();
    if (type == 'Fixed') {
        $(row).find('.override_margin_handler').each(function () {
            var mtype = $(this).attr('data-type');
            var price = $(option).attr('data-' + mtype);
            if (price == null)
                price = '0.00';
            $(this).attr('placeholder', price);
        });
    } else {
        $(row).find('.override_margin_handler').each(function () {
            $(this).attr('placeholder', '0.00');
        });
    }
}

function bindMarginOptions() {
    $('.product_select').on('change', function () {
        handlePlaceholderPrice($(this));
    }).each(function () {
        $(this).trigger('change');
    });

    $('.margin_type').on('change', function () {
        var val = $(this).val();
        $(this).closest('tr').find('.margin_type_char').hide();
        $(this).closest('tr').find('.margin_type_char[data-char="' + val + '"]').show();
        handlePlaceholderPrice($(this).closest('tr').find('.product_select'));
    }).each(function () {
        $(this).trigger('change');
    });

    $('.disable_autoupdate').on('change', function () {
        if ($(this).is(':checked')) {
            $(this).closest('tr').find('.override_margin').prop('checked', false).prop('disabled', true).trigger('change');
        } else {
            $(this).closest('tr').find('.override_margin').prop('disabled', false).trigger('change');
        }
    }).each(function () {
        $(this).trigger('change');
    });

    $('.override_margin').on('change', function () {
        if ($(this).is(':checked')) {
            $(this).closest('tr').find('.override_margin_handler').prop('disabled', false);
        } else {
            $(this).closest('tr').find('.override_margin_handler').prop('disabled', true).not('select').val('');
        }
    }).each(function () {
        $(this).trigger('change');
    });

    $('.chosenedge').chosenedge({
        width: '100%',
        search_contains: true,
    });

    $('.remove_product_settings').unbind('click').bind('click', function (e) {
        e.preventDefault();
        $(this).closest('tr').remove();
    });
    $('.vtip_description').vTip();
}

function addProductSetting() {
    var itt = parseInt($('.product_settings_body tr').length) + 1;
    var template = $('#product-setting-template').html();
    template = template.replace(/__itt/g, itt);
    $('.product_settings_body').append(template);
    bindMarginOptions();
}

$(function () {
    bindMarginOptions();

    var warnI = $('#warn-no-support'),
        warnP = $('#warn-no-product'),
        btn = $('#save_changes'),
        options = $('.support_import_products'),
        server_chosen = $('.chosenedge[name="server_id"]'),
        product_chosen = $('.chosenedge[name="default_product"]');


    $('.chosenedge').chosenedge({
        width: '100%',
        search_contains: true,
    });

    $('#default_margin_type').on('change', function () {
        var val = $(this).val();
        $('.default_margin_type_char').hide();
        $('.default_margin_type_char[data-char="' + val + '"]').show();
    }).trigger('change');

    $(server_chosen).chosenedge({
        width: '100%',
        enable_split_word_search: true,
        search_contains: true,
    }).on('change', function () {
        $.post('?cmd=importaccounts&action=verifySupportProducts', {id: this.value}, function (data) {
            warnI.hide();
            warnP.hide();
            options.hide();
            btn.prop('disabled', true);
            if (data.support) {
                warnI.hide();
            } else {
                warnI.show();
                return false;
            }
            var parent = $(server_chosen).find('option:selected').data('modid');
            $(product_chosen).find('option').prop('disabled', true);
            if (parent !== '') {
                $(product_chosen).find('option[data-parent="' + parent + '"]').prop('disabled', false);
            }
            $(product_chosen).trigger('chosen:updated');

            if ($(product_chosen).find('option[data-parent="' + parent + '"]').length) {
                warnP.hide();
            } else {
                warnP.show();
                return false;
            }
            options.show();
            btn.prop('disabled', false);
        });
    }).trigger('change');
});