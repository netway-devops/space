var virtualizor = new (function ($, window, document, undefined) {
    var root = this;
    var isVPS = true;

    this.showloader = function () {
        $('.onapptab:visible').find('.onapp-preloader').slideDown();
    };

    this.hideloader = function () {
        $('.onapptab:visible').find('.onapp-preloader').slideUp();
    };

    this.lookforsliders = function () {
        var pid = $('#product_id').val()

        $('.formchecker').click(function () {
            var self = $(this),
                tr = self.parents('tr, .formcheck').eq(0),
                rel = self.attr('rel').replace(/[^a-zA-Z0-9\-_]/g, '');

            if (rel == 'os2' || rel == 'os1')
                rel = 'os';

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
                tr.find('.tofetch').removeClass('fetched').removeClass('disabled');
                tr.find('input[id], select[id]').eq(0).removeAttr('disabled', 'disabled').show();

                root.load_section(self.parents('div.onapptab').eq(0).attr('id').replace('_tab', ''));
                self.parents('span').eq(0).find('a.editbtn').remove();
            } else {
                //add related form element
                var self = $(this),
                    rel = self.attr('rel');

                tr.find('input[id], select[id]').eq(0).attr('disabled', 'disabled').hide();
                root.showloader();

                $.post('?cmd=services&action=product', {
                    make: 'importformel',
                    variableid: rel,
                    cat_id: $('#category_id').val(),
                    other: $('input, select', '#onapptabcontainer').serialize(),
                    id: pid,
                    server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val()
                }, function (data) {
                    var r = parse_response(data);
                    if (r) {
                        self.parents('span').eq(0).append(r);
                        root.hideloader();

                        ajax_update('?cmd=configfields', {
                            product_id: pid,
                            action: 'loadproduct'
                        }, '#configeditor_content');
                    }
                });
            }
        }).each(function () {
            var self = $(this),
                rel = self.attr('rel').replace(/[^a-zA-Z0-9\-_]/g, '');

            if (rel == 'os2' || rel == 'os1')
                rel = 'os';
            var form = $('#configvar_' + rel);

            if (form.length < 1 || self.siblings('.orspace').length)
                return 1;

            self.attr('checked', 'checked')
            var fid = form.val(),
                tr = self.parents('tr, .formcheck').eq(0);

            tr.find('input[id], select[id]')
                .eq(0).hide();

            tr.find('.tofetch').addClass('disabled');
            self.parents('span').eq(0)
                .append(' <a href="#" onclick="return editCustomFieldForm(' + fid + ',' + pid + ')" class="editbtn orspace">Edit related form element</a>');

        }).filter('.osloader').each(function () {
            if ($('#configvar_os').length < 1)
                return 0;
            var fid = $('#configvar_os').val();
            $(this).parents('span').eq(0).append(' <a href="#" onclick="return virtualizor.updateOSList(' + fid + ')" class="editbtn orspace">Update template list from server</a>');
        });
    };

    this.updateOSList = function (fid) {
        this.showloader();
        $.post('?cmd=services&action=product&make=updateostemplates', {
            id: $('#product_id').val(),
            cat_id: $('#category_id').val(),
            other: $('input, select', '#onapptabcontainer').serialize(),
            server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val(),
            fid: fid
        }, function (data) {
            parse_response(data);
            editCustomFieldForm(fid, $('#product_id').val());
        });
        return false;
    };

    this.load_section = function (section) {

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

        if ($('#product_id').val() === 'new' || isNaN(parseInt($('#product_id').val())) || $('#saved_module').val() == '0') {
            alert('You have to save this product before you can continue to the next step');
            return false;
        }

        elements.each(function (e) {
            var el = $(this);
            var inp = el.find('input[id], select[id]').eq(0);

            if (inp.is(':disabled')) {
                if ($('[name^="' + inp.attr('name') + '"]').length < 2) {
                    if ((e + 1) == elements.length) {
                        tab.find('.onapp-preloader').slideUp();
                    }
                    return 1; //continue;
                }
            }

            if ($('[name^="' + inp.attr('name') + '"]').length < 2) {
                var vlx = inp.val();
                var vl = "options[" + inp.attr('id') + "]=" + vlx;
                if (vlx != null && vlx.constructor == Array) {
                    vl = inp.serialize();
                }
            } else {
                var vl = $('[name^="' + inp.attr('name') + '"]').serialize();
            }

            tab.find('.onapp-preloader').show();
            $.post('?cmd=services&action=product&' + vl,
                {
                    make: 'loadoptions',
                    id: $('#product_id').val(),
                    cat_id: $('#category_id').val(),
                    opt: inp.attr('id'),
                    server_id: $('#serv_picker input[type=checkbox][name]:checked:eq(0)').val(),
                    types: isVPS ? $('#option1').val() : $('#allowedvpstypes').val()
                }, function (data) {
                    var r = parse_response(data);
                    if (typeof (r) == 'string') {
                        $(el).addClass('fetched');
                        var id = $('.onapp_opt input[type=radio]:checked').attr('id');
                        el.html(r).find('.odesc_').hide().end().find('.odesc_' + id, r).show();
                        root.filter_types();
                        $(document).trigger('provisionchange', id);
                    }
                }
            );
        });
        return false;
    };

    this.singlemulti = function (ini, root) {
        $('#step-1').show();

        if (isVPS) {
            $('tr.odesc_single_vm').find('.tofetch').removeClass('disabled');
            $('tr.odesc_cloud_vm td').find('.tofetch').addClass('disabled');
        } else {
            $('tr.odesc_cloud_vm').find('.tofetch').removeClass('disabled');
            $('tr.odesc_single_vm').find('.tofetch').addClass('disabled');
        }
    };

    this.bindsteps = function () {
        $('a.next-step').click(function () {
            $('.breadcrumb-nav a.active').removeClass('active').parent().next().find('a').click();
            return false;
        });
        $('a.prev-step').click(function () {
            $('.breadcrumb-nav a.active').removeClass('active').parent().prev().find('a').click();
            return false;
        });
        $('#serv_picker input[type=checkbox]').click(function () {
            if ($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val() && $('#product_id').val() != 'new' && !isNaN(parseInt($('#product_id').val())) && $('#saved_module').val() == '1')
                $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
            else
                $('#onappconfig_ .breadcrumb-nav a').addClass('disabled');

        });
    };

    this.append = function () {
        $('#onappconfig_').TabbedMenu({
            elem: '.onapptab',
            picker: '.breadcrumb-nav a',
            aclass: 'active',
            picker_id: 'nan1'
        });

        var oopts = $('.onapp_opt');

        $('input[type=radio]', oopts).click(function (e) {
            var self = $(this),
                id = self.attr('id');

            isVPS = self.attr('id') === 'single_vm';
            oopts.removeClass('onapp_active');
            $('.odesc_').hide().filter('.odesc_' + id).show();

            self.parents('div').eq(0).addClass('onapp_active');
            root.filter_types();

            $(document).trigger('provisionchange', id);
        });

        root.filter_types();
        $('input[type=radio]:checked', oopts).click();

        this.lookforsliders();
        $(document).ajaxStop(function () {
            $('.onapp-preloader').hide();
        });

        this.bindsteps();
        if ($('#serv_picker input[type=checkbox][name]:checked:eq(0)').val() && $('#product_id').val() != 'new' && !isNaN(parseInt($('#product_id').val())) && $('#saved_module').val() == '1') {
            $('#onappconfig_ .breadcrumb-nav a').removeClass('disabled');
        }

    };

    this.filter_types = function () {
        var type = $('#vpstype'),
            types = $('#vpstypes'),
            plan = $('#vpsplan'),
            servers = $('#server'),
            opts = $('.type_opt');

        opts.hide();
        types.prop('disabled', isVPS);
        type.prop('disabled', !isVPS);

        $('#vpstypeplanscontainer options').prop('disabled', isVPS);
        plan.prop('disabled', !isVPS);

        if (isVPS) {

            var virttype = type.val(),
                typeopts = opts.filter('.opt_' + virttype);

            typeopts.show();
            //os templates
            if (!$('#option4 .opt_' + virttype + ' option:selected').length) {
                $('select#option4').val('');
            }

            var enabled = [];
            if ($('.type_opt option', '#vpsplan, #server').length > 0) {

                $('option', type).each(function () {
                    var self = $(this),
                        virttype = self.val();

                    if (!self.is(':selected') && !$('.opt_' + virttype + ' option', '#vpsplan, #server').length) {
                        self.attr('disabled', 'disabled').prop('disabled', true);
                    } else {
                        enabled.push(self.val());
                        if (self.is(':disabled'))
                            self.removeAttr('disabled').prop('disabled', false);
                    }

                    if (!$('.opt_' + virttype, plan).length && $('.opt_' + virttype, servers).length > 0) {
                        plan.append('<optgroup label="' + self.text() + '" class="opt_' + virttype + '"><option value="">--none--</option></optgroup>');
                    }
                });
            }
            if (!type.val() && enabled.length)
                type.val(enabled.pop())
        } else {
            type.prop('disabled', true);
            var selected = [];
            $('option', types).each(function (i) {
                var option = $(this),
                    virttype = option.val();

                if (option.is(':selected')) {
                    var match = opts.filter('.opt_' + virttype);
                    match.show();
                    selected.push(virttype);
                    return;
                }

                option.prop('disabled', !$('.opt_' + virttype + ' option', '#vpsplan, #server').length);
            });

            if(selected.length === 0){
                opts.filter('.opt_none').show();
            }
        }
    }
})(jQuery, window, document);


if (typeof (HBTestingSuite) == 'undefined')
    var HBTestingSuite = {};

HBTestingSuite.product_id = $('#product_id').val();
HBTestingSuite.initTest = function () {
    virtualizor.showloader();
    ajax_update('?cmd=testingsuite&action=beginsimpletest', {
        product_id: this.product_id,
        pname: $('form#productedit input[name=name]').val()
    }, '#testconfigcontainer');
    //$.facebox({ ajax: "?cmd=testingsuite&action=beginsimpletest&product_id="+this.product_id+"&pname="+name,width:700,nofooter:true,opacity:0.8,addclass:'modernfacebox' });
    return false;
};

$(document).bind('provisionchange', function (e, id) {
    $('select.disable_').prop('disabled', true).attr('disabled', 'disabled');
    if (!$('.formchecker[rel="' + id + '"]:checked').length)
        $('select.disable_' + id).prop('disabled', false).removeAttr('disabled');
    else
        $('select.disable_' + id).hide();
    $('.disable_ select').prop('disabled', true).attr('disabled', 'disabled');
    $('.disable_' + id + ' select').prop('disabled', false).removeAttr('disabled');
});
