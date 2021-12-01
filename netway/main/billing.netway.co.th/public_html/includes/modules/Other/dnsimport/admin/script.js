$(function () {

        $('.leftNav a:not(:contains("DNS"))').remove();

    $(".chosen").chosenedge({
        width: "100%",
        disable_search_threshold: 5,
        allow_single_deselect: true
    });
    $('#client-search').chosensearch();

    var table = $('#dnsitems'),
        selects = $('select'),
        zones = selects.eq(0),
        clients = selects.eq(1),
        products = selects.eq(2),
        alerts = $('#alerts');

    zones.on('change', function () {
        var localset = true,
            warn = [];

        zones.children(':selected').each(function () {
            var self = $(this),
                local = self.data('local');

            if (local) {
                if (localset) {
                    localset = false

                    if (clients.val() != local.client_id)
                        clients.data('chosensearch').set(local.client_id, '#' + local.client_id);

                    if (products.val() != local.product_id)
                        products.val(local.product_id).trigger('chosen:updated');
                }
                warn.push('<span>' + self.text() + ' (<a href="?cmd=accounts&action=edit&id=' + local.account_id + '">#' + local.account_id + '</a>)</span>');
            }
        })

        alerts.hide().children('.list').empty();
        if (warn.length) {
            alerts.show().children('.list').html(warn.join(', '));
        }
    });

    

    function importOne() {

        var data = selects.serializeObject(),
            index = data.product + '_' + data.client,
            html = '<tr data-index="' + index + '"><td>';

        var msg = [];
        if (!data.zones)
            msg.push('Select at last one zone to import!')

        if (!data.client)
            msg.push('Select target client!');

        if (!data.product)
            msg.push('Select target product!')

        if (msg.length) {
            alert(msg.join("\n"));
            return false;
        }

        if (typeof data.zones == 'string')
            data.zones = [data.zones];

        var names = [],
            product = products.find('[value="' + data.product + '"]');

        for (var i = 0, l = data.zones.length; i < l; i++) {
            var zone = data.zones[i];
            if (!zone.length)
                continue;

            var opt = zones.children('[value="' + zone + '"]');
            if (!opt.length)
                continue;
            var name = opt.text();
            names.push(name);
            opt.prop('disabled', true).attr('dsabled', 'disabled');

            html += '<input type="hidden" name="import[' + index + '][zone][' + name + ']" value="' + zone + '" />';
        }

        html += '<input type="hidden" name="import[' + index + '][client]" value="' + data.client + '" />';
        html += '<input type="hidden" name="import[' + index + '][product]" value="' + data.product + '" />';

        html += '<code>' + names.join('</code>, <code>') + '</code>';
        html += '</td><td>' + (clients.children('[value="' + data.client + '"]').text() || data.client)
        html += '</td><td>' + (product.parent().attr('label') + ' - ' + product.text() || data.product)
        html += '</td><td><a class="rem btn btn-default btn-sm" href="#rem" >Remove</a></td></tr>'

        selects.val('').trigger('chosen:updated');
        table.prepend(html);

        return false;
    }

    function importAll(type, data) {
        var list = {
            default: {
                client: data.client,
                product: data.product,
                zones: []
            }
        },
        data = selects.serializeObject();
        type = type || 1;

        $("#zones option").each(function () {
            var self = $(this),
                value = self.val(),
                local = self.data('local');

            if (!local || type == 1) {
                list.default.zones.push(value);
                return;
            }

            if (!list[local.account_id])
                list[local.account_id] = {
                    client: type == 2 ? local.client_id : data.client,
                    product: type == 3 ? local.product_id : data.product,
                    zones: []
                };
            list[local.account_id].zones.push(value)
        })
        $.each(list, function () {
            products.val(this.product);
            clients.val(this.client);
            zones.val(this.zones)
            importOne();
        })
        return false;
    }

    $('#add-all').click(function () {
        var data = selects.serializeObject(),
            msg = [];

        if (!data.client)
            msg.push('Select target client!');

        if (!data.product)
            msg.push('Select target product!')

        if (msg.length) {
            alert(msg.join("\n"));
            return false;
        }

        var dialog, devices, ports;
        dialog = bootbox.dialog({
            message: $('#import-all').html(),
            title: 'Import zones',
            buttons: {
                cancel: {
                    label: 'Cancel',
                    className: 'btn-defaultr'
                },
                confirm: {
                    label: 'Add Zones',
                    className: 'btn-success',
                    callback: function (e) {
                        var type = $('input:checked', dialog);
                        importAll(type.val(), data)
                        return true;
                    }
                }
            }
        });
        return false;
    });
    
    $('#add').click(importOne);

    table.on('click', '.rem', function () {
        var self = $(this),
            tr = self.parents('tr:first'),
            zonein = tr.find('input[name*=zone]');

        zonein.each(function () {
            var value = $(this).val();
            zones.children('[value="' + value + '"]').prop('disabled', false).removeAttr('dsabled');
        })

        tr.remove();
        zones.trigger('chosen:updated');
        return false;
    })
})

function statusreload(progress) {
    if(!progress || !progress.hasOwnProperty('percent'))
        return;
    
    if (document.readyState !== "complete") {
        return setTimeout(function () {
            statusreload(progress);
        }, 100);
    }

    console.log(progress);
    $('.progress-bar').css({width: Math.max(progress.percent, 1) + '%'});

    if (progress.steps === progress.done) {
        $('.progress-bar').removeClass('active').addClass('progress-bar-success');
        return;
    } else {
        $('.progress-bar').addClass('active');
    }
    setTimeout(function () {
        $.get(window.location.href, function (data) {
            if (data && data.length < 100)
                return;

            $('#result').html(data)
        })
    }, 3000);
}
