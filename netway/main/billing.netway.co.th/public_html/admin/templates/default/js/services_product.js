var zero_value = '{/literal}{0|price:$currency:false:false}{literal}';

function bindMe() {

    $('#newshelfnav').TabbedMenu({
        elem: '.sectioncontent',
        picker: '.list-1 li',
        aclass: 'active',
        picked: picked.main || 0
    });

    $('#newshelfnav').TabbedMenu({
        elem: '.subm1',
        picker: '.list-1 li',
        picked: picked.main || 0
    });

    $('#components_menu').TabbedMenu({
        elem: '.components_content',
        picker_id: "picked_subtab",
        picker: '.list-3 li',
        picked: picked.sub || 0
    });

    if (typeof latebindme == 'function') {
        latebindme();
    }

    var mainfunctions = {},
        modulefunctions = {},
        regnative = /\[native code\]/;

    for (var fn in window) {
        try {
            if (typeof window[fn] == 'function' && !regnative.test(window[fn].toString())) {
                mainfunctions[fn] = window[fn];
            }
        } catch (e) {
            // permissions denied
        }
    }

    function restoreFnFrom(modId) {
        var restore = modulefunctions[modId] || {};

        for (var othId in modulefunctions) {
            if (othId != modId) {
                for (var fn in modulefunctions[othId]) {
                    if (!restore.hasOwnProperty(fn) && mainfunctions.hasOwnProperty(fn)) {
                        window[fn] = mainfunctions[fn];
                    }
                }
            }
        }
        for (var fn in restore) {
            window[fn] = restore[fn];
        }
    }


    $('#module_config_container').on('change', '.modulepicker', function () {
        var self = $(this),
            context = self.closest('.module_config_tab'),
            moduleId = self.val();

        if (moduleId == 'new') {
            window.location = '?cmd=managemodules&action=hosting&do=inactive';
            return false;
        }

        var index = context.data('key')
        var param = $.extend($('.modulepicker').serializeForm(), {
            action: 'showmodule',
            module: moduleId,
            server_values: {},
            k: index
        });

        var target = $('.loadable', context);
        target.html('<div style="text-center"><img src="ajax-loading.gif" /></div>');
        $('#module_tab_pick_container .module_tab_pick')
            .eq(index).find('span').text(self.find('option:selected').text())

        var url = window.location.href.replace(/[&?]?action=[^&]*/, '')
        modulefunctions[moduleId] = {};

        $.post(url, param, function (data) {
            data = parse_response(data)
            target.html(data.length ? data : '')
            target.find('.vtip_description').vTip();

            for (var fn in window) {
                if (typeof window[fn] == 'function' && mainfunctions[fn] != window[fn] && !regnative.test(window[fn].toString())) {
                    modulefunctions[moduleId][fn] = window[fn];
                }
            }
            $('.single .elcc:checked, .category + .nested .elcc:checked', target).trigger('change');
            self.trigger('module-loaded')
        });

        param.action = 'serviceemails';
        $.post(url, param, function (data) {
            $('#service-emails').html(parse_response(data));
        });
    })

    $(document).on('click', '#module_tab_switcher .module_tab_pick', function (e) {
        e.preventDefault();

        var self = $(this),
            index = self.data('key');

        if (self.parent().is('.active'))
            return false;

        $('#module_tab_switcher .active').removeClass('active')
        self.parent().addClass('active');

        var tabs = $('#module_config_container .module_config_tab'),
            selected = tabs.eq(index);

        tabs.hide();
        selected.show();

        $('#module_tab_switcher input').val(index);
        $(document).ajaxSend(function (e, xhr) {
            xhr.setRequestHeader('X-HB-Prod-Module', index);
        });

        tabs.filter('.module-loaded').each(function () {
            var self = $(this),
                forms = self.find('.loadable').children().detach(),
                key = self.data('key');

            if (key === undefined)
                key = -1;

            self.data('module', forms)
            self.append($('<input class="module-values" name="module_values[' + key + ']" type="hidden" />').val(forms.find('select, input, textarea').serialize()))
            self.removeClass('module-loaded').addClass('module-unloaded')
        })

        if (selected.is('.module-unloaded')) {

            selected.find('.loadable').append(selected.data('module'))
            selected.addClass('module-loaded').removeClass('module-unloaded')
            selected.find('.module-values').remove()

            var moduleId = selected.find('.modulepicker').val();
            if (moduleId) {
                restoreFnFrom(moduleId);
            }

        } else {
            $('.modulepicker', selected).on('module-loaded', function () {
                selected.addClass('module-loaded')
            }).change();
        }
        return false;
    });

    //Server picker, check all / uncheck all
    $('#module_config_container').on('change updategroups', '.ui-ddown-list .grouped input', function () {
        var self = $(this).parent(),
            category = (self.is('.nested') ? self.prevAll('.category:first') : self),
            group = category.nextUntil('.category');

        if (self.is('.category')) {
            group.find('input').prop('checked', category.find('input').is(':checked'))
                .eq(0).trigger('updateprops')
        } else {
            category.find('input').prop('checked', !group.find('input:not(:checked)').length)
        }
    });

    //hide configuration and unselect servers
    $('#module_config_container').on('change updateprops', '.ui-ddown-list input.elcc', function () {
        var self = $(this), servers;
        if (!self.is(':checked'))
            return;

        servers = $('.ui-ddown-list .elcc:checked');
        if (!self.is('[data-noconfig]'))
            servers = servers.filter('[data-noconfig]');

        servers.not(this).prop('checked', false);
        $('.single .elcc, .category + .nested .elcc').trigger('updategroups');
        $('.product-module-config').toggle(!servers.filter('[data-noconfig]:checked').length);
    })

    //server picker, open / close
    $('#module_config_container').on('click', '.ui-ddown-default', function () {
        var picker = $(this).parent(),
            closer = picker.find('.editbtn');

        picker.find('.ui-ddown-list').show();
        var closePicker = function (e) {
            if (!closer.is(e.target) && (picker.is(e.target) || picker.has(e.target).length))
                return true;

            var text = picker.find('input.elcc:checked').map(function (e) {
                return $(this).parent().find('span').text();
            }).get().join(', ');

            picker.find('.ui-ddown-default').text(text);
            picker.find('.ui-ddown-list').hide();
            $(document).off('click', closePicker)
            closer.off(closePicker);
        }

        $(document).on('click', closePicker);
        closer.one(closePicker);
        return false;
    })


    function setupModulePicker(context) {
        $('.modulepicker', context).chosenedge({
            width: '100%',
            search_contains: true
        })
    }

    $('#module_config_container').on('click', '.module-connect', function () {
        var picker = $('<li><a class="module_tab_pick" href="">Additional App: <span>None</span></a></li>');
        var current = [];
        $('.modulepicker').each(function (n) {
            current[n] = $(this).val();
        });
        $('#module_tab_switcher').show();
        //ajax request for table
        var length = $('#module_tab_pick_container .module_tab_pick').length;
        picker.find('a').data('key', length)

        $.get('?cmd=services&action=loadextramodule', {k: length, c: current}, function (data) {
            $('#module_config_container').append(data);

            $('#module_tab_pick_container').append(picker)
                .find('.module_tab_pick:last').click();

            setupModulePicker($('#module_config_container .module_config_tab').eq(length));
        });
        return false;
    });

    setupModulePicker();

    $('#subproducts_op').chosenedge({
        width: '100%',
        search_contains: true,
    });

    var copybox = $('#import-tasks').bootboxform({
        callback: function (dialog, val) {
            $('input, select', this).each(function () {
                this.style.display="none";
                this.setAttribute('name', this.dataset['name']);
                $('#productedit').append(this);
            });
            saveProductFull();
        }
    });

    $('#premadeautomationswitch').on('click', function () {
        copybox.trigger('show');
        return false;
    });

    $('.domain-opt-toggle').on('change', function () {
        var self = $(this),
            state = self.find('input').is(':checked');
        self.next('.domain-opt-box').toggle(state)
            .find('input, select').prop('disabled', !state);
    }).trigger('change');
}

appendLoader('bindMe');


function selectalladdons() {
    if ($('#listAlreadyU').length) {
        for (var i = 0; i < $('#listAlreadyU')[0].options.length; i++) {
            $('#listAlreadyU')[0].options[i].selected = true;
        }
    }
}

function addItem(it) {
    var av = it == 'addon' ? '#listAvail' : '#listAvailU';
    var al = it == 'addon' ? '#listAlready' : '#listAlreadyU';
    var selIndex = $(av)[0].selectedIndex;
    if (selIndex < 0)
        return;
    for (var i = $(av)[0].options.length - 1; i >= 0; i--) {
        if ($(av)[0].options[i].selected) {
            $(al)[0].appendChild($(av)[0].options[i]);
        }
    }

    $(av)[0].selectedIndex = -1;
    $(al)[0].selectedIndex = -1;
}

function delItem(it) {
    var av = it == 'addon' ? '#listAvail' : '#listAvailU';
    var al = it == 'addon' ? '#listAlready' : '#listAlreadyU';
    var selIndex = $(al)[0].selectedIndex;
    if (selIndex < 0)
        return;
    for (var i = $(al)[0].options.length - 1; i >= 0; i--) {
        if ($(al)[0].options[i].selected) {
            $(av)[0].appendChild($(al)[0].options[i]);
        }
    }

    $(av)[0].selectedIndex = -1;
    $(al)[0].selectedIndex = -1;
}

function sh(element, showhide) {
    if ($(element).val() != 'text' && $(element).val() != 'checkbox') {
        $('#' + showhide).show();
    } else {
        $('#' + showhide).hide();
    }
}

function removeadd(which) {
    ajax_update('?cmd=services&action=addonseditor', {
        addon_id: which,
        product_id: $('#product_id').val(),
        module: $('#modulepicker').val(),
        make: 'removeconf'
    }, '#addonsditor_content');
    return false;
}

function addadd() {

    var data = $('#addnew_addons select').serialize();
    ajax_update('?cmd=services&action=addonseditor&' + data, {
        product_id: $('#product_id').val(),
        module: $('#modulepicker').val(),
        make: 'addconfig'
    }, '#addonsditor_content');
    return false;
}

function saveProductFull() {
    var confirm = $('.onsave-confirm');
    if (confirm.length) {
        bootbox.confirm(confirm.html(), function (result) {
            if (result)
                $('#productedit').submit();
            return true;
        });
        return false;
    }

    $('#productedit').submit();
    return false;
}

function check_i(element) {
    var td = $(element).parent();
    if ($(element).is(':checked'))
        $(td).find('.config_val').removeAttr('disabled');
    else
        $(td).find('.config_val').attr('disabled', 'disabled');
}

function add_message(gr, id, msg) {
    var sel = $('#' + gr + '_msg select');
    sel.find('option:selected').removeAttr('selected');
    sel.prepend('<option value="' + id + '">' + msg + '</option>').find('option').eq(0).attr('selected', 'selected');
    return false;
}


if (typeof (getFieldValues) != 'function') {
//function getFieldValues(//http://stackoverflow.com/questions/10069204/function-declarations-inside-if-else-statements
    window.getFieldValues = function (prod_id, el, addserver) {
        var context = el ? $(el).closest('.module_config_tab') : $('.module_config_tab.module-loaded'),
            index = context.data('key'),
            servers = $('input.elcc:checked', context),
            initmsg = servers.length ? '<i class="fa fa-spin fa-spinner"></i> Loading...' : 'Please select at least one app from the server list';

        var alert = bootbox.dialog({
            message: '<div class="text-center">' + initmsg + '</div>',
            size: 'large',
            backdrop: true,
            onEscape: true
        });

        $('.modal-body', alert).css("font-family", 'monospace');

        if (!servers.length)
            return false;

        var fields = $('input, select, textarea', context).serialize();
        $.post('index.php?cmd=services&action=showmodule&id=' + prod_id
            + '&getvalues=1&module=' + $('.modulepicker', context).val()
            + '&' + servers.serialize(),
            {fields: fields, k: index},
            function (data) {
                data = parse_response(data);
                if (data.length)
                    $('.loadable', context).html(data);

                var status = $('#getvaluesloader', context);
                $('.bootbox-body', alert).html(status.length && status.html()
                    || 'Can\'t verify connection, please test this from apps page');

                initAppDropdown(context);

                status.remove();
                typeof initItemConfCat === 'function' && initItemConfCat();
            }
        );
        return false;
    }
}

function initAppDropdown(contextNode) {
    $('select.module-loadable', contextNode).each(function () {
        $(this).chosenedge({
            width: this.multiple ? '100%' : 'auto',
            enable_split_word_search: true,
            search_contains: true,
            single_backstroke_delete: false
        }).next().css('min-width', '200px')
    })
}

function bindAppWithForms() {
    var pid = $('#product_id').val();
    var filter = /[^a-z0-9A-Z_\-]/g;

    initAppDropdown($('.module_config_tab.module-loaded'));

    $('.formchecker').unbind('click').click(function () {
        var self = $(this),
            context = self.closest('.module_config_tab'),
            index = context.data('key'),
            servers = $('input.elcc:checked', context);

        if (!servers.length) {
            alert('Please configure & select server first');
            return false;
        }


        var tr = self.parents('tr, .ftr').eq(0),
            rel = self.attr('rel').replace(filter, '');

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
            tr.find('.tofetch').removeClass('fetched').removeClass('disabled');
            tr.find('input, select').eq(0).removeAttr('disabled', 'disabled').show();
            $(this).parents('span').eq(0).find('a.editbtn').remove();
        } else {
            //tr.find('input, select').eq(0).attr('disabled', 'disabled').hide();
            NProgress.start();

            var fields = $('form#productedit').serialize();

            $.post('?cmd=services&action=showmodule&getvalues=1&' + servers.serialize(),
                {
                    no_test_connection: 1,
                    addformelement: self.attr('rel'),
                    variableid: rel,
                    id: pid,
                    k: index,
                    fields: fields,
                    module: $('.modulepicker', context).val(),
                }, function (data) {

                    var r = parse_response(data);
                    if (r) {
                        self.parents('span').eq(0).append(r);
                        NProgress.done();
                        ajax_update('?cmd=configfields', {
                            product_id: pid,
                            action: 'loadproduct'
                        }, '#configeditor_content');
                    }
                });
        }
    })
    /*
        //variables on basic templates are handled in ajax.configfields.tpl / initItemConfCat
    */

}


function addmultifield(elem, name) {
    $(elem).parent().find('span').append('<input name="options[' + name + '][]" value="" /><br />');
}

function switch_t2(el, id) {
    $('#priceoptions .billopt').removeClass('checked');
    $(el).addClass('checked');
    $('input[name=paytype]').removeAttr('checked').prop('checked', false);
    $('input#' + id).attr('checked', 'checked').prop('checked', true);
    if (id == 'recurx')
        $('input#recur').attr('checked', 'checked').prop('checked', true);
    $('.boption').hide();
    $('#recurx_b').hide();
    $('#' + id + '_b').show();
    $('#hidepricingadd').click();
    return false;
}

function saveOrder() {
    var sorts = $('div#serializeit input.ser').serialize();
    ajax_update('?cmd=configfields&action=changecatorder&' + sorts, {});
}
