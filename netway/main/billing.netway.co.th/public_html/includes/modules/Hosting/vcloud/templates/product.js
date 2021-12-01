function onapp_showloader() {
    $('.onapptab:visible').find('.onapp-preloader').slideDown();
}

function onapp_hideloader() {
    $('.onapptab:visible').find('.onapp-preloader').slideUp();

}

function lookforsliders() {

    var pid = $('#product_id').val();
    $('.formchecker').off('click.sliders').on('click.sliders', function () {
        var self = $(this),
            tr = self.closest('tr, .formcheck'),
            rel = self.attr('rel').replace(/[^a-zA-Z0-9-_]/g, '');

        if (!self.is(':checked')) {
            if (!confirm('Are you sure you want to remove related Form element? ')) {
                return false;
            }
            if ($('#configvar_' + rel).length) {
                ajax_update('?cmd=configfields&make=delete', {
                    id: $('#configvar_' + rel).val(),
                    product_id: pid
                }, '#configeditor_content');
            }
            //remove related form element
            tr.find('.tofetch')
                .removeClass('fetched')
                .removeClass('disabled');

            tr.removeClass('formcheck-enabled')
                .find('input[id], select[id]').eq(0)
                .prop('disabled', false)
                .show();

            load_onapp_section(self.parents('div.onapptab').eq(0).attr('id').replace('_tab', ''));
            self.parents('span').eq(0).find('a.editbtn').remove();

        } else {

            tr.addClass('formcheck-enabled')
                .find('input[id], select[id]').eq(0)
                .prop('disabled', true)
                .hide();

            onapp_showloader();

            $.post('?cmd=vcloud&action=productdetails', {
                make: 'importformel',
                variableid: rel,
                cat_id: $('#category_id').val(),
                other: $('input, select', '#onapptabcontainer').serialize(),
                data: self.data(),
                id: pid,
                server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
            }, function (data) {
                var r = parse_response(data);
                if (r) {
                    self.parents('span').eq(0).append(r);
                    onapp_hideloader();
                    ajax_update('?cmd=configfields', {product_id: pid, action: 'loadproduct'}, '#configeditor_content');
                }
            });
        }
    }).each(function () {
        var self = $(this),
            rel = self.attr('rel').replace(/[^a-zA-Z0-9-_]/g, ''),
            form = $('#configvar_' + rel);

        if (form.length < 1 || self.siblings('.orspace').length)
            return 1;

        self.attr('checked', 'checked')
        var fid = form.val(),
            tr = self.parents('tr, .formcheck').eq(0);

        tr.addClass('formcheck-enabled')
            .find('input[id], select[id]')
            .eq(0).hide();

        tr.find('.tofetch')
            .addClass('disabled');

        self.parents('span').eq(0)
            .append(' <a href="#" onclick="return editCustomFieldForm(' + fid + ',' + pid + ')" class="editbtn orspace">Edit related form element</a>');
    });
}

function refetch() {
    $('#profilecontainer').removeClass('fetched');
    return load_onapp_section('vdc');
}

function load_onapp_section(section) {

    if (!$('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()) {
        alert('Please configure & select server first');
        return;
    }

    var tab = $('#' + section + '_tab');
    if (!tab.length)
        return false;
    var elements = tab.find('.tofetch').not('.fetched').not('.disabled');
    if (!elements.length)
        return false;
    tab.find('.onapp-preloader').show();
    elements.each(function (e) {
        var el = $(this);
        var inp = el.find('input[id], select[id]').eq(0);
        if (inp.is(':disabled')) {
            if ((e + 1) == elements.length) {
                tab.find('.onapp-preloader').slideUp();
            }
            return 1; //continue;

        }

        var vlx = inp.val(),
            vl = inp.attr('id') + "=" + vlx;

        if (vlx != null && vlx.constructor == Array) {
            vl = inp.serialize();
        }

        $.post('?cmd=vcloud&action=productdetails&' + vl, {
            make: 'getonappval',
            id: $('#product_id').val(),
            cat_id: $('#category_id').val(),
            other: $('input, select', '#onapptabcontainer').serialize(),
            opt: inp.attr('id'),
            server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
        }).done(function (data) {
            var r = parse_response(data);
            if (typeof (r) == 'string') {
                $(el).addClass('fetched');
                el.html(r);

                lookforsliders(el);
                el.find('.vtip_description').vTip();
            }
            $('#onappconfig_').trigger('getval');
        });

    });
    return false;
}

function singlemulti() {
    $('#step-1').show();
    if ($('#single_vm').is(':checked')) {
        $('tr.odesc_single_vm').find('.tofetch').removeClass('disabled');
        $('tr.odesc_cloud_vm td').find('.tofetch').addClass('disabled');
        $('#option14').val(1);
        $('#option19').val('No');
    } else {
        $('tr.odesc_cloud_vm').find('.tofetch').removeClass('disabled');
        $('tr.odesc_single_vm').find('.tofetch').addClass('disabled');
    }
}

function bindsteps() {
    $('a.next-step').click(function () {
        $('.breadcrumb-nav a.active').removeClass('active').parent().next().find('a').click();
        return false;
    });
    $('a.prev-step').click(function () {
        $('.breadcrumb-nav a.active').removeClass('active').parent().prev().find('a').click();
        return false;
    });
    $('#serv_picker input[type=checkbox]').click(function () {
        if ($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
            $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
        else
            $('#onappconfig_ .breadcrumb-nav a').addClass('disabled');

    });
}

function append_onapp() {
    $('#onappconfig_').TabbedMenu({
        elem: '.onapptab',
        picker: '.breadcrumb-nav a',
        aclass: 'active',
        picker_id: 'nan1'
    });

    $('.onapp_opt input[type=radio]:checked').click();
    lookforsliders();

    $(document).ajaxStop(function () {
        $('.onapp-preloader').hide();
    });

    bindsteps();

    if ($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val())
        $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');

    var netopt = $('#network_opt');
    netopt.on('change', function () {
        $('.netopt').hide().filter('.net-' + netopt.val()).show();
    }).trigger('change');

    $('#orgnet').on('change', function () {
        var net = $('#networks');
        net.prop('required', this.checked).prop('min', this.checked ? 1 : 0);
        if (net.val() < 1)
            net.val(1);
    }).trigger('change');

    var units = $('#unitcpu, #unitmemory, #unitstorage');

    units.on('change', function () {
        $('.' + this.getAttribute('id')).text(this.selectedOptions[0].text);
    }).trigger('change');

    $('#vcpuenabled').on('change', function () {
        $('.vcpu').hide().filter(this.checked ? '.vcpu-enabled' : '.vcpu-disabled').show();
    }).trigger('change');

    $('#onappconfig_').on('getval', function () {
        units.trigger('change');
    })
}
